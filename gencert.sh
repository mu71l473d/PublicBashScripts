#!/usr/bin/env bash

DOMAIN=*.example.org
COUNTRY=NL
STATE=SomeState
LOCALITY=Nothingdam
ORGANIZATION=example.org
OU=IT
EMAIL=administrator@example.org


# Create static DNS aliases for the cloudkey, edgerouter and edgeswitch before starting with this script.

function CreateCertificateAuthority {

	if [ -f ./ubntCA.key ]; then rm ./ubntCA.key; fi
	if [ -f ./ubntCA.pem ]; then rm ./ubntCA.pem; fi


	# Create the Root Key for the rootCA
	openssl genrsa -out ubntCA.key 2048

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
            -key ubntCA.key \
            -sha256 \
            -days 3650 \
            -subj "/C=$COUNTRY/ST=$STATE/L=$LOCALITY/O=$ORGANIZATION/OU=$OU/CN=$DOMAIN/emailAddress=$EMAIL" \
            -out ubntCA.pem


	printf "\nNow install this cert (ubntCA.pem) in your workstations Trusted Root Authority or the browser.\n"


}

function CreateServerCertificate {

	if [ -f ./server.key ]; then  rm ./server.key; fi
	if [ -f ./server.csr ]; then  rm ./server.csr; fi
	if [ -f ./server.crt ]; then  rm ./server.crt; fi

	#
	# Create A Certificate
	#
	openssl genrsa -out server.key 2048

	#
	# Now generate the certificate signing request.
	#
	openssl req -new \
            -key server.key \
            -subj "/C=$COUNTRY/ST=$STATE/L=$LOCALITY/O=$ORGANIZATION/OU=$OU/CN=$DOMAIN/emailAddress=$EMAIL" \
            -out server.csr

	#
	# Now generate the final certificate from the signing request.
	# Note that the edgerouter didn't work well with a wildcard certificate, but the cloud key did.
	# In order for the self-signed certificate to work (in the browser), it needs to have a DNS resolvable TLD, 
	# even though it can be run in internal DNS
	#
	 openssl x509 -req \
             -in server.csr \
             -CA ubntCA.pem \
             -CAkey ubntCA.key \
             -CAcreateserial \
             -extfile <(echo "subjectAltName=DNS:$DOMAIN") \
             -out server.crt -days 3650 -sha256

}

function CreateServerPem {
	#Edgerouter
	cat ubntCA.pem > server.pem
	cat server.crt >> server.pem
	cat server.key >> server.pem
	
	#kill the webserver and move the server.pem for the webGUI
	kill -SIGTERM $(cat /var/run/lighttpd.pid)
	mv /etc/lighttpd/server.pem /etc/lighttpd/server.pem.old
	
	#on the edgerouter the cert needs to be named server.pem
	cp server.pem /etc/lighttpd/
	
	#copy the required edgerouter files to the lighttpd server
	mkdir -p /config/auth/certificates 
	cp server.crt server.key ubntCA.crt ubntCA.key ubntCA.pem server.pem
	cd /config/auth/certificate
	/usr/sbin/lighttpd -f /etc/lighttpd/lighttpd.conf

}

function CreateCertcrt {
	#Cloudkey
	systemctl stop unifi
	#nginx runs the webserver at port 443, and the cloudkey (unifi service) itself uses 8443
	systemctl stop nginx
	
	# for the cloudkey the certs needs to be named cloudkey.* and a cert file called cert.crt. These run on the nginx webserver that hosts the settings. 
	# The cloudkey software itself uses the keystore cert that is added later.
	cp server.crt cloudkey.crt
	cp server.key cloudkey.key
	cp cloudkey.crt cert.crt
	cp cloudkey.key >> cert.crt
	
	# Copy the files
	if [! -d "/etc/ssl/private"]; then 
		mkdir -p /etc/ssl/private/ 
	fi
	
	cp cert.crt cloudkey.* /etc/ssl/private/
	systemctl start nginx
	systemctl status nginx

}

