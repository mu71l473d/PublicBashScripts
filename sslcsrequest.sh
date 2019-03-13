#!/bin/bash
DOMAIN=www.example.org
COUNTRY=NL
STATE=Overijssel
LOCALITY=Enschede
ORGANIZATION=example.og
OU=IT
EMAIL=administrator@example.org


# TODO: Improvements that can be added in the future: It is better to pass the password through an ENV  
# variable or a text file than hardcoding the password in this script. Put a "set -ex" in the beginning, 
# otherwise the script will continue running even if there should be something changed in the commands. 
# Run the script in a directory instead of randomly. If there isn't a default folder set up, the script will use a default directory. 

#optional to add a password
PASSWORD=mypassword #TODO


if( -z "$1" ) 
then
PASSWORD=mypassword
else
PASSWORD=$1
fi

#generate a key
openssl genrsa -aes256 -passout pass:$PASSWORD -out $DOMAIN.key 4096 -noout

#Remove passphrase from the key. Comment the line out to keep the passphrase
#echo "Removing passphrase from key"
#openssl rsa -in $DOMAIN.key -passin pass:$PASSWORD -out $DOMAIN.key



#Create the request
echo "Creating CSR"
openssl req -new -key $DOMAIN.key -out $DOMAIN.csr -passin pass:$PASSWORD \
    -subj "/C=$COUNTRY/ST=$STATE/L=$LOCALITY/O=$ORGANIZATION/OU=$OU/CN=$DOMAIN/emailAddress=$EMAIL" #TODO: Add a default folder

#assign rights
chmod 600 *.key *.csr 


echo "---------------------------"
echo "-----Below is your CSR-----"
echo "---------------------------"
echo
cat $DOMAIN.csr
 
echo
echo "---------------------------"
echo "-----Below is your Key-----"
echo "---------------------------"
echo
cat $DOMAIN.key


echo "Now backup the csr and the key in a safe location!"
echo "The default location is /opt/certs, but they should be moved to a different location."
