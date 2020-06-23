#!/bin/sh

kubectl delete secret core
# kubectl delete secret minio

mkdir -p secrets

TOKENS_SECRET="$(openssl rand -base64 32)"

echo "[grpc]
tls = false

[minio]
ssl = false

[security]
tokens_secret = \"$TOKENS_SECRET\"" > secrets/core.toml

kubectl create secret generic core --from-file=core-toml=secrets/core.toml

IP="$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' tls)"

CERTS=$(curl -H "Content-type: application/json" -d '{
		"request": {
			"CN": "minio",
			"hosts": [ "minio" ],
			"key": {
				"algo": "rsa",
				"size": 2048
			},
			"names": [{
				"O": "Brain Updaters"
			}]
		}
	}' "http://$IP:8888/api/v1/cfssl/newcert")

echo $CERTS | python3 -c "import sys, json; print(json.load(sys.stdin)['result']['certificate'])" > secrets/minio.crt
echo $CERTS | python3 -c "import sys, json; print(json.load(sys.stdin)['result']['private_key'])" > secrets/minio.key

kubectl create secret generic minio --from-file=minio-crt=secrets/minio.crt --from-file=minio-key=secrets/minio.key
