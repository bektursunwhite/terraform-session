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

 variable "env" {
   description = "environment"
   type = string
   default = "qa"
 }

 variable "main_cidr" {
   description = "main cidr_block"
   type = string
   default = "10.0.0.0/16"
 }