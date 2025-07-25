module "test" {
  source = "./ec2-instance"
  ami_id = "ami-08a6efd148b1f7504"
  insta_type = "t2.micro"
  kp = "my-kp"
  no = 3
  name = "test-server"
}

