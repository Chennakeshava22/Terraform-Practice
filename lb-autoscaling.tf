provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "my_vpc" {
  cidr_block = "10.10.0.0/16"
  tags = {
    Name = "my-vpc"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "my-igw"
  }
}

variable "subnets" {
  default = [
    "10.10.10.0/24",
    "10.10.20.0/24",
    "10.10.30.0/24"
  ]
}

variable "az" {
  default = ["us-east-1a", "us-east-1b","us-east-1c"]
}



resource "aws_subnet" "sub" {
  vpc_id = aws_vpc.my_vpc.id
  count = length(var.subnets)
  cidr_block = var.subnets[count.index ]
  availability_zone = var.az[count.index]
  tags = {
    Name = "my-subnet-${count.index + 1}"
  }
}

#outputs
output "subnets_id" {
  value = [for i in aws_subnet.sub : i.id]
}

resource "aws_security_group" "sg" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "my-sg"
  }

  ingress {
    protocol = "tcp"
    from_port = 80
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    protocol = "tcp"
    from_port = 443
    to_port = 443
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    protocol = "-1"
    from_port = "0"
    to_port = "0"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_instance" "instance" {
  ami = "ami-0cbbe2c6a1bb2ad63"
  count = 3
  vpc_security_group_ids = [aws_security_group.sg.id]
  instance_type = "t2.micro"
  key_name = "my-kp"
  subnet_id = aws_subnet.sub[count.index].id
  tags = {
    Name = "my-instance-${count.index + 1}"
  }
}




resource "aws_lb_target_group" "tg" {
  name = "my-tg"
  port = 80
  protocol = "HTTP"
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "my-tg"
  }
}

resource "aws_lb_target_group_attachment" "test" {
  count = length(aws_instance.instance)
  target_group_arn = aws_lb_target_group.tg.arn
  target_id = aws_instance.instance[count.index].id
  port = 80
}

resource "aws_lb" "lb" {
  name = "my-lb"
  load_balancer_type = "application"
  internal = false
  subnets = [for i in aws_subnet.sub : i.id]
  security_groups = [aws_security_group.sg.id]
  tags = {
    Name = "my-lb"
  }

}

resource "aws_lb_listener" "end" {
  port = 80
  protocol = "HTTP"
  load_balancer_arn = aws_lb.lb.arn
  default_action  {
    type = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}


