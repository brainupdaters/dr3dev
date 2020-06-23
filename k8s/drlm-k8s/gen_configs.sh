#!/bin/sh

#kubectl delete secret drlm-core

TOKENS_SECRET="$(openssl rand -base64 32)"

echo "[grpc]
tls = false

[minio]
ssl = false

[security]
tokens_secret = \"$TOKENS_SECRET\"" > secrets/core/drlm-core.toml

#kubectl create secret generic drlm-core --from-file=drlm-core-toml=drlm-core.toml

#kubectl delete secret drlm-core

echo "[core]
tls = false
host = \"drlm-core\"
port = 50051
secret = \"$TOKENS_SECRET\"

[minio]
ssl = false" > secrets/agent/drlm-agent.toml

#kubectl create secret generic drlm-agent --from-file=drlm-agent-toml=drlm-agent.toml

