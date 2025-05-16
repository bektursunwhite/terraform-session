variable "instance_type" {
  description = "aws instance size or type"
  type        = string
  default     = "t2.micro"
}

variable "env" {
  description = "environment"
  type        = string
  default     = "qa"
}

variable "ami" {
  description = "ami id "
  type        = string
  default     = "xyz"
}

variable "vpc_security_group_ids" {
  description = "security group ids"
  type        = list(string)
  default     = ["xyz"]
}



// data_source.. 

data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.7.*"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}