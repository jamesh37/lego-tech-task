# Task definition
resource "aws_ecs_task_definition" "nginx" {
  family                   = "nginx"
  container_definitions    = file("${path.module}/task.json")
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 256
  memory                   = 512
}

#ECS Fargate service
resource "aws_ecs_service" "nginx" {
  name            = "nginx"
  cluster         = var.ecs_cluster
  task_definition = aws_ecs_task_definition.nginx.arn
  desired_count   = var.desired_tasks
  launch_type     = "FARGATE"

  load_balancer {
    target_group_arn = var.target_group
    container_name   = "nginx"
    container_port   = 80
  }

  network_configuration {
    subnets          = [var.public_cidr_1, var.public_cidr_2]
    security_groups  = [var.int_security_group]
    assign_public_ip = true
  }
}

variable "ecs_cluster" {

}

variable "desired_tasks" {

}

variable "public_cidr_1" {

}

variable "public_cidr_2" {

}

variable "target_group" {

}

variable "int_security_group" {

}