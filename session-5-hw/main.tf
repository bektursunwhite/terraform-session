# resource "aws_security_group" "alb_sg" { 
#   name        = replace(local.name, "rtype", "alb-sg")   
#   description = "security group for alb"  
#   vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id  
 
#   ingress {         
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   ingress {       
#     from_port   = 443
#     to_port     = 443
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {       
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = merge(
#     local.common_tags,
#     {Name = replace(local.name, "rtype", "alb-sg")} 
#   )
# }
resource "aws_security_group" "alb_sg" {
  name = "alb-sg"
  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id
  tags = merge(
    local.common_tags,
    {Name = replace(local.name, "rtype", "alb_sg")}
  )
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  count             = length(var.ingress_ports)
  security_group_id = aws_security_group.alb_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = var.ingress_ports[count.index]
  ip_protocol       = "tcp"
  to_port           = var.ingress_ports[count.index]
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic" {
  security_group_id = aws_security_group.alb_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" 
}

resource "aws_lb" "app_lb" {
  name               = replace(local.name, "rtype", "alb")
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = data.terraform_remote_state.vpc.outputs.public_subnet_ids

  tags = merge (
   local.common_tags,
    {Name = replace(local.name, "rtype", "app-lb")}
   
  )
}

resource "aws_lb_target_group" "lb-tg" {
  name     = replace(local.name, "rtype", "lb-tg")
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.terraform_remote_state.vpc.outputs.vpc_id
  target_type = "instance"

  health_check {
    enabled             = true
    port                = "traffic-port"
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200-399"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }

  tags = merge(
    local.common_tags,
    {Name = replace(local.name, "rtype", "lb-tg")}
  )
}

resource "aws_lb_listener" "alb_http_listener" {
  load_balancer_arn = aws_lb.app_lb.arn
  port = 80
  protocol = "HTTP"
  
  default_action {
    type = "redirect"
    redirect {
      port = "443"
      protocol = "HTTPS"
      status_code = "HTTP_301"
    }
    target_group_arn = aws_lb_target_group.lb-tg.arn
  }
  
  tags = merge(
    local.common_tags,
    {Name = replace(local.name, "rtype", "alb_listener")}
  )
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.app_lb.arn
  port              = 443
  protocol          = "HTTPS"
  certificate_arn   = "arn:aws:acm:us-east-1:676278186146:certificate/3da8e83a-1058-4bb0-8c50-50a7a9ec01a2"
  # depends_on = [aws_acm_certificate_validation.cert_validation]

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb-tg.arn
  }
tags = merge(
    local.common_tags,
    {Name = replace(local.name, "rtype", "app-acm-cert")}
  )
  
}

# ACM Certificate for HTTPS

# resource "aws_acm_certificate" "cert" {
#   domain_name       = "nurpirim.com"
#   validation_method = "DNS"

#   tags = {
#     Name        = "${var.env}-cert"
#   }

#   lifecycle {
#     create_before_destroy = true
#   }
# }


# resource "aws_route53_record" "record" {
#   for_each = {
#     for dvo in aws_acm_certificate.cert.domain_validation_options : dvo.domain_name => {
#       name   = dvo.resource_record_name
#       record = dvo.resource_record_value
#       type   = dvo.resource_record_type
#     }
#   }

#   allow_overwrite = true
#   name            = each.value.name
#   records         = [each.value.record]
#   ttl             = 60
#   type            = each.value.type
#   zone_id         = data.aws_route53_zone.main.zone_id
# }

# resource "aws_acm_certificate_validation" "cert_validation" {
#   certificate_arn         = aws_acm_certificate.cert.arn 
#   validation_record_fqdns = [for record in aws_route53_record.record : record.fqdn]
# }

resource "aws_route53_record" "app_alias" {
zone_id = data.aws_route53_zone.main.zone_id
name = "nurpirim.com"
type = "A"

alias {
  name                   = aws_lb.app_lb.dns_name 
    zone_id                = aws_lb.app_lb.zone_id  
    evaluate_target_health = true
}
}

resource "aws_security_group" "lt_sg" { 
  name        = "${var.env}-lt-sg" 
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id 
}
resource "aws_vpc_security_group_ingress_rule" "ingress" {
  count = length(var.ingress_ports)
  security_group_id = aws_security_group.lt_sg.id
  from_port         = var.ingress_ports [count.index]
  ip_protocol       = "tcp"
  to_port           = var.ingress_ports [count.index]
  referenced_security_group_id = aws_security_group.alb_sg.id
}
resource "aws_vpc_security_group_egress_rule" "egress" {
  security_group_id = aws_security_group.lt_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

#   ingress {
#     from_port       = 80
#     to_port         = 80
#     protocol        = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   } 
#   ingress {
#     from_port       = 22
#     to_port         = 22
#     protocol        = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   } 
#   ingress {       
#     from_port   = 443
#     to_port     = 443
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress { 
#     from_port   = 0       
#     to_port     = 0
#     protocol    = "-1" 
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name        = "${var.env}-lt-sg"
#   }
# }

resource "aws_launch_template" "web_lt" { 
  name                   = "${var.env}-web-lt" 
  image_id               = data.aws_ami.amazon_linux_2023.id 
  instance_type          = var.instance_type 
  key_name               = "MyMacKey"
  


  user_data = base64encode(file("userdata.sh"))

network_interfaces {
  associate_public_ip_address = true
  security_groups = [aws_security_group.lt_sg.id]
  subnet_id = data.terraform_remote_state.vpc.outputs.private_subnet_ids[0]
}

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name        = "${var.env}-app-instance"
    }
  }

  tags = { 
    Name        = "${var.env}-web-lt"
  }
}

resource "aws_autoscaling_group" "aws_asg" {
  name = "aws_asg"
  min_size = 1
  max_size = 3
  desired_capacity = 2
  vpc_zone_identifier = data.terraform_remote_state.vpc.outputs.private_subnet_ids
  target_group_arns = [aws_lb_target_group.lb-tg.arn]

  launch_template {
    id = aws_launch_template.web_lt.id
    version = "$Latest"
  }
}