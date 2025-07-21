
region = "us-east-1"
profile = "prod"
vpc-cidr = "30.30.0.0/16"
vpc-name = "prod-vpc"
igw-name = "prod-igw"
pub-sub-cidr = "30.30.1.0/24"
pub-sub-name = "prod-pub-subnet"
pri-sub-cidr = "30.30.2.0/24"
pri-sub-name = "prod-priv-subnet"
pub-route-name = "prod-pub-route"
in-cidr = "0.0.0.0/0"
pri-route-name = "prod-priv-route"




#security group
sg-name = "prod-sg"
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
instance-name = "prod-instance"
type = "t2.micro"
public-ip = "true"
