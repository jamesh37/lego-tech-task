# ECS cluster
resource "aws_ecs_cluster" "ecs" {
  name = "${var.app_name}-${var.env}"
}

output "ecs_cluster" {
  value = aws_ecs_cluster.ecs.id
}