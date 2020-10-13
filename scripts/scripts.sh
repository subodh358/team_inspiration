#!/bin/sh

set -e

python manage.py collectstatic --noinput

gunicorn team_inspiration.wsgi:application --bind 0.0.0.0:8000