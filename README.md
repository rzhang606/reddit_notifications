# Reddit Post Notification Sender
Grab posts from reddit and send notifications if the search criteria is met.

**Instructions (Run Locally)**

Prerequisites: Sign up as a developer to be able to use the reddit api. Create an application for the client id and secret.

1. Create a authorization.json file under `script/`

2. Add your information (from your reddit account) to the authorization.json. The Fields are ... 
    - client_id
    - client_secret
    - user_agent

3. (Optional) I included subreddit name, search terms, twilio credentials in the json file as well to keep all the data in one place

4. Run 'docker build -t [name reference here] .
   Notice the period above ^

5. Run 'docker run [name reference]'

6. Thats it


**GCP Instructions** 

1. Prereqs
    - set up authorization.json file under scripts directory (depends on reddit api, twilio api)
    - get your gcp json credentials file under terraform directory
2. Run the launch bash script (root directory)
    - There seems to be an issue with the cloud function not updating source code after the bucket is updated, so it deletes all resources before applying for every run. If this behavior is undesireable, apply terraform manually.