function ImportIntoJavaKeystore {
	#
	# UniFi Controller SSL Certificate Import Script for Unix/Linux Systems
	# Adapted from Steve Jenkins <http://www.stevejenkins.com/> by Rene Bisperink <http://mu71l473d.github.io/>
	#
	# REQUIREMENTS
	# 1) Assumes you have a UniFi Controller installed and running on your system.
	# 2) Assumes you already have a valid 2048-bit private key, signed certificate, and certificate authority
	#    chain file. The Controller UI will not work with a 4096-bit certificate. 
	#
	# KEYSTORE BACKUP
	# Even though this script attempts to be clever and careful in how it backs up your existing keystore,
	# it's never a bad idea to manually back up your keystore (located at $UNIFI_DIR/data/keystore on RedHat
	# and Cloudkey systems or /$UNIFI_DIR/keystore on Debian/Ubunty systems) to a separate directory before 
	# running this script. If anything goes wrong, you can restore from your backup, restart the UniFi Controller 
	# service, and be back online immediately.
	#
	
	# CONFIGURATION OPTIONS.
	UNIFI_HOSTNAME=$DOMAIN
	UNIFI_SERVICE=unifi

	# Uncomment following three lines for Fedora/RedHat/CentOS
	#UNIFI_DIR=/opt/UniFi
	#JAVA_DIR=${UNIFI_DIR}
	#KEYSTORE=${UNIFI_DIR}/data/keystore

	# Uncomment following three lines for Debian/Ubuntu
	#UNIFI_DIR=/var/lib/unifi
	#JAVA_DIR=/usr/lib/unifi
	#KEYSTORE=${UNIFI_DIR}/keystore

	# Uncomment following three lines for CloudKey
	UNIFI_DIR=/var/lib/unifi
	JAVA_DIR=/usr/lib/unifi
	KEYSTORE=${JAVA_DIR}/data/keystore

	# FOR LET'S ENCRYPT SSL CERTIFICATES ONLY
	# Generate your Let's Encrtypt key & cert with certbot before running this script
	LE_MODE=no
	LE_LIVE_DIR=/etc/letsencrypt/live

	# THE FOLLOWING OPTIONS NOT REQUIRED IF LE_MODE IS ENABLED
	PRIV_KEY=server.key
	SIGNED_CRT=server.crt
	CHAIN_FILE=ubntCA.pem

	# CONFIGURATION OPTIONS YOU PROBABLY SHOULDN'T CHANGE
	ALIAS=unifi
	PASSWORD=aircontrolenterprise

	#### SHOULDN'T HAVE TO TOUCH ANYTHING PAST THIS POINT ####

	printf "\nStarting UniFi Controller SSL Import...\n"

	# Check to see whether Let's Encrypt Mode (LE_MODE) is enabled

	if [[ ${LE_MODE} == "YES" || ${LE_MODE} == "yes" || ${LE_MODE} == "Y" || ${LE_MODE} == "y" || ${LE_MODE} == "TRUE" || ${LE_MODE} == "true" || ${LE_MODE} == "ENABLED" || ${LE_MODE} == "enabled" || ${LE_MODE} == 1 ]] ; then
		LE_MODE=true
		printf "\nRunning in Let's Encrypt Mode...\n"
		PRIV_KEY=${LE_LIVE_DIR}/${UNIFI_HOSTNAME}/privkey.pem
		CHAIN_FILE=${LE_LIVE_DIR}/${UNIFI_HOSTNAME}/fullchain.pem
	else
		LE_MODE=false
		printf "\nRunning in Standard Mode...\n"
	fi

	if [[ ${LE_MODE} == "true" ]]; then
		# Check to see whether LE certificate has changed
		printf "\nInspecting current SSL certificate...\n"
		if md5sum -c "${LE_LIVE_DIR}/${UNIFI_HOSTNAME}/privkey.pem.md5" &>/dev/null; then
			# MD5 remains unchanged, exit the script
			printf "\nCertificate is unchanged, no update is necessary.\n"
			exit 0
		else
		# MD5 is different, so it's time to get busy!
		printf "\nUpdated SSL certificate available. Proceeding with import...\n"
		fi
	fi

	# Verify required files exist
	if [[ ! -f ${PRIV_KEY} ]] || [[ ! -f ${CHAIN_FILE} ]]; then
		printf "\nMissing one or more required files. Check your settings.\n"
		exit 1
	else
		# Everything looks OK to proceed
		printf "\nImporting the following files:\n"
		printf "Private Key: %s\n" "$PRIV_KEY"
		printf "CA File: %s\n" "$CHAIN_FILE"
	fi

	# Create temp files
	P12_TEMP=$(mktemp)

	# Stop the UniFi Controller
	printf "\nStopping UniFi Controller...\n"
	service "${UNIFI_SERVICE}" stop

	if [[ ${LE_MODE} == "true" ]]; then
		
		# Write a new MD5 checksum based on the updated certificate	
		printf "\nUpdating certificate MD5 checksum...\n"

		md5sum "${PRIV_KEY}" > "${LE_LIVE_DIR}/${UNIFI_HOSTNAME}/privkey.pem.md5"
		
	fi

	# Create double-safe keystore backup
	if [[ -s "${KEYSTORE}.orig" ]]; then
		printf "\nBackup of original keystore exists!\n"
		printf "\nCreating non-destructive backup as keystore.bak...\n"
		cp "${KEYSTORE}" "${KEYSTORE}.bak"
	else
		cp "${KEYSTORE}" "${KEYSTORE}.orig"
		printf "\nNo original keystore backup found.\n"
		printf "\nCreating backup as keystore.orig...\n"
	fi
		 
	# Export your existing SSL key, cert, and CA data to a PKCS12 file
	printf "\nExporting SSL certificate and key data into temporary PKCS12 file...\n"

	#If there is a signed crt we should include this in the export
	if [[ -f ${SIGNED_CRT} ]]; then
		openssl pkcs12 -export \
		-in "${CHAIN_FILE}" \
		-in "${SIGNED_CRT}" \
		-inkey "${PRIV_KEY}" \
		-out "${P12_TEMP}" -passout pass:"${PASSWORD}" \
		-name "${ALIAS}"
	else
		openssl pkcs12 -export \
		-in "${CHAIN_FILE}" \
		-inkey "${PRIV_KEY}" \
		-out "${P12_TEMP}" -passout pass:"${PASSWORD}" \
		-name "${ALIAS}"
	fi
		
	# Delete the previous certificate data from keystore to avoid "already exists" message
	printf "\nRemoving previous certificate data from UniFi keystore...\n"
	keytool -delete -alias "${ALIAS}" -keystore "${KEYSTORE}" -deststorepass "${PASSWORD}"
		
	# Import the temp PKCS12 file into the UniFi keystore
	printf "\nImporting SSL certificate into UniFi keystore...\n"
	keytool -importkeystore \
	-srckeystore "${P12_TEMP}" -srcstoretype PKCS12 \
	-srcstorepass "${PASSWORD}" \
	-destkeystore "${KEYSTORE}" \
	-deststorepass "${PASSWORD}" \
	-destkeypass "${PASSWORD}" \
	-alias "${ALIAS}" -trustcacerts

	# Clean up temp files
	printf "\nRemoving temporary files...\n"
	rm -f "${P12_TEMP}"
		
	# Restart the UniFi Controller to pick up the updated keystore
	printf "\nRestarting UniFi Controller to apply the new certificate...\n"
	service "${UNIFI_SERVICE}" start
	

	# That's all, folks!
	printf "\nDone!\n"

	exit 0

}

   CreateCertificateAuthority
   CreateServerCertificate
   CreateServerPem
   CreateCertcrt
   ImportIntoJavaKeystore
   
