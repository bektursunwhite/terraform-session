variable "instance_type" {
  description = "Type of instance to create"
  type        = string 
  default     = "t2.micro"
}

variable "env" {
   description = "environment"
   type = string
   default = "dev"
 }

 variable "provider_name" {
   description = "provider name"
   type = string
   default = "aws"
 }

 variable "region" {
   description = "provider region name"
   type = string
   default = "use1"
 }

 variable "business_unit" {
   description = "Business Unit"
   type = string
   default = "orders"
 }

 variable "project" {
   description = "project name"
   type = string
   default = "tom"
 }

 variable "team" {
   description = "Team Name"
   type   = string
   default = "devops"
 }

 variable "owners" {
   description = "Resource Owner"
   type = string
   default = "beka"
 }
 variable "managed_by" {
   description = "Tool"
   type = string
   default = "terraform"
 }

 variable "tier" {
   description = "Tier Name"
   type = string 
   default = "db"
 }

//-----------------------------------------------------=====================================


variable "ingress_ports" { 
  description = "a list of ingress ports"
  type = list(number)
  default = [ 22, 80, 443 ]
 }

#  variable "ingress_cidr" { 
#   description = "a list of ingress ports"
#   type = list(string)
#   default = [ "0.0.0.0/0", "0.0.0.0/0", "0.0.0.0/0" ]
#  }
