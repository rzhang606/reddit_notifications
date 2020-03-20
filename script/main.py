import praw
import json
import os
from twilio.rest import Client
from twilio.http.http_client import TwilioHttpClient

def main():
    send_notifs()

def send_notifs(request):

    print("Started running send_notifs ... ")

    proxy_client = TwilioHttpClient()
    proxy_client.session.proxies = {'https':os.environ['https_proxy']}

    with open('/home/rzhang606/reddit_notifications/script/authorization.json', 'r') as auth_file:
        data = json.load(auth_file)


    reddit = praw.Reddit(client_id = data['client_id'],
                        client_secret = data['client_secret'],
                        user_agent = data['user_agent'])

    subreddit = reddit.subreddit(data['subreddit'])

    print("Authentication set up ... ")

    new_post_titles = list()

    for title in data['titles']:
        for post in subreddit.search('[DISC] ' + title, sort='new', time_filter='day', limit=10):
            new_post_titles.append(post.title)

    print("Reddit posts found/not found ...")


    #Send SMS message
    if new_post_titles != list():

        account_sid = data['twilio_sid']
        auth_token = data['twilio_auth_token']

        client = Client(account_sid, auth_token, http_client=proxy_client)

        message = client.messages \
            .create(
                body=data['message'] + ' - ' + ", ".join(new_post_titles), #message here
                from_=data['twilio_number'], #twilio phone number - ex. +12223334444
                to=data['receiver_number'] #your phone number
            )

        print("Sending SMS")

        print(message.sid)