rm *.pem
# 1. Generate CA's private key and self-signed certificate
openssl req -x509 -newkey rsa:4096 -days 365 -keyout ca-key.pem -out ca-cert.pem -subj "/C=IN/ST=UP/L=Noida/O=Company123/OU=Education/CN=*.ayush.com/emailAddress=email@org.com"
# Use -nodes option in above command to skip passphrase 

echo "CA's self-signed certificate"
openssl x509 -in ca-cert.pem -noout -text

# 2. Generate web server's private key and certificate signing request (CSR)
openssl req -newkey rsa:4096 -keyout server-key.pem -out server-req.pem -subj "/C=IN/ST=Karnataka/L=Banglore/O=PC Serv/OU=Computer/CN=*.compServ.com/emailAddress=compServ@org.com"
# Use -nodes option in above command to skip passphrase 

# 3. Use CA's private key to sign web server's CSR and get back the signed cerificate
openssl x509 -req -in server-req.pem -CA ca-cert.pem -CAkey ca-key.pem -CAcreateserial -out server-cert.pem

echo "Server's signed certificate"
openssl x509 -in server-cert.pem -noout -text

# To run this script use: ./gen.sh 

# To verify if this certificate is valid or not use command:-
# openssl verify -CAfile ca-cert.pem server-cert.pem