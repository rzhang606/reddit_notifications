# Script Cron Job Module

**Description:**
Given a script with its necessary files in a zip file, this module creates a bucket for the script, a cloud function, and a scheduler job to run. Requires the gcp provider definition in parent module.

## Variables

**Bucket**
- bucket_name
    - description: name of the bucket

**Bucket Object**
- bucket_object_name
    - description: object name (aka your script)
- bucket_object_source
    - description: path or source to zip file

**Function**
- function_name
    - description: name of the function
- entry_point
    - description: the function to be called in the script

**Scheduler**
- cron_schedule
    - description: cron formatted schedule

**Misc**
- service_account_email
    - description: the service account for running the function, requires "Cloud functions invoker" and "cloud scheduler admin"
