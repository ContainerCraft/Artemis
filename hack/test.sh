#!/bin/bash -x

get_bin () {
  runPath="$(pwd)"

  verKind=$(curl -s https://api.github.com/repos/kubernetes-sigs/kind/releases/latest | awk -F '["v,]' '/tag_name/{print $5}')
  urlKind="https://github.com/kubernetes-sigs/kind/releases/download/v${verKind}/kind-linux-amd64"

  verKustomize=$(curl -s https://api.github.com/repos/kubernetes-sigs/kustomize/releases/latest | awk -F '["v,]' '/tag_name/{print $5}')
  urlKustomize="https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv${verKustomize}/kustomize_v${verKustomize}_linux_amd64.tar.gz"

  mkdir -p $(pwd)/bin
  curl --output $(pwd)/bin/kind -L ${urlKind}
  chmod +x $(pwd)/bin/kind
  ./bin/kind --version


  curl --output $(pwd)/bin/kubectl -L "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
  chmod +x $(pwd)/bin/kubectl
  ./bin/kubectl version --client --short

  curl --output $(pwd)/bin/kustomize.tgz -L "${urlKustomize}"
  cd ${runPath}/bin/
  tar xvf kustomize.tgz 
  cd ${runPath}
  chmod +x $(pwd)/bin/kustomize
  ./bin/kustomize version --short
  
}

run_test () {
export PATH=$PATH:$(pwd)/bin
#kind create cluster --config ./hack/kind.yml
kubectl create namespace argocd
kubectl create namespace tekton-pipelines
kustomize build https://github.com/ContainerCraft/Artemis.git/ | kubectl apply -f -
#kubectl kustomize https://github.com/containercraft/artemis.git | kubectl apply -f -
}

cleanup () {
  kind delete cluster --name artemis-test
}

run () {
  get_bin
  run_test
  cleanup
}

run
