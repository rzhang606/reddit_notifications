# Reddit Post Notification Sender
Grab posts from reddit and send notifications (possibly through SMS) if the search criteria is met.

**Instructions (Local running)**

Prerequisites: Sign up as a developer to be able to use the reddit api. Create an application for the client id and secret.

1. Create a authorization.json file under `script/`

2. Add your information (from your reddit account) to the authorization.json. The Fields are ... 
    - client_id
    - client_secret
    - user_agent

3. (Optional) I included subreddit name and search terms in the json file as well to keep all the data in one place

4. Run 'docker build -t [name reference here] .
   Notice the period above ^

5. Run 'docker run [name reference]'

6. Thats it


**GCP Instructions** 

1. Create a zip file with your auth file, main.py, and requirements

2. Upload it under a google cloud bucket

3. Create a google cloud function, using the zip file as the source. Test the function after it builds, to see if it works

4. Use google cloud scheduler to schedule the task as often as you would like
