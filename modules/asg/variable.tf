variable "project_name" {}
variable "ami" {
  default = "ami-053b0d53c279acc90"
}
variable "cpu" {
  default = "t3.micro"
}
variable "max_size" {
  default = 4
}
variable "min_size" {
  default = 2
}
variable "desired_capacity" {
  default = 2
}
variable "private_sub_1a_id" {}
variable "private_sub_2a_id" {}
variable "public_sub_1_id" {}
variable "public_sub_2_id" {}
variable "web_tier_sg" {}
variable "private_servers_sg" {}
variable "web_tg_arn" {}
variable "app_tg_arn" {}
