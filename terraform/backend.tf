terraform {
  backend "s3" {
    bucket = "terraform-state-devops-ricardo"
    key    = "devops-bible-app/terraform.tfstate"
    region = "us-east-1"
  }
}