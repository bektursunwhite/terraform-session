variable "public_subnets_cidrs" { 
    type = list(string)
    description = "Public subnet CIDR values"
    default = [ "10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24" ]
 }

 variable "private_subnets_cidrs" {
   type = list(string)
   description = "Private subnet CIDR values"
   default = [ "10.0.3.0/24", "10.0.4.0/24", "10.0.5.0/24" ]
 }

 variable "azs" {
   type = list(string)
   description = "Availibility zones"
   default = [ "us-east-1a", "us-east-1b", "us-east-1c" ]
 }

 variable "instance_type" {
  description = "Type of instance to create"
  type        = string // string, number. boolean, list, map
  default     = "t2.micro"
}

variable "ingress_ports" {
  description = "a list of ingress ports"
  type        = list(number)
  default     = [22, 80, 443]

}

variable "ingress_cidr" {
  description = "a list of cidr"
  type        = list(string)
  default     = ["10.0.0.0/16", "0.0.0.0/0", "0.0.0.0/0", "10.0.0.0/16"]

}

variable "env" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "vpc_cidr_block" {
  description = "vpc cidr block"
  type = string
  default = "10.0.0.0/16"
}