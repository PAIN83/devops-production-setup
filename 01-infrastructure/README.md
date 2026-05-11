# Project 1 — AWS Infrastructure with Terraform

## Problem it solves
Manually clicking through AWS console is slow, error-prone,
and impossible to reproduce. This project provisions an entire
AWS environment in under 2 minutes using code instead of
manual console clicks.

## Architecture
VPC
├── Public Subnet → EC2 t3.micro (Nginx web server)
├── Internet Gateway (connects VPC to internet)
├── Route Table (directs all traffic to gateway)
└── Security Group (firewall — allows port 80 and 22 only)

S3 bucket stores Terraform state remotely for team collaboration

## Files
- backend.tf   → configures S3 as remote state backend
- variables.tf → all configurable values in one place
- main.tf      → creates all AWS resources
- outputs.tf   → prints public IP and URL after apply

## How to run
1. Configure AWS CLI: aws configure
2. terraform init
3. terraform plan
4. terraform apply
5. Open the website_url printed in the output

## How to clean up (always do this to avoid billing)
terraform destroy

## What I learned
- How to provision AWS infrastructure using Terraform
- VPC networking concepts (subnets, gateways, route tables)
- Remote state management using S3 backend
- Idempotency — running terraform apply multiple times
  gives the same result every time
- Never use root account — always use IAM users

## Challenges faced
- Wrong AMI ID for Mumbai region caused Nginx to fail
- Fixed by fetching the latest Amazon Linux 2 AMI using AWS CLI
- Key pair had to be created before EC2 for SSH access

## Cost
~$2-3 total if destroyed after testing
Free tier eligible (t3.micro)
