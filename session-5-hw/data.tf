data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
   bucket = "tf-session-backend-bucket-beka"
   key = "session-3-hw-count/terraform.tfstate"
   region = "us-east-1"
    }
  }


data "aws_ami" "amazon_linux_2023" {
  most_recent      = true
  owners           = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.7.*"]
  }

  filter {
    name    = "architecture"
    values  = ["x86_64"]
  }

  filter {
    name    = "virtualization-type"
    values  = ["hvm"]
  }
}

data "aws_route53_zone" "main" { 
  name         = "nurpirim.com" 
  private_zone = false 
}