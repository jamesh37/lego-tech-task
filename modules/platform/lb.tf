# Load balancer, listener and target group
resource "aws_lb" "lb1" {
  name               = "${var.app_name}-${var.env}-LB"
  internal           = false
  load_balancer_type = "application"
  subnets            = [aws_subnet.public1.id, aws_subnet.public2.id]
  security_groups    = [aws_security_group.ext80.id]
}

resource "aws_lb_listener" "lbl80" {
  load_balancer_arn = aws_lb.lb1.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg80.arn
  }
}

resource "aws_lb_target_group" "tg80" {
  name        = "${var.app_name}-${var.env}-TG"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = aws_vpc.primary.id
}

output "target_group" {
    value = aws_lb_target_group.tg80.arn
}