variable "project_name" {}
variable "region" {}
variable "vpc_cidr" {}
variable "public_sub_1_cidr" {}
variable "public_sub_2_cidr" {}
variable "private_sub_1a_cidr" {}
variable "private_sub_2a_cidr" {}
variable "private_sub_1b_cidr" {}
variable "private_sub_2b_cidr" {}
variable "db_username" {}
variable "db_password" {
  sensitive = true
}

