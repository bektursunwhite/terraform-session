# resource "aws_sqs_queue" "main" {
#   name = "${var.provider}-${var.region}-sqs-${var.business_unit}-${var.tier}-${var.project}-${var.env}"
#   tags = { 
#     Name = "${var.provider}-${var.region}-sqs-${var.business_unit}-${var.tier}-${var.project}-${var.env}"
#     Environment = var.env
#     Project_Name = var.project
#     Business_Name = var.business_unit
#     Tema = var.team
#     Owner = var.owners
#     Managed_by = var.managed_by
#   }
# }

resource "aws_sqs_queue" "main" {
  name = replace(local.name, "rtype", "sqs")
  tags = merge (
  local.common_tags,
  {Name = replace(local.name, "rtype", "sqs") }
  )
}

resource "aws_db_instance" "default" {
  allocated_storage    = 10
  identifier = replace(local.name, "rtype", "rds")
  db_name              = "wordpress"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  username             = "foo"
  password             = random_password.main_db_password.result
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = var.env != "prod" ?  true : false 
  final_snapshot_identifier = var.env != "prod" ? null : "${var.env}-final-snapshot"
}



resource "random_password" "main_db_password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

output "main_db_password" {
  value = random_password.main_db_password.result
  sensitive = true
}




// skip_final_snapshot = true     ->  there is no snapshot
// skip_final_snapshot = false      -> there will be snapshot


// Problem Statement: I want a snapshot only in prod environment but not in qa and dev
// Conditional Expression:  prod == prod true : false (true)
//                          prod != prod true : false (false )