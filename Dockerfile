FROM python:3.8-alpine

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

ENV PATH="/scripts:$PATH"

COPY ./requirements.txt /requirements.txt

RUN pip install --upgrade pip
RUN apk update 
RUN apk add --virtual build-deps gcc python3-dev musl-dev
RUN apk add postgresql
RUN apk add postgresql-dev
RUN pip install psycopg2
RUN apk add jpeg-dev zlib-dev libjpeg
RUN pip install Pillow
RUN pip install -r /requirements.txt
RUN apk del build-deps

RUN mkdir /inspi_app
COPY ./team_inspiration /inspi_app
WORKDIR /inspi_app
COPY ./scripts /scripts

RUN chmod +x /scripts/*

RUN mkdir -p /vol/web/media

RUN mkdir -p /vol/web/static

RUN adduser -D user
RUN chown -R user:user /vol
RUN chmod -R 755  /vol/web
USER user

CMD [ "entrypoint.sh"]