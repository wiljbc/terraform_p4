# Backend configuration

terraform {
  backend "s3" {
    bucket = "terraform-tfstate-bucket-wbarrantes"
    key    = "state/p4/terraform.tfstate"
    region = "us-east-1"
  }
}
