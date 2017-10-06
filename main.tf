#
# DO NOT DELETE THESE LINES!
#
# Your AMI ID is:
#
#     ami-5a922335
#
# Your subnet ID is:
#
#     subnet-faec2e91
#
# Your security group ID is:
#
#     sg-c7eb27ad
#
# Your Identity is:
#
#     asas-ostrich
#

terraform {
  backend "atlas" {
    name = "jlagerweij/training"
  }
}

variable "aws_access_key" {}

variable "aws_secret_key" {}

variable "aws_region" {
  default = "eu-central-1"
}

variable "num_webs" {
  default = "3"
}

provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}

resource "aws_instance" "web" {
  ami                    = "ami-5a922335"
  instance_type          = "t2.micro"
  subnet_id              = "subnet-faec2e91"
  vpc_security_group_ids = ["sg-c7eb27ade"]
  count                  = "${var.num_webs}"

  tags {
    "Identity" = "asas-ostrich"
    "Trainee"  = "Jos"
    "Date"     = "6 october"
    "Name"     = "web ${count.index + 1} / ${var.num_webs}"
  }
}

output "public_ip" {
  value = ["${aws_instance.web.*.public_ip}"]
}

output "public_dns" {
  value = ["${aws_instance.web.*.public_dns}"]
}
