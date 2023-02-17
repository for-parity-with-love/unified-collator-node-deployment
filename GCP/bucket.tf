resource "google_storage_bucket_object" "default" {
  name = "terraform.tfvars"
  source       = "./terraform.tfvars"
  content_type = "text/plain"
  bucket       = google_storage_bucket.backend.id
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
