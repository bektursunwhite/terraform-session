variable "name" {
  description = "env"
  type = string
  default = "test-sg"
}

variable "description" {
  description = "test-sg"
  type = string
  default = "descreption for sg"
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
