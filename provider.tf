# should be exported the env vars: AWS_ACCESS_KEY, AWS_SECRET_KEY 
provider "aws" {
  region = var.AWS_REGION
}

