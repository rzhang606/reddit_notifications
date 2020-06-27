# Bucket to hold scripts
resource "google_storage_bucket" "buckyy" {
    name = "pythonscripts"
    location = "us-central1"
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

# Runs the script
resource "google_cloudfunctions_function" "function" {
  name        = "func-reddit"
  description = "Function to launch reddit script"
  runtime     = "python37"

  available_memory_mb   = 128
  source_archive_bucket = google_storage_bucket.buckyy.name
  source_archive_object = google_storage_bucket_object.reddit_script.name
  trigger_http          = true
  entry_point           = "send_notifs"
  service_account_email = "functionrunner@reddit-notifications.iam.gserviceaccount.com"
}

#Cloud Scheduler Job
resource "google_cloud_scheduler_job" "job" {
  name             = "cloud-function-runner"
  description      = "Runs a cloud function using HTTP target"
  schedule         = "0 8 * * *"
  time_zone        = "America/Los_Angeles"

  http_target {
    http_method = "POST"
    uri         = google_cloudfunctions_function.function.https_trigger_url

    oidc_token {
      service_account_email = "functionrunner@reddit-notifications.iam.gserviceaccount.com"
    }
  }
}