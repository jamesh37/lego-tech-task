# Allow port 80 ingress to load balancer, from everywhere
resource "aws_security_group" "ext80" {
  name        = "${var.app_name}-${var.env}-80_ext"
  description = "Allow 80 inbound traffic"
  vpc_id      = aws_vpc.primary.id

  ingress {
    description = "80 from everywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_80_ingress_ext"
  }
}

#Allow port 80 ingress to containers, from load balancer
resource "aws_security_group" "int80" {
  name        = "${var.app_name}-${var.env}-80_int"
  description = "Allow 80 inbound traffic from LB"
  vpc_id      = aws_vpc.primary.id

  ingress {
    description     = "80 from everywhere"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.ext80.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_80_ingress_int"
  }
}

output "int_security_group" {
    value = aws_security_group.int80.id
}