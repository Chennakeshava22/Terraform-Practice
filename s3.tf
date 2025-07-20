
variable "bytelength" {
}
variable "bucketname" {
}




resource "random_id" "my_id" {
  byte_length = var.bytelength
}

resource "aws_s3_bucket" "bucket" {
  bucket = "${var.bucketname}-${random_id.my_id.hex}"
  tags = {
    Name = "${var.bucketname}-${random_id.my_id.hex}"
  }
}

