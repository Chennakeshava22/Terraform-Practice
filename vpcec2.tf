provider "aws" {
  region = "${var.region}"
  profile = "${var.profile}"
}




resource "aws_vpc" "vpc" {
  cidr_block = "${var.vpc-cidr}"
  tags = {
    Name = "${var.vpc-name}"
  }
}

resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.igw-name}"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = "${var.pub-sub-cidr}"
  tags = {
    Name = "${var.pub-sub-name}"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = "${var.pri-sub-cidr}"
  tags = {
    Name = "${var.pri-sub-name}"
  }
}

resource "aws_route_table" "public_route" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.pub-route-name}"
  }
}

resource "aws_route" "internet_access" {
  route_table_id = aws_route_table.public_route.id
  destination_cidr_block = "${var.in-cidr}"
  gateway_id = aws_internet_gateway.my_igw.id
}


resource "aws_route_table_association" "a" {
  subnet_id = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route.id
}

resource "aws_route_table" "priv_route" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.pri-route-name}"
  }
}


resource "aws_route_table_association" "b" {
  subnet_id = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.priv_route.id
}


# security group creation
resource "aws_security_group" "sg" {
  name = "${var.sg-name}"
  vpc_id = aws_vpc.vpc.id

  # inbound rules
  ingress {
    description = "${var.descri}"
    protocol = "${var.protoc}"
    from_port = "${var.from-port}"
    to_port = "${var.to-port}"
    cidr_blocks = "${var.inbound-cidr}"
  }

  # outbound rules
  egress {
    protocol = "${var.outbound-proto}"
    from_port = "${var.from-port-out}"
    to_port = "${var.to-port-out}"
    cidr_blocks = "${var.cidr-out}"
  }



  tags = {
    Name = "${var.sg-name}"
  }
}






# instance creation from the vpc

resource "aws_instance" "my_instance" {
  ami = "${var.ami-id}"
  key_name = "${var.keypair}"
  count = "${var.num}"
  associate_public_ip_address = "${var.public-ip}"
  instance_type = "${var.type}"
  vpc_security_group_ids = [aws_security_group.sg.id]
  subnet_id = aws_subnet.public_subnet.id
  tags = {
    Name = "${var.instance-name}"
  }
}



