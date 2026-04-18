output "external_lb_sg_id" {
  value = aws_security_group.external_lb_sg.id
}

output "web_tier_sg_id" {
  value = aws_security_group.web_tier_sg.id
}

output "internal_lb_sg_id" {
  value = aws_security_group.internal_lb_sg.id
}

output "private_servers_sg_id" {
  value = aws_security_group.private_servers_sg.id
}

output "database_sg_id" {
  value = aws_security_group.database_sg.id
}
