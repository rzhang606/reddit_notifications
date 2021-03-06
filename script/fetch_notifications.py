import praw
import json
from twilio.rest import Client

with open('script/authorization.json', 'r') as auth_file:
    data = json.load(auth_file)


reddit = praw.Reddit(client_id = data['client_id'],
                    client_secret = data['client_secret'],
                    user_agent = data['user_agent'])

subreddit = reddit.subreddit(data['subreddit'])

new_post_titles = list()

for title in data['titles']:
    for post in subreddit.search('[DISC] ' + title, sort='new', time_filter='day', limit=10):
        new_post_titles.append(post.title)


#Send SMS message
if new_post_titles != list():

    account_sid = data['twilio_sid']
    auth_token = data['twilio_auth_token']

    client = Client(account_sid, auth_token)

    message = client.messages \
        .create(
            body=data['message'] + ' - ' + ", ".join(new_post_titles), #message here
            from_=data['twilio_number'], #twilio phone number - ex. +12223334444
            to=data['receiver_number'] #your phone number
        )

    print(message.sid)