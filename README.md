
# Terraform Lab 3 - GCP VPC & VM

## Project Description
This project demonstrates the deployment of an isolated infrastructure in Google Cloud using Terraform.  
It includes the creation of:
- A Virtual Private Cloud (VPC) with two subnets
- A secure bucket for storing Terraform state
- A virtual machine (VM) with Apache web server installed
- Access rules configuration (firewall, SSH, web port)

## Prerequisites
- Terraform v1.14.7 installed
- Google Cloud SDK (gcloud) installed
- Google Cloud account with Compute Admin role
- Authenticated via `gcloud auth application-default login`
- Internet connection

## Terraform Usage

### Initialize the project
```bash
terraform init
```

### Plan infrastructure changes

```bash
terraform plan
```

### Apply the configuration

```bash
terraform apply
```

### Destroy resources

```bash
terraform destroy
```
