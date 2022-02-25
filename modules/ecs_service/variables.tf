variable "cluster_name" {
  description = "the name of the cluster which you want to deploy"
  type = string
}

variable "alb_name" {
  description = "the name of app alb"
  type = string
}

variable "security_group_name" {
  description = "get the security group from the network team"
  type = list
}

variable "subnets_ids" {
  type = list
}

variable "target_group_name" {
  type = string
}

variable "container_port" {
  type = number
}

variable "vpc_id" {
  type = string
}

variable "certificate_arn" {
  type = string
}

variable "service_name" {
  type = string
}

variable "task_definit_arn" {
  type = string
}

variable "desired_count" {
  type = number
}

variable "container_name" {
  type = string
}


























