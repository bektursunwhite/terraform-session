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