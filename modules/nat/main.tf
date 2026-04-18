#First NAT gateway
resource "aws_eip" "eip_NAT_1" {
  domain = "vpc"
  tags = {
    Name = "${var.project_name}-eip-NAT-1"
  }
}

resource "aws_nat_gateway" "nat_1" {
  allocation_id = aws_eip.eip_NAT_1.id
  subnet_id     = var.public_sub_1_id
  tags = {
    Name = "${var.project_name}-nat-1"
  }
  depends_on = [aws_eip.eip_NAT_1]
}
#-------------------------------------------------------------
#Second NAT gateway
resource "aws_eip" "eip_NAT_2" {
  domain = "vpc"
  tags = {
    Name = "${var.project_name}-eip-NAT-2"
  }
}

resource "aws_nat_gateway" "nat_2" {
  allocation_id = aws_eip.eip_NAT_2.id
  subnet_id     = var.public_sub_2_id
  tags = {
    Name = "${var.project_name}-nat-2"
  }
}
#-------------------------------------------------------------
#private subnets route tables
resource "aws_route_table" "private_rt_1a" {
  vpc_id = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_1.id
  }

  tags = {
    Name = "${var.project_name}-private-rt-1a"
  }
}

resource "aws_route_table" "private_rt_2a" {
  vpc_id = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_2.id
  }

  tags = {
    Name = "${var.project_name}-private-rt-2a"
  }
}
#____________________________________________________
#associate private subnets with private route tables
resource "aws_route_table_association" "private_rt_association_1a" {
  subnet_id      = var.private_sub_1a_id
  route_table_id = aws_route_table.private_rt_1a.id
}

resource "aws_route_table_association" "private_rt_association_2a" {
  subnet_id      = var.private_sub_2a_id
  route_table_id = aws_route_table.private_rt_2a.id
}
#________________________________________________________
resource "aws_route_table" "private_rt_1b" {
  vpc_id = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_1.id
  }

  tags = {
    Name = "${var.project_name}-private-rt-1b"
  }
}

resource "aws_route_table" "private_rt_2b" {
  vpc_id = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_2.id
  }

  tags = {
    Name = "${var.project_name}-private-rt-2b"
  }
}
#_____________________________________________________
#associate the other private subnets
resource "aws_route_table_association" "private_rt_association_1b" {
  subnet_id      = var.private_sub_1b_id
  route_table_id = aws_route_table.private_rt_1b.id
}

resource "aws_route_table_association" "private_rt_association_2b" {
  subnet_id      = var.private_sub_2b_id
  route_table_id = aws_route_table.private_rt_2b.id
}
