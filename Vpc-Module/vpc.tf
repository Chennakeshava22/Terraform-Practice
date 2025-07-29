provider "aws" {
  region = var.region
}

resource "aws_vpc" "vp" {
  cidr_block = var.cidr
  tags = {
    Name = var.vpc_name
}
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vp.id
  tags = {
    Name = var.igw_name
  }

}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vp.id
  tags = {
    Name = var.pub_r_name
  }
}


resource "aws_subnet" "pub_subnet" {
  vpc_id = aws_vpc.vp.id
  cidr_block = var.pub_cidr
  tags = {
    Name = var.pub_sub_name
  }
}

resource "aws_route" "internet_access" {
  route_table_id = aws_route_table.public.id
  gateway_id = aws_internet_gateway.igw.id
  destination_cidr_block = var.dest_cidr
}



resource "aws_route_table_association" "a" {
  subnet_id  = aws_subnet.pub_subnet.id
  route_table_id = aws_route_table.public.id
}



resource "aws_route_table" "priv" {
  vpc_id = aws_vpc.vp.id
  tags = {
    Name = var.priv_r_name
  }
}

resource "aws_subnet" "priv_subnet" {
  vpc_id = aws_vpc.vp.id
  cidr_block = var.priv_cidr
  tags = {
    Name = var.priv_sub_name
  }
}

resource "aws_route_table_association" "b" {
  subnet_id = aws_subnet.priv_subnet.id
  route_table_id = aws_route_table.priv.id
}


