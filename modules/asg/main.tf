#Launchng WEB TIER EC2s
resource "aws_launch_template" "web-tier-1" {
  name_prefix            = "web-tier-1"
  image_id               = var.ami
  instance_type          = var.cpu
  vpc_security_group_ids = [var.web_tier_sg]
  #user_data = 
}
resource "aws_autoscaling_group" "web-tier-1" {
  name_prefix      = "web-tier-1"
  desired_capacity = var.desired_capacity
  min_size         = var.min_size
  max_size         = var.max_size
  vpc_zone_identifier = [
    var.public_sub_1_id,
    var.public_sub_2_id
  ]
  launch_template {
    id      = aws_launch_template.web-tier-1.id
    version = "$Latest"
  }
  target_group_arns         = [var.web_tg_arn]
  health_check_type         = "ELB"
  health_check_grace_period = 200
  default_instance_warmup   = 60
  termination_policies      = ["OldestInstance"]
  tag {
    key                 = "Name"
    value               = "web-instance"
    propagate_at_launch = true
  }
  lifecycle {
    create_before_destroy = true
  }
}
#-----------------------------------------------------------------
#Launchng APP TIER EC2s
resource "aws_launch_template" "app-tier-1" {
  name_prefix            = "app-tier-1"
  image_id               = var.ami
  instance_type          = var.cpu
  vpc_security_group_ids = [var.private_servers_sg]
  #user_data = 
}
resource "aws_autoscaling_group" "app-tier-1" {
  name_prefix      = "app-tier-1"
  desired_capacity = var.desired_capacity
  min_size         = var.min_size
  max_size         = var.max_size
  vpc_zone_identifier = [
    var.private_sub_1a_id,
    var.private_sub_2a_id
  ]
  launch_template {
    id      = aws_launch_template.app-tier-1.id
    version = "$Latest"
  }
  target_group_arns         = [var.app_tg_arn]
  health_check_type         = "ELB"
  health_check_grace_period = 200
  default_instance_warmup   = 60
  termination_policies      = ["OldestInstance"]
  tag {
    key                 = "Name"
    value               = "app-instance"
    propagate_at_launch = true
  }
  lifecycle {
    create_before_destroy = true
  }
}
