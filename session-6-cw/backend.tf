terraform {
  backend "s3" {
    bucket         = "tf-session-backend-bucket-beka"
    key            = "session-6-cw/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
}