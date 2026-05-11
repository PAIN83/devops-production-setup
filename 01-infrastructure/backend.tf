terraform {
  backend "s3" {
    bucket = "ashwant-terraform-state"
    key    = "01-infrastructure/terraform.tfstate"
    region = "ap-south-1"
  }
}
