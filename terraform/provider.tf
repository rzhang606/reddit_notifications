provider "google" {
  version = "3.5.0"

  credentials = file("reddit-notifs-tf-creds.json")

  project = "reddit-notifications"
  region  = "us-central1"
  zone    = "us-central1-c"
}