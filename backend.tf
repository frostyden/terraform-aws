# Generated by Terragrunt. Sig: nIlQXj57tbuaRZEa
terraform {
  backend "s3" {
    bucket         = "terraform-up-and-running-state-for-denizkin"
    dynamodb_table = "terraform-up-and-running-lock-for-denizkin"
    encrypt        = true
    key            = "terraform.tfstate"
    region         = "eu-central-1"
  }
}