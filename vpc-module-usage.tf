module "vpc" {
  source = "./VPC"
  region = "us-east-1"
  cidr = "10.10.0.0/16"
  vpc_name = "my-vpc"
  igw_name = "my-igw"
  dest_cidr = "0.0.0.0/0"
  pub_r_name = "pub-route"
  pub_cidr = "10.10.1.0/24"
  pub_sub_name = "pub-sub"
  priv_r_name = "priv-route"
  priv_sub_name = "priv-sub"
  priv_cidr = "10.10.2.0/24"
}

