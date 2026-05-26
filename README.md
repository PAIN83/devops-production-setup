# DevOps Production Setup

A production-style AWS infrastructure built across 3 projects
that demonstrates the full DevOps lifecycle — build, deploy,
and monitor. Each project builds on top of the previous one
forming one complete system. Mostly everything is automated

## The Big Picture

The 3 projects work together as one system:

Terraform builds the AWS infrastructure (Project 1)
        ↓
GitHub Actions automatically deploys the app (Project 2)
        ↓
Ansible configures the server, CloudWatch monitors it (Project 3)

## Projects

### Project 1 — AWS Infrastructure (Terraform)
The foundation. Provisions a complete AWS environment using
Infrastructure as Code. No manual console clicking — everything
is code that can be destroyed and recreated in under 2 minutes.

What gets created:
- VPC with public subnet
- EC2 instance 
- Internet Gateway, Route Table, Security Group
- EC2 auto-installs Docker, Git and Nginx on first boot
- Remote state stored in S3 for team collaboration

Tools: Terraform, AWS (VPC, EC2, S3, Security Groups)
Cost: ~$2-3

### Project 2 — CI/CD Pipeline (GitHub Actions + Docker)
Automated deployment. Every git push to master automatically
tests, builds and deploys the app — zero manual work.

What happens on every push:
- GitHub Actions wakes up
- SSHs into EC2
- Pulls latest code
- Builds fresh Docker image
- Replaces old container with new one
- App is live in ~60 seconds

Tools: GitHub Actions, Docker, Flask, AWS EC2
Cost: $0 (uses GitHub free tier)

### Project 3 — Monitoring and Configuration Management
Operations layer. Ansible configures servers automatically
and CloudWatch monitors the app health 24/7.

Ansible:
- One command configures the entire server
- Idempotent — same result every time
- Deploys and runs the Flask container

CloudWatch + SNS:
- Watches EC2 CPU every 2 minutes
- Emails alert when CPU exceeds 80%
- Know about problems before users do

Tools: Ansible, AWS CloudWatch, AWS SNS, Terraform
Cost: $0 (free tier)

## Why I built this
As a fresher I wanted to build projects that reflect what
real  issues they face — not just
tutorial projects. 

## Skills covered
- Infrastructure as Code (Terraform)
- AWS (VPC, EC2, S3, CloudWatch, SNS)
- CI/CD pipelines (GitHub Actions)
- Containerization (Docker)
- Configuration management (Ansible)
- Monitoring and alerting (CloudWatch)
- Linux and scripting (Bash, user_data)
- Git and version control

## How to run the full system
1. cd 01-infrastructure && terraform apply
2. Update EC2_HOST in GitHub Secrets with new IP
3. Update inventory.ini in 03-monitoring-config/ansible
4. cd 03-monitoring-config/cloudwatch && terraform apply
5. cd 03-monitoring-config/ansible && ansible-playbook -i inventory.ini playbook.yml
6. Push any code change to trigger CI/CD pipeline

## How to clean up
cd 03-monitoring-config/cloudwatch && terraform destroy
cd 01-infrastructure && terraform destroy
