terraform {
  backend "s3" {
    bucket  = "tf-session-backend-bucket-beka"
    key     = "session-8-cw/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}