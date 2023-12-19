# Demo-infrastructure

Things that are manually done for this setup.

#### 1. Created an account
```shell
# Define variable
$SUBSCRIPTION=az account subscription list | jq ".[].subscriptionId"
$TENANT_ID=az account tenant list | jq ".[].tenantId"

```

#### 2. Setup a service account
    
Using the commando 
```shell
# create Service account
$SP_NAME=github-sp
$SP_RESOURCE=az ad sp create-for-rbac --skip-assignment --name $SP_NAME -o json

# Define variables
$APP_ID=$SP_RESOURCE | jq -r ".appId"
$APP_PASSWORD=$SP_RESOURCE | jq -r ".password"

# Assign roles
az role assignment create --assignee $APP_ID --scope "/subscriptions/$SUBSCRIPTION" --role Contributor
```

#### 3. Apply the variables in the variable.tf or through the cli


#### 4. Apply
```shell
# This will create a cluster in West Europe
Terraform apply
```

#### 5. K8s credentials
```shell
az aks get-credentials --admin --name aks-demo --resource-group aks-demo -f C:\Users\xxx\.kube\k8sConfigFiles\aks_config.yaml
```