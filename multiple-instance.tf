variable "ami_id" {
}
variable "total" {
}
variable "key" {
}
variable "type" {
}
variable "name" {
}





resource "aws_instance" "multiple" {
  ami = var.ami_id
  count = var.total
  key_name = var.key
  instance_type = var.type
  tags = {
   Name = "${var.name}-${count.index + 1}"
  }
}






variable "instances" {
  default = ["dev", "test", "prod"]
}

resource "aws_instance" "instance" {
  ami = "ami-0150ccaf51ab55a51"
  instance_type = "t2.micro"
  key_name = "my-kp"
  count = length(var.instances)
  tags = {
    Name = var.instances[count.index]
  }
}

