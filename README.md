
### Authenticate
```
gcloud auth application-default login
```

### Create cluster

### Get credentials
```
gcloud container clusters get-credentials $(terraform output kubernetes_cluster_name) --region $(terraform output region)
```