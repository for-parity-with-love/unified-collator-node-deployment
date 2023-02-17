terraform {
 backend "gcs" {
   bucket  = "collator-bucket-tfstate"
   prefix  = "terraform/state"
 }
}
