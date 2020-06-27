#Bucket
variable "bucket_name" {
    default = "pythonscripts"
    type = string
}

#Bucket Object
variable "bucket_object_name" {
    default = "reddit_script"
    type = string
}

variable "bucket_object_source" {
    default = "../script/reddit_notifs_src.zip"
    type = string
}

#Function
variable "function_name" {
    default = "func-reddit"
    type = string
}

variable "entry_point" {
    default = "send_notifs"
    type = string
}

#Scheduler
variable "cron_schedule" {
    default = "0 8 * * *"
    type = string
}

#Misc
variable "service_account_email" {
    default = "functionrunner@reddit-notifications.iam.gserviceaccount.com"
    type = string
}