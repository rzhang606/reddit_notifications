# Bucket to hold scripts
resource "google_storage_bucket" "buckyy" {
    name = var.bucket_name
    location = "us-central1"
    force_destroy = true
    storage_class = "STANDARD"
}

# Bucket items (files)
resource "google_storage_bucket_object" "reddit_script" {
  name   = var.bucket_object_name
  source = var.bucket_object_source
  bucket = var.bucket_name
  depends_on = [google_storage_bucket.buckyy]
}

# Runs the script
resource "google_cloudfunctions_function" "function" {
  name        = var.function_name
  description = "Function to launch reddit script"
  runtime     = "python37"

  available_memory_mb   = 128
  source_archive_bucket = google_storage_bucket.buckyy.name
  source_archive_object = google_storage_bucket_object.reddit_script.name
  trigger_http          = true
  entry_point           = var.entry_point
  service_account_email = var.service_account_email
}

#Cloud Scheduler Job
resource "google_cloud_scheduler_job" "job" {
  name             = "cloud-function-runner"
  description      = "Runs a cloud function using HTTP target"
  schedule         = var.cron_schedule
  time_zone        = "America/Los_Angeles"

  http_target {
    http_method = "POST"
    uri         = google_cloudfunctions_function.function.https_trigger_url

    oidc_token {
      service_account_email = var.service_account_email
    }
  }
}