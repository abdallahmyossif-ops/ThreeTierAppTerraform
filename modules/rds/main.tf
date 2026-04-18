#Creating DB subnet group
resource "aws_db_subnet_group" "Subnet-group-DB" {
  name        = var.db_sub_name
  description = "Subnet group for database"
  subnet_ids  = [var.private_sub_1b_id, var.private_sub_2b_id]
}
#----------------------------------------------------
#creating DataBase RDS Instance
resource "aws_db_instance" "mysql_instance" {
  identifier             = "${var.project_name}-mysql-instance"
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t3.micro"
  allocated_storage      = 20
  storage_type           = "gp2"
  max_allocated_storage  = 100
  db_subnet_group_name   = aws_db_subnet_group.Subnet-group-DB.name
  vpc_security_group_ids = [var.database_sg_id]
  storage_encrypted      = true
  skip_final_snapshot    = true
  multi_az               = true # High Availability
  
  username               = var.db_username
  password               = var.db_password

  tags = {
    Name = "${var.project_name}-rds-mysql"
  }
}
