# ArgoCD Gitops ApplicationSet

### Bootstrap ArgoCD on a cluster
```bash
kubectl create namespace argocd --dry-run=client -oyaml | kubectl apply -f -
```
```bash
kubectl kustomize --enable-helm https://github.com/ContainerCraft/k.git/ops/argocd | kubectl -n argocd apply -f -
```

### Port forward WebUI and decode admin user password
```bash
kubectl get secrets -n argocd -oyaml argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d ; echo
```
```bash
kubectl port-forward svc/argocd-server -n argocd 8080:443
```

### Open WebUI: 

> username: `admin`

- [localhost:8080](https://localhost:8080)

