import praw
import json

with open('script/authorization.json', 'r') as auth_file:
    data = json.load(auth_file)


reddit = praw.Reddit(client_id = data['client_id'],
                    client_secret = data['client_secret'],
                    user_agent = data['user_agent'])

subreddit = reddit.subreddit(data['subreddit'])

new_post_titles = list()

for title in data['titles']:
    for post in subreddit.search('[DISC] ' + title, sort='new', time_filter='day', limit=10):
        new_post_titles.append(post)

for i in new_post_titles:
    print(i.title)
