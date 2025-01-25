#Create CA
openssl ^
req -new -x509 ^
-keyout ssl/ca-key ^
-out ssl/ca-cert ^
-days 365 ^
-nodes

#Create Server Keystore
keytool ^
-keystore ssl/kafka.server.keystore.jks ^
-alias kafka-server ^
-validity 3650 ^
-genkey ^
-keyalg RSA ^
-storepass foobaar ^
-keypass foobaar ^
-dname "CN= kafka-server"

#Create Client Keystore
keytool ^
-keystore ssl/kafka.client.keystore.jks ^
-alias kafka-client ^
-validity 3650 ^
-genkey ^
-keyalg RSA ^
-storepass foobaar ^
-keypass foobaar ^
-dname "CN= kafka-client"

#Create Certificate Signing Request for server
keytool ^
-keystore ssl/kafka.server.keystore.jks ^
-alias kafka-server ^
-storepass foobaar ^
-certreq ^
-file ssl/server-cert-file-request

#Create Certificate Signing Request for client
keytool ^
-keystore ssl/kafka.client.keystore.jks ^
-alias kafka-client ^
-storepass foobaar ^
-certreq ^
-file ssl/client-cert-file-request

#Create signed certificate for server
openssl ^
x509 -req ^
-CA ssl/ca-cert ^
-CAkey ssl/ca-key ^
-in ssl/server-cert-file-request ^
-out ssl/server-cert-signed ^
-days 3650 ^
-CAcreateserial ^
-passin pass:foobaar

#Create signed certificate for client
openssl ^
x509 -req ^
-CA ssl/ca-cert ^
-CAkey ssl/ca-key ^
-in ssl/client-cert-file-request ^
-out ssl/client-cert-signed ^
-days 3650 ^
-CAcreateserial ^
-passin pass:foobaar

#Import CA certificates

#Import CA certificate to server keystore
keytool ^
-keystore ssl/kafka.server.keystore.jks ^
-alias CARoot ^
-storepass foobaar ^
-importcert ^
-file ssl/ca-cert 

#Import CA certificate to client keystore
keytool ^
-keystore ssl/kafka.client.keystore.jks ^
-alias CARoot ^
-storepass foobaar ^
-importcert ^
-file ssl/ca-cert 

# Import CA certificate to server truststore
keytool ^
-keystore ssl/kafka.server.truststore.jks ^
-alias CARoot ^
-storepass foobaar ^
-importcert ^
-file ssl/ca-cert 

#Import CA certificate to client truststore
keytool ^
-keystore ssl/kafka.client.truststore.jks ^
-alias CARoot ^
-storepass foobaar ^
-importcert ^
-file ssl/ca-cert 

#Import signed certificates

#Import server signed certificate to server keystore
keytool ^
-keystore ssl/kafka.server.keystore.jks ^
-alias kafka-server ^
-storepass foobaar ^
-importcert ^
-file ssl/server-cert-signed

#Import client signed certificate to client keystore
keytool ^
-keystore ssl/kafka.client.keystore.jks ^
-alias kafka-client ^
-storepass foobaar ^
-importcert ^
-file ssl/client-cert-signed   

#Kafka COnsole producer
#kafka-console-producer --bootstrap-server localhost:9093 --topic my_topic --producer.config F:\\Data\\config\\client.properties

#Console consumer
#kafka-console-consumer --bootstrap-server localhost:9093 --topic my_topic --consumer.config F:\\Data\\config\\client.properties

# ACL RULE FORMAT  “Principal P is [Allowed/Denied] Operation O From Host H on any Resource R matching ResourcePattern RP”

#kafka-acls --bootstrap-server localhost:9093 -command-config ./../../secrets/certs.properties --add -deny-principal "User:CN=kafka-client" --operation Read --operation Write --operation Create --topic purchases1
#kafka-acls --bootstrap-server localhost:9093 -command-config ./../../secrets/certs.properties --add -allow-principal "User:CN=kafka-client" --operation Read --group '*'
#kafka-acls --bootstrap-server localhost:9093 -command-config ./../../secrets/certs.properties --add -allow-principal "User:CN=kafka-client" --operation Read --operation Write --operation Create --topic my_topic	