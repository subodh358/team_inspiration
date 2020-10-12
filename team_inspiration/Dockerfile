FROM python:3.8-alpine
ADD . /webapp/
WORKDIR /webapp
RUN pip install --upgrade pip
RUN apk update \
    && apk add --virtual build-deps gcc python3-dev musl-dev \
    && apk add postgresql-dev \
    && pip install psycopg2 \
    && apk del build-deps
RUN pip install -r /webapp/requirements.txt
RUN python manage.py collectstatic 
RUN python manage.py makemigrations && python manage.py migrate
CMD gunicorn team_inspiration.wsgi:application --bind 0.0.0.0:$PORT