variable "instance_type" {
    description = "aws instance size or type"
    type = string
    default = "t2.micro" 
 }

 variable "env" {
   description = "environment"
   type = string
   default = "qa"
 }


 variable "ingress_ports" { 
  description = "a list of ingress ports"
  type = list(number)
  default = [ 22, 80, 443, 3306 ]
 }

 variable "ingress_cidr" { 
  description = "a list of ingress ports"
  type = list(string)
  default = [ "0.0.0.0/0", "0.0.0.0/0", "0.0.0.0/0", "0.0.0.0/0" ]
 }

