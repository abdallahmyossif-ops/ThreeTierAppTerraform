variable "project_name" {}
variable "vpc_id" {}
variable "database_sg_id" {}
variable "private_sub_1b_id" {}
variable "private_sub_2b_id" {}
variable "db_username" {}
variable "db_password" {}
variable "db_sub_name" {
  default = "webapp-3-tier-db"
}
variable "db_name" {
  default = "webapp-3-tier-db"
}
