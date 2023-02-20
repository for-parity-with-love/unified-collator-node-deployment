terraform {
  backend "s3" {
      bucket                 = "collator-bucket"
      workspace_key_prefix   = "terraform/collator-envs"       #change this just in case you know what are you doing
      key                    = "tfstate"
      region                 = "eu-central-1"
      profile                = "collator"
      #dynamodb_table        = "terraform-state-lock"    #uncomment this just in case dynamodb table was created and using
  }
}
