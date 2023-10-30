#!/bin/bash
cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://pkgs.k8s.io/core:/stable:/v1.28/rpm/
enabled=1
gpgcheck=1
gpgkey=https://pkgs.k8s.io/core:/stable:/v1.28/rpm/repodata/repomd.xml.key
EOF
sudo yum install -y kubectl
sudo aws eks --region us-west-2 update-kubeconfig --name test-eks-cluster
kubectl create namespace kumar
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
curl -sSL -o argocd-linux-amd64 https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
sudo install -m 555 argocd-linux-amd64 /usr/local/bin/argocd
sudo rm -f argocd-linux-amd64
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'
password=$(sudo argocd admin initial-password -n argocd)
echo "$password"
echo -e "Next steps to do: \n 1. get the argocd elb url and login \n 2. Run --argocd login <ARGOCD_SERVER>-- \n 3. Run --argocd account update-password--"
