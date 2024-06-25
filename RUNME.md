# Readme

## Apply

```sh {"id":"01J17WWPWXXZZG0AGRYEKJHMVH"}
python3 ./scripts/runner.py --env dev --commands check-tool-installation util.bootstrap-cluster terraform-init-env terraform-apply-env --kube-context-name docker-desktop
```

### Namespace Event Log

```sh {"id":"01J05ESR8R84GVER27PPDPM9NK"}
kubectl get events -n my-sample-app-development


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
kubectl get ingress cm-acme-http-solver-6mrxt -n my-sample-app-development -o yaml


```

```sh {"id":"01J06SQEFYCJ7NZPEWCZ9XZBMT"}
kubectl get service -n cert-manager -o yaml


```

```sh {"id":"01J06SRZWBNBPZ9XQJP12XH38V"}
kubectl get networkpolicy -A


```

```sh {"id":"01J06W99F02NNQSGY9TG91ZAWZ"}
kubectl delete order -n my-sample-app-development --all
kubectl delete certificaterequest -n my-sample-app-development --all
kubectl delete certificate exhelion-net-tls -n my-sample-app-development

```

#### References

- let's-encrypt

   - https://letsencrypt.org/docs/duplicate-certificate-limit/

- SSL/TLS

   - https://github.com/kubernetes/ingress-nginx
   - https://artifacthub.io/packages/helm/cert-manager/cert-manager
   - ACME
      - https://en.wikipedia.org/wiki/Automatic_Certificate_Management_Environment
      - https://datatracker.ietf.org/doc/html/rfc8555

### Reset Local Environment

```sh {"id":"01J0C67SDV9R5P7X81CAZ5M6ME"}
python ./scripts/runner.py --env dev --commands check-tool-installation terraform-burn bootstrap-cluster terraform-apply-env


```

### Init DotEnv

```sh {"id":"01J0GXEHY0JRTEAAJ6VZWG3A0A"}
npx dotenv-vault@latest login
npx dotenv-vault@latest pull 

```

### Link Windows kube config to WSL instance

```sh {"id":"01J10289TJ5TSF5CSW8ZB0DV2Z"}
rm ~/.kube/config
ln -s /mnt/c/Users/{user}/.kube/config ~/.kube/config

```
