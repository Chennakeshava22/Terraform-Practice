


variable "kp-name" {
  default = {
    "dev" = "dev-kp"
    "test" = "test-kp"
    "prod" = "prod-kp"
  }
}


variable "server-type" {
  default = {
    "dev" = "t2.micro"
    "test" = "t2.medium"
    "prod" = "t3.micro"
  }
}

variable "insta-name" {
  default = {
    "dev" = "dev-server"
    "test" = "test-server"
    "prod" = "prod-server"
  }
}
~

