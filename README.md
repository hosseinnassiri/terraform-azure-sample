# Terraform for azure
Hashicorp Terraform is an open-source tool for provisioning and managing cloud infrastructure.
It codifies infrastructure in configuration files that describe the topology of cloud resources. 
Terraform's template-based configuration files enable you to define, provision, and configure Azure resources in a repeatable and predictable manner.
Terraform AzureRM 2.0 provider is the provider that we're going to use.

## Prepare your development environment
### Prerequisites
* Azure Subscription
* Azure CLI
* Terraform for Windows

### Install Terraform for Windows
* [Download terraform for windows](https://www.terraform.io/downloads.html)
* From the download, extract the executable to a directory of your choosing and update the global system path to the executable.
* Verify the global path configuration:
``` powershell
terraform --version
```

## Authenticate to azure using service principal
You can use your azure account to authenticate or you can create a [service principal](https://docs.microsoft.com/en-us/azure/developer/terraform/get-started-windows-bash?tabs=bash#create-a-service-principal)

Then you can pecify service principal credentials in environment variables:
``` powershell
$env:ARM_CLIENT_ID="<service_principal_app_id>"
$env:ARM_SUBSCRIPTION_ID="<azure_subscription_id>"
$env:ARM_TENANT_ID="<azure_subscription_tenant_id>"
$env:ARM_CLIENT_SECRET="<service_principal_password>"

gci env:ARM_*

# to provide the variables from windows environment variables
$env:TF_VAR_azure_subscription_id = "???"; $env:TF_VAR_azure_subscription_tenant_id = "???"
```

Or you can provide service principal credentials in the Terraform provider block.

## Run terraform templates
``` powershell
terraform init

terraform plan -out main.tfplan

terraform apply main.tfplan
```

### Sensitive variables
https://learn.hashicorp.com/tutorials/terraform/sensitive-variables
Store your sensitive variables in secrets.tfvars file, and ensure that it is ignored by git.

``` powershell
# pass variables at runtime
terraform apply -var="system=terraformdemo" -var="location=eastus"
# pass secret variables at planning
terraform plan -out main.tfplan -var-file="secrets.tfvars"
# pass secret variables at applying
terraform apply -var-file="secrets.tfvars"

```

### Destroy the resources
``` powershell
terraform plan -destroy -out main.destroy.tfplan

terraform apply main.destroy.tfplan
```

### Validate terraform template
``` powershell
terraform validate
```