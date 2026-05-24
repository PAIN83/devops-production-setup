terraform {
  backend "s3" {
    bucket = "ashwant-terraform-state"
    key    = "03-monitoring-config/terraform.tfstate"
    region = "ap-south-1"
  }
}
