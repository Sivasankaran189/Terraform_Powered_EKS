# Terraform-Based VPC and EKS Provisioning with Floci

A hands-on Infrastructure as Code (IaC) project focused on creating AWS networking infrastructure and an EKS-compatible Kubernetes cluster using Terraform and the Floci AWS emulator.

The project explores how AWS infrastructure components work together, including VPCs, public and private subnets, Internet Gateways, route tables, security groups, IAM roles, and Kubernetes cluster configuration.

Instead of provisioning infrastructure in a real AWS account, Floci provides a local AWS-compatible environment for experimenting with supported AWS services and Terraform configurations.

## Project Objectives

- Provision AWS-style infrastructure using Terraform.
- Create a Virtual Private Cloud (VPC) with public and private subnets.
- Configure Internet Gateways and public route tables.
- Understand AWS networking and security group configurations.
- Create IAM roles required for EKS-compatible cluster configuration.
- Explore EKS cluster provisioning through Floci.
- Practise Infrastructure as Code, resource dependencies, and Terraform state management.

## Technology Stack

| Technology | Purpose |
|---|---|
| Terraform | Infrastructure as Code |
| HashiCorp AWS Provider | AWS resource configuration |
| Floci | Local AWS service emulator |
| Docker Desktop | Runs the Floci environment |
| AWS CLI | Interacts with Floci endpoints |
| PowerShell | Command-line environment |
| Kubernetes / kubectl | Cluster inspection when cluster access is available |

## Architecture

![Architecture](docs/architecture.png)

The architecture represents the intended local infrastructure workflow. Floci's real EKS mode uses a k3s-backed Kubernetes environment rather than an actual AWS-managed EKS control plane.

## Infrastructure Components

### 1. VPC

- VPC CIDR: `10.0.0.0/16`
- DNS support enabled
- DNS hostnames enabled

### 2. Subnets

**Public subnets**

- `10.0.4.0/24`
- `10.0.5.0/24`

**Private subnets**

- `10.0.1.0/24`
- `10.0.2.0/24`

The subnet configuration uses two availability-zone names: `us-east-1a` and `us-east-1b`.

### 3. Networking

- Internet Gateway
- Public Route Table
- Public Route Table Associations
- Public and private subnet separation

### 4. Security

- Worker management security group
- Inbound SSH restricted to the VPC CIDR
- Internal VPC communication rules
- Outbound traffic rules

### 5. EKS-Compatible Cluster

- EKS cluster resource configuration
- IAM cluster role
- Kubernetes version variable
- Private subnet configuration

The current configuration focuses on cluster creation. Separate EC2 instances and EKS managed node groups have not been configured.

## Repository Structure

```text
project/
│
├── .gitignore
├── provider.tf
├── versions.tf
├── variable.tf
├── vpc.tf
├── eks.tf
├── security_group.tf
├── output.tf
└── README.md
```

## Prerequisites

- Windows
- Docker Desktop
- Terraform CLI
- AWS CLI
- Git
- Floci AWS emulator

Verify the installations:

```powershell
terraform --version
aws --version
docker --version
git --version
```

## Floci Configuration

The Floci AWS emulator runs locally through Docker.

Configure local AWS CLI credentials:

```powershell
aws configure set aws_access_key_id test
aws configure set aws_secret_access_key test
aws configure set region us-east-1
```

The AWS-compatible endpoint is:

```text
http://localhost:4566
```

Verify connectivity:

```powershell
aws --endpoint-url http://localhost:4566 sts get-caller-identity
```

The Terraform AWS provider must also be configured to route supported service requests to Floci.

## Terraform Commands

Initialize the Terraform working directory:

```powershell
terraform init
```

Format the configuration:

```powershell
terraform fmt -recursive
```

Validate the configuration:

```powershell
terraform validate
```

Preview infrastructure changes:

```powershell
terraform plan
```

Apply the configuration after reviewing the plan and verifying the Floci endpoints:

```powershell
terraform apply
```

Inspect Terraform outputs:

```powershell
terraform output
```

## Infrastructure Verification

Check the VPC:

```powershell
aws --endpoint-url http://localhost:4566 ec2 describe-vpcs
```

Check the subnets:

```powershell
aws --endpoint-url http://localhost:4566 ec2 describe-subnets
```

Check security groups:

```powershell
aws --endpoint-url http://localhost:4566 ec2 describe-security-groups
```

Check EKS clusters:

```powershell
aws --endpoint-url http://localhost:4566 eks list-clusters
```

## Cleanup

Remove Terraform-managed infrastructure:

```powershell
terraform destroy
```

Stop the Floci container when it is no longer needed:

```powershell
docker compose down
```

## Learning Outcomes

This project provides practical exposure to:

- Infrastructure as Code using Terraform.
- AWS VPC and subnet architecture.
- Public and private network segmentation.
- Internet Gateway and route table configuration.
- AWS security groups and IAM concepts.
- Terraform providers, resources, variables, and outputs.
- Local AWS service emulation using Floci.
- Kubernetes and EKS-compatible cluster concepts.

## References

- [Terraform Documentation](https://developer.hashicorp.com/terraform/docs)
- [HashiCorp AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [AWS VPC Resource](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc)
- [AWS Subnet Resource](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet)
- [AWS EKS Cluster Resource](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_cluster)
- [Floci Documentation](https://floci.io/)
- [Floci EKS Documentation](https://floci.io/floci/services/eks/)

