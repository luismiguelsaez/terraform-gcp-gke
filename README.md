This is a simble GKE cluster provisioning module for testing purposes. For a more customizable module, use the official hashicorp one ( https://github.com/terraform-google-modules/terraform-google-kubernetes-engine )

### Authenticate
```
gcloud auth application-default login
```

### Create cluster
```
cd terraform
terraform init
terraform plan
terraform apply
```

### Get credentials
```
gcloud container clusters get-credentials $(terraform output kubernetes_cluster_name) --region $(terraform output region)
```