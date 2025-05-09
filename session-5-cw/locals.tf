// Naming convetion:  Naming standart

// 1. Provider Name: aws, azure, gcp, do, alibaba;
// 2. Region Name: usw1, usw2, use1, use2;
// 3. Resource type: ec2, s3, sqs, asg, alb, efs; 
// 4. Environment: dev, qa, stg, prod;
// 5. Business Unit: orders, payments, streaming;
// 6. Projects Name: unicorn, batman, tom, jerry, ihope, ipa
// 7. Tier: frontend, backend, database

// Example 1: aws-use1-vpc-orders-db-tom-dev
//         2: orders-tom-db-aws-use1-vpc-dev
//         3: tom-aws-use1-vpc-orders-db--dev

// Tagging Convention: Common Tags

// 1. Environment: dev, qa, stg, prod
// 2. Project Name: unicorn, tom, jerry, batman; 
// 3. Business Unit: orders, payments, streaming
// 4. Team: DevOps, DRE, SRE, Security
// 5. Owner: kris@gmail.com
// 6. Managed_by: cloudformation, terraform, python
// 7. Lead: akmal@akumosolutions.io

locals { 
    // naming standard
    name = "${var.provider_name}-${var.region}-rtype-${var.business_unit}-${var.tier}-${var.project}-${var.env}"
    // taging standard
    common_tags = { 
      Environment = var.env
      Project_Name = var.project
      Business_Name = var.business_unit
      Team = var.team
      Owner = var.owners
      Managed_by = var.managed_by
    }
}