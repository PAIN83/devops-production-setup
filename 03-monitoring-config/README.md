# Project 3 — Monitoring and Configuration Management

## What is this project?
This project has two parts that solve two different problems:

Part A — Ansible solves this problem:
  Every time a new server is created, someone has to manually
  SSH in and set everything up. That is slow and error prone.
  Ansible automates this — one command configures the entire
  server automatically.

Part B — CloudWatch + SNS solves this problem:
  Without monitoring, you only find out your app is down when
  users complain. CloudWatch watches your server 24/7 and
  emails you the moment something goes wrong.

## Part A — Ansible (Configuration Management)

### How it works
You write two files:
  inventory.ini → list of servers to configure
  playbook.yml  → what to do on those servers

Then run one command from your laptop:
  ansible-playbook -i inventory.ini playbook.yml

Ansible SSHs into every server in the inventory and runs
all the tasks automatically. No manual SSH needed.

### What the playbook does
  1. Ensures Docker is running
  2. Ensures app folder exists
  3. Ensures Git is installed
  4. Clones or updates the GitHub repo
  5. Builds and runs the Flask container on port 80

### Idempotency
If you run the playbook 10 times, you get the same result.
Ansible checks each task first — if it is already done it
skips it. Only runs what actually needs to change.
This is called idempotency — a core concept in DevOps.

## Part B — CloudWatch + SNS (Monitoring)

### How it works
Three AWS resources work together:
  SNS Topic        → a notification channel
  SNS Subscription → your email subscribed to that channel
  CloudWatch Alarm → watches EC2 CPU every 2 minutes

When CPU goes above 80%:
  CloudWatch triggers → sends to SNS topic → emails you

### Why 80% CPU?
High CPU usually means the app is under heavy load or
something is wrong. 80% is a common threshold in production.
Below 80% is normal operation.

### Terraform data source
Instead of hardcoding the EC2 instance ID, we used a
Terraform data source to look it up automatically by tag.
This means the alarm still works even after terraform
destroy and terraform apply creates a new instance.

## Files
  ansible/
    inventory.ini  → server address book with SSH details
    playbook.yml   → tasks to run on each server

  cloudwatch/
    backend.tf     → S3 remote state for this project
    alerts.tf      → SNS topic, subscription and CloudWatch alarm

## How to run Ansible
  cd 03-monitoring-config/ansible
  ansible-playbook -i inventory.ini playbook.yml

## How to run CloudWatch setup
  cd 03-monitoring-config/cloudwatch
  terraform init
  terraform apply

## How to clean up
  terraform destroy

## What I learned
  - Writing Ansible inventory and playbook files
  - Idempotency in practice — not just theory
  - How CloudWatch alarms work with SNS
  - Terraform data sources — look up existing resources
  - The difference between configuration and monitoring
  - How real companies watch their infrastructure 24/7

## Challenges faced
  Port 80 conflict — Nginx was using port 80 so the Flask
  container couldn't start. Fixed by adding
  "sudo systemctl stop nginx" to the playbook shell task.

  Hardcoded instance ID — first version had the EC2 instance
  ID hardcoded which would break after terraform destroy.
  Fixed by using a Terraform data source to look it up
  automatically by the server's Name tag.

## Cost
  CloudWatch basic metrics — free tier
  SNS email notifications — free tier
  No extra cost on top of existing EC2
