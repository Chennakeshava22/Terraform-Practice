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

