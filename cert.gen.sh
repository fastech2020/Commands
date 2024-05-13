#!/bin/bash
pfxin=$1
pass=$2
filename=$(echo $pfxin | cut -d '.' -f1)
if [ -d cert ]; then
echo 'cert dir is there..'
else
mkdir cert
fi
if [ -d decrypt_key ]; then
echo 'decrypt_key dir is there..'
else
mkdir decrypt_key
fi
if [ -d encrypt_key ]; then
echo 'encrypt_key dir is there..'
else
mkdir encrypt_key
fi
openssl pkcs12 -in $pfxin -clcerts -nokeys -out ./cert/$filename.crt -password pass:$pass
openssl pkcs12 -in $pfxin -nocerts -out $filename.encrypted.key -password pass:$pass -passout pass:$pass
openssl rsa -in $filename.encrypted.key -out ./decrypt_key/$filename.decrypted.key -passin pass:$pass
openssl pkcs12 -in $pfxin -cacerts -nokeys -chain -passin pass:$pass | sed -ne '/-BEGIN CERTIFICATE-/,/-END C ERTIFICATE-/p' > ./cert/ca-root.crt
