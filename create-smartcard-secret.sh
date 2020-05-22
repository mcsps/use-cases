#!/bin/sh
# Create K8S Secret from DT PKI

# refer
# * https://www.telesec.de/de/public-key-infrastruktur/support/root-zertifikate/category/203-interne-cas 
# * https://ldap-cpki.telekom.de/downloads.html
#
# COMPARE: Serialnumber and Fingerprint SHA with Certs on your Smart Card!!!!

curl -o root-ca1.der https://www.telesec.de/de/public-key-infrastruktur/support/root-zertifikate/category/93-deutsche-telekom-internal-root-ca-1?download=326:deutsche-telekom-internal-root-ca-1
openssl x509 -in root-ca1.der  -inform der  -out root-ca1.pem

curl -o issuer-02.der http://cpki.telekom.de/crt/Deutsche_Telekom_AG_Issuing_CA_02.crt
openssl x509 -in issuer-02.der -inform der -out issuer-02.pem

cat root-ca1.pem issuer-02.pem > crt.pem

kubectl -n demoapp delete secret ca-secret
kubectl -n demoapp create secret generic ca-secret --from-file=ca.crt=crt.pem
