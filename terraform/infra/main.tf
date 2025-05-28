module "security_group" {
  source           = "./modules/security_group"
  name             = "web-sg"
  ssh_cidr = var.ssh_cidr
}

module "ec2_instance" {
  source            = "./modules/ec2_instance"
  name              = "web-instance"
  instance_type     = "t2.micro"
  security_group_id = module.security_group.security_group_id
}
