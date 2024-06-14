# oauth_server

```sh {"id":"01HZQDVCDBDFZB5HZF6KC7NBQT"}
py .\scripts\runner.py dev terraform_apply_env
```

```sh {"id":"01HZQDSP7K81H9NERS1PAMW02H"}
py .\scripts\runner.py dev tf-var-loader
```

```sh {"id":"01J079YKSARJ7B7HKFDR4ZNSH3"}
python ./scripts/runner.py --env dev --commands check-tool-installation terraform-burn bootstrap-cluster terraform-apply-env
```

```sh {"id":"01J0A9RGGX9HETF3VT5KC20RW5"}
python ./scripts/runner.py --env dev --commands check-tool-installation terraform-burn bootstrap-cluster terraform-apply-env
```

```sh {"id":"01J0AA07AGQSF19PG7H74X1K9Q"}
python ./scripts/runner.py --env dev --commands bootstrap-cluster terraform-apply-env
```

### Install cluster helm resources

```sh {"id":"01J06CXM4TDP1ZEN3Z7W35BKRA"}
helm upgrade --install cert-manager --repo https://charts.jetstack.io cert-manager --namespace cert-manager --create-namespace --version v1.12.0 --set installCRDs=true
# helm upgrade --install ingress-nginx ingress-nginx --repo https://kubernetes.github.io/ingress-nginx --namespace ingress-nginx --create-namespace
```

### Namespace Event Log

```sh {"id":"01J05ESR8R84GVER27PPDPM9NK"}
kubectl get events -n my-sample-app
```

### View Ingress Details

```sh {"id":"01J06F0F2EYSJ9J5269J1KHY0F"}
helm list -n ingress-nginx
helm get values nginx-ingress -n ingress-nginx
helm get manifest nginx-ingress -n ingress-nginx
```

### SSL Debugging Commands

```sh {"id":"01J06RB9MQYSTAKY5GG2RTKEKD"}
kubectl describe certificate exhelion-net
```

```sh {"id":"01J06RKSKXXE3YEMQK0NQHY92S"}
kubectl logs -n cert-manager deploy/cert-manager
```

```sh {"id":"01J06S1MYQDVJNCDWKTFQ84H5D"}
kubectl get svc -n ingress-nginx
```

```sh {"id":"01J06SKP9HK0DCG9YNME9HZJAP"}
kubectl get ingress cm-acme-http-solver-6mrxt -n my-sample-app -o yaml

```

```sh {"id":"01J06SQEFYCJ7NZPEWCZ9XZBMT"}
kubectl get service cm-acme-http-solver -n my-sample-app -o yaml

```

```sh {"id":"01J06SRZWBNBPZ9XQJP12XH38V"}
kubectl get networkpolicy -A

```

```sh {"id":"01J06W99F02NNQSGY9TG91ZAWZ"}
kubectl delete order -n my-sample-app --all
kubectl delete certificaterequest -n my-sample-app --all
kubectl delete certificate exhelion-net-tls -n my-sample-app

```

#### References

- SSL/TLS
   - https://github.com/kubernetes/ingress-nginx
   - https://artifacthub.io/packages/helm/cert-manager/cert-manager
   - ACME
      - https://en.wikipedia.org/wiki/Automatic_Certificate_Management_Environment
      - https://datatracker.ietf.org/doc/html/rfc8555
