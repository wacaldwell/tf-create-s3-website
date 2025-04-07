locals {
  alb_name = "${var.alb_subdomain}-alb"
}

resource "aws_security_group" "alb_sg" {
  name        = "${local.alb_name}-sg"
  description = "Allow HTTPS access to the ALB"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow HTTPS traffic from the internet"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_lb" "alb" {
  name               = local.alb_name
  internal           = false
  load_balancer_type = "application"
  subnets            = var.public_subnets
  security_groups    = [
    aws_security_group.alb_sg.id,
    var.ssh_security_group_id
  ]

  enable_deletion_protection = false
  idle_timeout               = 60
  ip_address_type            = "ipv4"
}

resource "aws_lb_target_group" "default" {
  name        = "${local.alb_name}-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "API backend placeholder"
      status_code  = "200"
    }
  }
}