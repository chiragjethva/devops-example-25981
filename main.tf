

data "aws_vpc" "default" {
  default = true
}

module "sg" {
  source = "./modules/sg"
  vpc_id = data.aws_vpc.default.id
}


module "ec2" {
  source           = "./modules/ec2"
  vpc_id           = data.aws_vpc.default.id
  key              = "mykey"
  ami_id           = "ami-0cf6f5c8a62fa5da6"
  instance_type    = "t2.micro"
  name             = "myInstance"
  sgid             = module.sg.security_group_id
  private_key_path = "./mykey.pem"
  versionname      = ${{ GITHUB_RUN_ID }}
}

module "rds" {
  source = "./modules/rds"
  sgid   = module.sg.security_group_id
}

module "redis-cluster" {
  source = "./modules/redis"
  sgid   = module.sg.security_group_id
}

