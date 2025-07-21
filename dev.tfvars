
region = "us-east-1"
profile = "dev"
vpc-cidr = "20.20.0.0/16"
vpc-name = "dev-vpc"
igw-name = "dev-igw"
pub-sub-cidr = "20.20.1.0/24"
pub-sub-name = "dev-pub-subnet"
pri-sub-cidr = "20.20.2.0/24"
pri-sub-name = "dev-priv-subnet"
pub-route-name = "dev-pub-route"
in-cidr = "0.0.0.0/0"
pri-route-name = "dev-priv-route"

#security group
sg-name = "dev-sg"
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
instance-name = "dev-instance"
type = "t2.micro"
public-ip = "true"

