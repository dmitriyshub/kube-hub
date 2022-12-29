terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  alias = "us_east_1"
  region = "us-east-1"
}

# public ecr
resource "aws_ecrpublic_repository" "public-ecr" {
  provider = aws.us_east_1

  repository_name = "dmitriyshub-zero-downtime-appr"

  catalog_data {
    about_text        = "simple flask webserver"
    description       = "docker image for k8s"
  }

  tags = {
    owner = "terraform"
    env = "test"
    name = "dmitriyshub-zero-downtime-app"
  }
}
# ecr resource metadata output
output "public-ecr-arn" {
  value = aws_ecrpublic_repository.public-ecr.arn
}
output "public-ecr-id" {
  value = aws_ecrpublic_repository.public-ecr.id
}
output "public-ecr-uri" {
  value = aws_ecrpublic_repository.public-ecr.repository_uri
}