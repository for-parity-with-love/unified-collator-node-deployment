resource "random_id" "bucket_prefix" {
  byte_length = 8
}

resource "google_storage_bucket" "backend" {
  name          = "collator-bucket-tfstate"
  force_destroy = false
  location      = "US"
  storage_class = "STANDARD"
  versioning {
    enabled = true
  }
}
