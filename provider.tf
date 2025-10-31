terraform {
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "6.0"
        }
    }
    backend "s3" {
        bucket = "SS-StateFile"
        key    = "DevOps-Project/StorySphere/"
        region = "ap-south-1"
        use_lockfile = true
    }
}

provider "aws" {
  region = "ap-south-1"
}