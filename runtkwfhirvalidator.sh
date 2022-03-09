echo $PWD
echo "Running as UID $UID"
echo "trustStore = " $trustStore
echo "trustStorePassword = " $trustStorePassword
echo "keyStore = " $keyStore
echo "keyStorePassword = " $keyStorePassword
echo "Making sure output structure is available"
cd /home/service/data
tar -xvf /home/service/TKW/config/FHIR_IOMEDS/tkwoutputstructure.tar
cd /home/service

# set the external properties folder
export TKWROOT="/home/service/TKW"
echo TKWROOT: $TKWROOT
export FHIR_IOMEDS_ASSETS_ROOT="/home/service/fhir"
echo FHIR Assets directory: $FHIR_IOMEDS_ASSETS_ROOT
export TERMINOLOGY_SERVER_ACCESS_TOKEN_ROOT="/home/service/access_token"
echo Terminology ServerAccess Token directory: $TERMINOLOGY_SERVER_ACCESS_TOKEN_ROOT

# decide whether its TLSMA or not
if [ "$trustStore" == 'default' ]
then
	#ClearText
	java -version
	java -Djava.net.preferIPv4Stack=true -jar /home/service/TKW/TKW-x.jar -httpinterceptor /home/service/TKW/config/FHIR_IOMEDS/tkw-x_cleartext.properties
else
	#TLSMA
	java -Djava.net.preferIPv4Stack=true -Djavax.net.ssl.trustStore=$trustStore -Djavax.net.ssl.trustStorePassword=$trustStorePassword -Djavax.net.ssl.keyStore=$keyStore -Djavax.net.ssl.keyStorePassword=$keyStorePassword -jar /home/service/TKW/TKW-x.jar -httpinterceptor /home/service/TKW/config/FHIR_IOMEDS/tkw-x.properties
fi
