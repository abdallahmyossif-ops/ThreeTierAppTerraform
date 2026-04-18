output "ec2-role-arn" {
  value = aws_iam_role.ec2-ssm.arn
}
output "ec2-role-name" {
  value = aws_iam_role.ec2-ssm.name
}
#------------------------------------------------------------
output "s3-role-name" {
  value = aws_iam_role.s3-role.name
}
output "s3-role-arn" {
  value = aws_iam_role.s3-role.arn
}
