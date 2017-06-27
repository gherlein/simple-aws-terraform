variable "UNAME" {}

provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "test" {
  ami = "ami-8b92b4ee"
  instance_type = "t2.micro"
  count = 1
  tags {
    Name     = "${var.UNAME}-test"
    owner    = "${var.UNAME}"
    project  = "personal"
    function = "testing"
  }
}

