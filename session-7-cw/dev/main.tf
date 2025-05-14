## root module ## 

module  "sg" {
  # argument
  source = "../../modules/sg"      // where the child module is. giving the path to our child module
  name = "dev-instance-sg"
  description = "this sg for dev instance"
  ingress_ports = [ 22 ]
  ingress_cidr =  [ "10.0.0.0/32" ]
}




module "ec2" { 
  source = "../../modules/ec2"
  env = "dev"
  instance_type = "t2.micro"
  ami = data.aws_ami.amazon_linux_2023.id                           // reference to data.source 
  vpc_security_group_ids =[ module.sg.security_group_id ]           // reference to child module output  // syntax: module.module_name.output
}


data "aws_ami" "amazon_linux_2023" {
  most_recent      = true
  owners           = ["amazon"]

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





## Calling terraform modules remotely 
// terrafrom registry - official child module
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}


module "erkin_sg" { 
source = "github.com/Ekanomics/terraform-session/modules/sg"
  name = "erkin-sg"
  description = "this sg for dev instance"
  ingress_ports = [ 22 ]
  ingress_cidr =  [ "10.0.0.0/32" ]
}

