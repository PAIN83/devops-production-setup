# DevOps Production Setup

A production-style AWS infrastructure built across 3 projects
that demonstrates real DevOps workflows used in industry.
Each project builds on top of the previous one — forming one
complete system.

## The Big Picture

Developer pushes code to GitHub
        ↓
CI/CD Pipeline automatically tests and deploys (Project 2)
        ↓
Infrastructure created by Terraform hosts the app (Project 1)
        ↓
Monitoring watches the app and alerts on issues (Project 3)

## Projects

### Project 1 — AWS Infrastructure (Terraform)
Provisions a complete AWS environment using Infrastructure as Code.
No manual console clicking — everything is code.
- Custom VPC with public subnet
- EC2 instance with Nginx auto-configured via user_data
- Internet Gateway, Route Table, Security Groups
- Remote state management via S3 backend

Tools: Terraform, AWS (VPC, EC2, S3, Security Groups)
Cost: ~$2-3

### Project 2 — CI/CD Pipeline (coming soon)
Automatically tests, builds and deploys app on every git push.

Tools: GitHub Actions, Docker, AWS ECR, EC2

### Project 3 — Monitoring and Config Management (coming soon)
Configures servers automatically and monitors app health.

Tools: Ansible, AWS CloudWatch, SNS

## Why I built this
As a fresher I wanted to build projects that reflect what
real DevOps engineers do at work — not just tutorial projects.
Each project covers skills that appear in every DevOps job
description.

## Skills covered
- Infrastructure as Code (Terraform)
- Cloud platforms (AWS)
- CI/CD pipelines (GitHub Actions)
- Containerization (Docker)
- Configuration management (Ansible)
- Monitoring and alerting (CloudWatch)
- Linux and scripting
- Git and version control
