# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.0.2] - 2022-02-14
### Changed
- Update on azure-pipelines.yaml to fix the terraform directory
- Correct commas on terraform.tfvars file
- Change backendAzureRmKey value to th tfstate file name
 
## [0.0.1] - 2022-02-09
### Added
- Terraform code to deploy a kubernetes dashboard into Datadog
- installDatadog folder with the helm chart to deploy the Datadog agent in kubernetes
- dashboard folder containing the dashboard in a json file
- README file with the instructions to execute it
- azure-pipelines.yaml file with the pipeline for Azure Devops
