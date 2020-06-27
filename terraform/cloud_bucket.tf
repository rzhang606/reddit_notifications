# Bucket to hold scripts
resource "google_storage_bucket" "buckyy" {
    name = "pythonscripts"
    location = "us-east1"
    force_destroy = true
    storage_class = "STANDARD"
}

# Bucket items (files)
resource "google_storage_bucket_object" "reddit_script" {
  name   = "reddit_script"
  source = "../script/reddit_notifs_src.zip"
  bucket = "pythonscripts"
  depends_on = [google_storage_bucket.buckyy]
}