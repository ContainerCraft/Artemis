# ArgoCD GitOps Infra
Bootstrap ArgoCD + infrastructure apps on Kubernetes app clusters.

Included:
- [x] Argocd
- [x] Cert Manager
  - [x] selfsigned clusterissuer
  - [ ] letsencrypt clusterissuer
- [x] MetalLB
- [ ] Inlets Operator
- [x] Nginx Ingress
  - [x] Local with MetalLB
  - [ ] Public with Inlets Operator
- [x] democratic-csi
- [ ] Coredns External DNS
- [ ] FreeIPA
- [ ] Next Cloud
- [ ] Postgres Operator
- [ ] Gitea

## Get Started:
### Bootstrap ArgoCD on a cluster
```bash
kubectl kustomize --enable-helm https://github.com/ContainerCraft/k.git/ops/argocd | kubectl apply -f -
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

