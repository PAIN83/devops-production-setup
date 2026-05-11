variable "region" {
  description = "AWS region to deploy into"
  default     = "ap-south-1"
}

variable "instance_type" {
  description = "EC2 instance size"
  default     = "t3.micro"
}

variable "project_name" {
  description = "Prefix for all resource names"
  default     = "devops-project"
}
