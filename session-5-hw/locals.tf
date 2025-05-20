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