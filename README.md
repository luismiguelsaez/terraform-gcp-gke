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
gcloud container clusters get-credentials $(terraform output kubernetes_cluster_name | sed 's/"//g') --region $(terraform output kubernetes_cluster_region | sed 's/"//g')
```

### Install chart ( https://github.com/GoogleCloudPlatform/spark-on-k8s-operator )
```
helm repo add spark-operator https://googlecloudplatform.github.io/spark-on-k8s-operator
helm install my-release spark-operator/spark-operator
```

### Service account
```
kubectl apply -f k8s/spark-serviceaccount.yml
```

### Create CRD
```
k apply -f https://raw.githubusercontent.com/GoogleCloudPlatform/spark-on-k8s-operator/master/examples/spark-pi-custom-resource.yaml
```
