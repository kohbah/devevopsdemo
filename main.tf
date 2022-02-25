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

module "ecs_service" {
  source = "./modules/ecs_service"
  alb_name = "petclinic-alb"
  certificate_arn = "arn:aws:acm:us-east-1:877510168756:certificate/7d5f6419-2c9d-44eb-baa2-2e837db9343d"
  cluster_name = "petclinic-cluster"
  container_name = "petclinic"
  container_port = 8080
  desired_count = 10
  security_group_name = ["sg-01bf44236185f395c"]
  service_name = "petclinic_service"
  subnets_ids = ["subnet-0a726b48d75921d6d", "subnet-0af761d403e0c3a3b", "subnet-088e8105ef3f58930"]
  target_group_name = "petclinic-tg"
  task_definit_arn = "arn:aws:ecs:us-east-1:877510168756:task-definition/petclinic:3"
  vpc_id = "vpc-0fea047e07a08b0ee"
}
