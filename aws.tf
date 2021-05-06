provider "aws" {
  region = "us-west-2"
}

terraform {
  backend "s3" {
    bucket  = "crowdboticstest"
    key     = "test"
    region  = "us-west-2"
    encrypt = "true"
  }

}
