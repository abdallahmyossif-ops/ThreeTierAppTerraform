
module "vpc" {
  source              = "../modules/vpc"
  project_name        = var.project_name
  vpc_cidr            = var.vpc_cidr
  public_sub_1_cidr   = var.public_sub_1_cidr
  public_sub_2_cidr   = var.public_sub_2_cidr
  private_sub_1a_cidr = var.private_sub_1a_cidr
  private_sub_2a_cidr = var.private_sub_2a_cidr
  private_sub_1b_cidr = var.private_sub_1b_cidr
  private_sub_2b_cidr = var.private_sub_2b_cidr
}

module "nat" {
  source = "../modules/nat"

  project_name      = var.project_name
  public_sub_1_id   = module.vpc.public_sub_1_id
  public_sub_2_id   = module.vpc.public_sub_2_id
  private_sub_1a_id = module.vpc.private_sub_1a_id
  private_sub_2a_id = module.vpc.private_sub_2a_id
  private_sub_1b_id = module.vpc.private_sub_1b_id
  private_sub_2b_id = module.vpc.private_sub_2b_id
  igw_id            = module.vpc.igw_id
  vpc_id            = module.vpc.vpc_id
}

module "security_group" {
  source = "../modules/security-group"
  vpc_id = module.vpc.vpc_id
}

module "alb" {
  source            = "../modules/alb"
  project_name      = var.project_name
  vpc_id            = module.vpc.vpc_id
  public_sub_1_id   = module.vpc.public_sub_1_id
  public_sub_2_id   = module.vpc.public_sub_2_id
  private_sub_1a_id = module.vpc.private_sub_1a_id
  private_sub_2a_id = module.vpc.private_sub_2a_id
  external_lb_sg_id = module.security_group.external_lb_sg_id
  internal_lb_sg_id = module.security_group.internal_lb_sg_id
}

module "asg" {
  source             = "../modules/asg"
  project_name       = var.project_name
  public_sub_1_id    = module.vpc.public_sub_1_id
  public_sub_2_id    = module.vpc.public_sub_2_id
  private_sub_1a_id  = module.vpc.private_sub_1a_id
  private_sub_2a_id  = module.vpc.private_sub_2a_id
  web_tier_sg        = module.security_group.web_tier_sg_id
  private_servers_sg = module.security_group.private_servers_sg_id
  web_tg_arn         = module.alb.web_tg_arn
  app_tg_arn         = module.alb.app_tg_arn
}

module "rds" {
  source            = "../modules/rds"
  project_name      = var.project_name
  vpc_id            = module.vpc.vpc_id
  database_sg_id    = module.security_group.database_sg_id
  private_sub_1b_id = module.vpc.private_sub_1b_id
  private_sub_2b_id = module.vpc.private_sub_2b_id
  db_username       = var.db_username
  db_password       = var.db_password
}
