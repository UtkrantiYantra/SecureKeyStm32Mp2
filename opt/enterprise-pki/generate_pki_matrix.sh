#!/usr/bin/env bash
set -e

mkdir -p /opt/enterprise-pki/{certs,private,targets/{tf2_rotpk,fit_kernel,rauc_ota,app_store}}
cd /opt/enterprise-pki
touch index.txt
echo 1000 > serial

echo "[PKI] Generating corporate Root CA (Offline Master Base)..."
openssl genpkey -algorithm RSA -pkeyopt rsa_keygen_bits:4096 -out private/root-ca.key.pem
openssl req -config openssl_pki.cnf -x509 -new -nodes -key private/root-ca.key.pem \
    -days 7300 -md sha256 -out certs/root-ca.pem -extensions v3_root_ca \
    -subj "/C=IN/ST=UttarPradesh/L=Noida/O=Utkranti Yantra/CN=Utkranti Secure Root CA"

echo "[PKI] Generating Platform Boot Sub-CA..."
openssl genpkey -algorithm RSA -pkeyopt rsa_keygen_bits:4096 -out private/platform-subca.key.pem
openssl req -config openssl_pki.cnf -new -nodes -key private/platform-subca.key.pem \
    -out certs/platform-subca.csr -subj "/C=IN/ST=UttarPradesh/L=Noida/O=Utkranti Yantra/CN=Platform Boot Sub-CA"
openssl ca -config openssl_pki.cnf -batch -extensions v3_platform_subca -days 3650 \
    -in certs/platform-subca.csr -out certs/platform-subca.pem

echo "[PKI] Generating Application Sub-CA..."
openssl genpkey -algorithm RSA -pkeyopt rsa_keygen_bits:4096 -out private/app-subca.key.pem
openssl req -config openssl_pki.cnf -new -nodes -key private/app-subca.key.pem \
    -out certs/app-subca.csr -subj "/C=IN/ST=UttarPradesh/L=Noida/O=Utkranti Yantra/CN=Application Store Sub-CA"
openssl ca -config openssl_pki.cnf -batch -extensions v3_app_subca -days 3650 \
    -in certs/app-subca.csr -out certs/app-subca.pem

echo "[PKI] Generating Hardware ROM ROTPK keys (ECDSA P-256)..."
for i in {0..3}; do
    openssl ecparam -name prime256v1 -genkey -noout -out targets/tf2_rotpk/rotpk_priv${i}.key
    openssl req -new -nodes -key targets/tf2_rotpk/rotpk_priv${i}.key \
        -out targets/tf2_rotpk/rotpk_req${i}.csr -subj "/C=IN/O=Utkranti Yantra/CN=Platform Root Key ${i}"
    openssl ca -config openssl_pki.cnf -batch -days 3650 -in targets/tf2_rotpk/rotpk_req${i}.csr \
        -out targets/tf2_rotpk/rotpk_cert${i}.pem
done

echo "[PKI] Generating FIT Kernel Signing credentials (RSA-4096)..."
openssl genpkey -algorithm RSA -pkeyopt rsa_keygen_bits:4096 -out targets/fit_kernel/prod_fit_sign.key
openssl req -new -x509 -key targets/fit_kernel/prod_fit_sign.key -out targets/fit_kernel/prod_fit_sign.crt \
    -days 3650 -subj "/C=IN/O=Utkranti Yantra/CN=FIT Kernel Production Signer"

echo "[PKI] Generating RAUC OTA Verification Assets (RSA-4096)..."
openssl genpkey -algorithm RSA -pkeyopt rsa_keygen_bits:4096 -out targets/rauc_ota/rauc_updater.key
openssl req -new -x509 -key targets/rauc_ota/rauc_updater.key -out targets/rauc_ota/rauc_updater.crt \
    -days 3650 -subj "/C=IN/O=Utkranti Yantra/CN=RAUC OTA Production Signer"

echo "[PKI] Generating Application Store Signature Assets (Ed25519)..."
openssl genpkey -algorithm Ed25519 -out targets/app_store/app_signer.key
openssl pkey -in targets/app_store/app_signer.key -pubout -out targets/app_store/app_signer.pub

echo "[PKI] Key generation sequence completed."
