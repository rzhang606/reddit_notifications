import praw
import json

with open('script/authorization.json', 'r') as auth_file:
    data = json.load(auth_file)


reddit = praw.Reddit(client_id = data['client_id'],
                    client_secret = data['client_secret'],
                    user_agent = data['user_agent'],
                    username = data['username'],
                    password = data['password'])

subreddit = reddit.subreddit('subreddit here')

top_subreddit = subreddit.top(limit=20)

for post in top_subreddit:
    print(post.title)


