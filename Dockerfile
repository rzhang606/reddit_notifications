FROM python:alpine3.7

COPY . /

WORKDIR /

RUN pip install -r requirements.txt

CMD ["python", "./script/fetch_notifications.py"]