# Readme

## Apply

```sh {"id":"01J17WWPWXXZZG0AGRYEKJHMVH"}
./helios bootstrap dev
./helios init dev
./helios apply dev
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
./helios wipe
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

### Bind a virtual domain name to your local development environment

```sh {"id":"01J1JAS70B6NWJJ091G0C8T0BX"}
sudo python3 ./scripts/util/add_host.py my-sample-app.dev.local 127.0.0.1
```

### pod hostnames

```sh {"id":"01J1MWQND23ARD7YTAKH01Q4F1"}
kubectl exec -it exress-smoke-test-1-5cddb644bc-4r572 -n my-sample-app-dev -- curl http://service-b.your-namespace.svc.cluster.local


```

```sh {"id":"01J1MWVGYRBX153HXC7Q7K53PM"}
kubectl exec -it exress-smoke-test-1-5cddb644bc-4r572 -n my-sample-app-dev -- cat /etc/hostname

```

```sh {"id":"01J1QCZ0KMMVG5VZBHAV503JE7"}
kubectl port-forward -n linkerd-viz svc/web 8084:8084
linkerd viz dashboard
```

```sh {"id":"01J1QCZHX1NTNVEZBQYRP282H3"}

```
