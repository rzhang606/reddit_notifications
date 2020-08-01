module "cron-job" {
    source = "./modules/cron-job"

    bucket_name = "pythonscripts"
    bucket_object_name = "reddit_script"
    bucket_object_source = "../script/reddit_notifs_src.zip"

    function_name = "func-reddit"
    entry_point = "send_notifs"

    cron_schedule = "0 8 * * *"

    service_account_email = "functionrunner@reddit-notifications.iam.gserviceaccount.com"
}