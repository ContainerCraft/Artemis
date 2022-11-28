# ArgoCD Gitops ApplicationSet

### Bootstrap ArgoCD on a cluster
```bash
kubectl kustomize . | kubectl -n argocd apply -f -
```

### Port forward WebUI and decode admin user password
```bash
kubectl get secrets -n argocd -oyaml argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d ; echo
kubectl port-forward svc/argocd-server -n argocd 8080:443
```

----------------------------------

## Update Argo-cd application
```bash
helm repo add argo https://argoproj.github.io/argo-helm && helm repo update
helm template argocd argo/argo-cd --create-namespace --namespace argocd --values ./values.yaml > argocd.yaml
```

