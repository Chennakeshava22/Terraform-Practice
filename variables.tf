#provider
variable "region" {}
variable "profile" {}
#vpc route and subnet and igw
variable "vpc-cidr" {}
variable "vpc-name" {}
variable "igw-name" {}
variable "pub-sub-cidr" {}
variable "pub-sub-name" {}
variable "pri-sub-cidr" {}
variable "pri-sub-name" {}
variable "pub-route-name" {}
variable "in-cidr" {}
variable "pri-route-name" {}



# security group
variable "sg-name" {}
variable "descri" {}
variable "protoc" {}
variable "from-port" {}
variable "to-port" {}
variable "inbound-cidr" {}

variable "outbound-proto" {}
variable "from-port-out" {}
variable "to-port-out" {}
variable "cidr-out" {}



#instance
variable "ami-id" {}
variable "keypair" {}
variable "num" {}
variable "instance-name" {}
variable "type" {}
variable "public-ip" {}

