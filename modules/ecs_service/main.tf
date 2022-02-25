terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_ecs_cluster" "petclinic_cluster" {
  name = var.cluster_name

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_lb" "petclinic_alb" {
  name               = var.alb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.security_group_name
  subnets            = var.subnets_ids

  enable_deletion_protection = false
}

resource "aws_lb_target_group" "petclinic_target_group" {
  name        = var.target_group_name
  port        = var.container_port
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.petclinic_alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.certificate_arn
  depends_on = [aws_lb.petclinic_alb, aws_lb_target_group.petclinic_target_group]

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.petclinic_target_group.arn
  }
}

resource "aws_ecs_service" "petclinic_service" {
  name            = var.service_name
  cluster         = aws_ecs_cluster.petclinic_cluster.id
  task_definition = var.task_definit_arn
  desired_count   = var.desired_count
  launch_type = "FARGATE"
  depends_on = [aws_lb_listener.front_end]

  load_balancer {
    target_group_arn = aws_lb_target_group.petclinic_target_group.arn
    container_name   = var.container_name
    container_port   = var.container_port
  }
  network_configuration {
    subnets = var.subnets_ids
    security_groups = var.security_group_name
    assign_public_ip = true
  }
}
