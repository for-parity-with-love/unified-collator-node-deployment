terraform {
 backend "gcs" {
   bucket  = "${random_id.bucket_prefix.hex}-bucket-tfstate"
   prefix  = "terraform/state"
 }
}
