#!/bin/bash

DOMAIN=*.kiwapentest.nl
COUNTRY=NL
STATE=Gelderland
LOCALITY=Apeldoorn
ORGANIZATION=Kiwa
OU=IT
EMAIL=administrator@kiwapentest.nl


# Create static DNS aliases for the cloudkey, edgerouter and edgeswitch before starting with this script.

function CreateCertificateAuthority {

	if [ -f ./rootCA.key ]; then rm ./rootCA.key; fi
	if [ -f ./rootCA.pem ]; then rm ./rootCA.pem; fi

	# Create the Root Key for the rootCA
	openssl genrsa -out rootCA.key 2048

	# Now self-sign this certificate using the root key.
	# I used a wildcard for the subdomains. The edgerouter might not work correctly with a wildcard.
	#
	# CN: CommonName
	# OU: OrganizationalUnit
	# O: Organization
	# L: Locality
	# S: StateOrProvinceName
	# C: CountryName
	#
	openssl req -x509 \
            -new \
            -nodes \
            -key rootCA.key \
            -sha256 \
            -days 3650 \
            -subj "/C=$COUNTRY/ST=$STATE/L=$LOCALITY/O=$ORGANIZATION/OU=$OU/CN=$DOMAIN/emailAddress=$EMAIL" \
            -reqexts v3_req \
	    -extensions v3_ca \
            -out rootCA.pem


	printf "\nNow install this cert (rootCA.pem) in your workstations Trusted Root Authority or the browser.\n"


}

function CreateServerCertificate {
	if [ -f ./$DOMAIN.key ]; then  rm ./$DOMAIN.key; fi
	if [ -f ./$DOMAIN.csr ]; then  rm ./$DOMAIN.csr; fi
	if [ -f ./$DOMAIN.crt ]; then  rm ./$DOMAIN.crt; fi

	#
	# Create A Certificate
	#
	echo "GENERATING CERTIFICATE"
	openssl genrsa -out $DOMAIN.key 2048

	#
	# Now generate the certificate signing request.
	#
	echo "generating the certificate signing request"
	openssl req -new \
            -key $DOMAIN.key \
            -subj "/C=$COUNTRY/ST=$STATE/L=$LOCALITY/O=$ORGANIZATION/OU=$OU/CN=$DOMAIN/emailAddress=$EMAIL" \
            -reqexts v3_req \
	    -extensions v3_ca \
            -out $DOMAIN.csr

	#
	# Now generate the final certificate from the signing request.
	# Note that the edgerouter didn't work well with a wildcard certificate, but the cloud key did.
	# In order for the self-signed certificate to work (in the browser), it needs to have a DNS resolvable TLD, 
	# even though it can be run in internal DNS
	#
	 echo "Generate final certificate" 
	 openssl x509 -req \
             -in $DOMAIN.csr \
             -CA rootCA.pem \
             -CAkey rootCA.key \
             -CAcreateserial \
             -extfile <(echo "subjectAltName=DNS:$DOMAIN") \
             -out $DOMAIN.crt -days 3650 -sha256

}

   CreateCertificateAuthority
   CreateServerCertificate


   
