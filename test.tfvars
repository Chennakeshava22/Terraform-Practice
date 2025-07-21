#provider

region = "us-east-1"
profile = "test"

#vpc

vpc-cidr = "10.10.0.0/16"
vpc-name = "test-vpc"
igw-name = "test-igw"
pub-sub-cidr = "10.10.1.0/24"
pub-sub-name = "test-pub-subnet"
pri-sub-cidr = "10.10.2.0/24"
pri-sub-name = "test-priv-subnet"
pub-route-name = "test-pub-route"
in-cidr = "0.0.0.0/0"
pri-route-name = "test-priv-route"

#security group
sg-name = "test-sg"
descri = "inbound"
protoc = "tcp"
from-port = "80"
to-port ="80"
inbound-cidr = ["0.0.0.0/0"]

outbound-proto = "-1"
from-port-out = "0"
to-port-out = "0"
cidr-out = ["0.0.0.0/0"]

#instance
ami-id = "ami-0150ccaf51ab55a51"
keypair ="my-kp"
num ="1"
instance-name = "test-instance"
type = "t2.micro"
public-ip = "true"
