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

  repository_name = "dmitriyshub-zero-downtime-app"

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

# public ecr
resource "aws_ecrpublic_repository" "public-ecr2" {
  provider = aws.us_east_1

  repository_name = "dmitriyshub-zero-downtime-app-2"

  catalog_data {
    about_text        = "simple flask webserver 2"
    description       = "docker image for k8s 2"
  }

  tags = {
    owner = "terraform"
    env = "test"
    name = "dmitriyshub-zero-downtime-app-2"
  }
}

# ecr 1 resource metadata output
output "public-ecr-arn" {
  value = aws_ecrpublic_repository.public-ecr.arn
}
output "public-ecr-id" {
  value = aws_ecrpublic_repository.public-ecr.id
}
output "public-ecr-uri" {
  value = aws_ecrpublic_repository.public-ecr.repository_uri
}



# ecr 2 resource metadata output
output "public-ecr-arn-2" {
  value = aws_ecrpublic_repository.public-ecr2.arn
}
output "public-ecr-id-2" {
  value = aws_ecrpublic_repository.public-ecr2.id
}
output "public-ecr-uri-2" {
  value = aws_ecrpublic_repository.public-ecr2.repository_uri
}