terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.29"
    }
  }
}
locals { environment_name = terraform.workspace }

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "example" {
  count         = terraform.workspace == "prod" ? 2 : 1
  ami           = "ami-011899242bb902164" # Ubuntu 20.04 LTS // us-east-1
  instance_type = "t3.micro"
  subnet_id     = module.vpc.public_subnets[0]
  tags = {
    env = terraform.workspace
    Name = format("%s-%s",terraform.workspace,count.index)
  }
}