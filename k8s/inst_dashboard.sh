#!/bin/bash

echo ""
echo "### Deploying k8s metrics-server ..."
./kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/download/v0.3.6/components.yaml
echo ""
echo "### Deploying k8s Dashboard ..."
./kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.1/aio/deploy/recommended.yaml
echo ""
echo "### Deploying k8s Dashboard Admin account ..."
./kubectl apply -f dashboard/dashboard-adminuser.yaml
echo ""
echo "### Forwarding Dashboard port ..."
nohup ./kubectl port-forward -n kubernetes-dashboard service/kubernetes-dashboard 8443:443 2>/dev/null &
# Open a firefox browser to acces the dashboard
echo ""
echo "### Starting new firefox window to the dashboard ..."
nohup firefox https://127.0.0.1:8443 2>/dev/null &
echo ""
echo "### Copy the token to get access in the dashboard login prompt. "
echo ""
./kubectl -n kubernetes-dashboard describe secret $(kubectl -n kubernetes-dashboard get secret | grep admin-user | awk '{print $1}') | grep "^token:"
echo ""
echo "################################################################################"
echo "# be sure it is a single line before pasting it to the dashboard login screen, #"
echo "# you can check it pasting it in an editor before that.                        #"
echo "################################################################################"
