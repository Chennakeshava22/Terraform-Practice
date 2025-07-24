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

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-rt"
  }
}

resource "aws_route_table_association" "rta" {
  count = length(aws_subnet.sub)
  subnet_id = aws_subnet.sub[count.index].id
  route_table_id = aws_route_table.rt.id
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




resource "aws_lb_target_group" "tg" {
  name     = "my-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.my_vpc.id

  health_check {
    protocol            = "HTTP"
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200-399"
  }

  tags = {
    Name = "my-tg"
  }
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

resource "aws_launch_template" "fool" {
  name_prefix = "foolbar"
  image_id = "ami-0cbbe2c6a1bb2ad63"
  instance_type = "t2.micro"
  key_name      = "my-kp"


  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.sg.id]
  }
  user_data = base64encode(<<-EOF
              #!/bin/bash
              sudo yum install -y httpd -y
              sudo systemctl enable httpd
              sudo systemctl start httpd
              echo "<h1>Hello from ASG instance</h1>" > /var/www/html/index.html
            EOF
  )

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "asg-instance"
    }
  }
}


resource "aws_autoscaling_group" "asg" {
  name = "my-asg"
  max_size = 4
  min_size = 2
  health_check_grace_period = 100
  health_check_type = "ELB"
  desired_capacity = 3
  force_delete = true
  target_group_arns = [aws_lb_target_group.tg.arn]
  vpc_zone_identifier = [for subnet in aws_subnet.sub : subnet.id]


  launch_template {
    id = aws_launch_template.fool.id
  }

}




output "alb_dns_name" {
  value = aws_lb.lb.dns_name
}

