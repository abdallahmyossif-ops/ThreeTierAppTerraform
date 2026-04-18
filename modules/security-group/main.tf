#external load balancer security group
resource "aws_security_group" "external_lb_sg" {
  name        = "External_LB_SG"
  description = "Security group for External Load Balancer"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow HTTP traffic"
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
}
#-----------------------------------------------------
#web tier security group
resource "aws_security_group" "web_tier_sg" {
  name        = "web_tier_sg"
  description = "Security group for web tier"
  vpc_id      = var.vpc_id

  ingress {
    description     = "Allow HTTP from external ALB"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.external_lb_sg.id]
  }

  ingress {
    description = "Allow HTTPS traffic"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["217.55.137.98/32"] #my ip
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
#-----------------------------------------------------
#internal load balancer security group
resource "aws_security_group" "internal_lb_sg" {
  name        = "internal_LB_SG"
  description = "Security group for internal Load Balancer"
  vpc_id      = var.vpc_id

  ingress {
    description     = "Allow HTTP from web tier"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.web_tier_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
#-----------------------------------------------------------
#private servers security group
resource "aws_security_group" "private_servers_sg" {
  name        = "private_servers_sg"
  description = "Security group for private servers"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 4000
    to_port         = 4000
    protocol        = "tcp"
    security_groups = [aws_security_group.internal_lb_sg.id]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["217.55.137.98/32"] #my ip
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
#--------------------------------------------------------------
#database security group
resource "aws_security_group" "database_sg" {
  name        = "database_sg"
  description = "Security group for database"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.private_servers_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
