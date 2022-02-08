# Introduction 
The objective of this exercise is to design, deploy and provision an Observabilty as Code solution for Azure Kubernetes (AKS)

The terraform code have been tested locally but I am not able to run the pipelines because by the default Microsoft set the number of parallels jobs to 0 on the free accounts, and it takes 2 to 3 days to activate, so I will create the pipelines code without test it

# Prerequisites
On azure pipelines we need to install the components below from the marketplace:
[- Terraform module](https://marketplace.visualstudio.com/items?itemName=ms-devlabs.custom-terraform-tasks)
[- Replace tokens module](https://marketplace.visualstudio.com/items?itemName=qetza.replacetokens)

# Install the pipeline
1. On Azure Devops create a library called "Dashboard-POC" with the following values:

### Azure variables
```
client_id 			= "The client id that will execute the terraform code"
client_secret   = "The client secret for the client_id executing the terraform code"
subscription_id = "Your subscription id"
tenant_id       = "Your tenant id"
```

### Datadog variables
```
datadog_api_key = "Your datadog api key (should match the apikey deployed on the kubernetes cluster also"
datadog_app_key = "Your datadog aplication key (should match the application key deployed on the kubernetes cluster also"
```

### Terraform related variables
```
service_connection = "Service connection for the azure pipeline to connect to azure in order to deploy the terraform.tfstate on a blob storage in the portal"
terraform_state_file_resource_group = "The resource group containing the storage where the terraform tfstate will be saved"
terraform_state_file_storage = "The name of the storage account that will contain the terraform state file"
terraform_state_file_container = "The container to save the terraform state file"
terraform_state_file_apikey = "The APIKey for terraform to get access to the storage that contains the terraform state file"
```

2. Go to Pipelines and create a new pipeline using this repository as source and azure-pipelines.yaml file as main file for the pipeline

3. Execute the new pipeline on the main branch (On execution will ask you to allow permissions to the pipeline into the "Dashboard-POC" library, please give them access on request.)

# What is the pipeline doing.
The pipeline will execute the terraform code inside of the "terraform" folder, deploying a preconfigured json datadog dashboard into your datadog.

# How could be this improved
- As I just created the Azure Devops account for the test I didn't have parallels job, so the pipeline code didn't been tested
- With more time I would use a terraformed template instead of a json where I could have variables to parametrize all the values in an easier way.
- A nice approach could be even to get this values from a Library to be able to modify easily the values without having to release a new version of the code
- All this code could be created as a module in a way that many projects can use with different parameters and for different datadog clients easily

# Other
In the installDatadog folder is the file I have used to deploy the datadog agent on my AKS cluster in case of needed the cluster name + the api and app keys need to be changed on the file locally or get them from a secret

# Execute terrarorm locally
In order to execute terraform locally you need to:
- Remove the backend.tf file from the terraform folder
- Add the secrets on your local terraform.tfvars files replacing what we have in the directory
- Run the below commands
$ terraform init
$ terraform plan -var-file=terraform.tfvars -out plan.out
$ terraform apply plan.out
