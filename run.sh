#!/bin/bash
echo "=> Waiting for DB to be online"
python manage.py wait_for_database -s 3

echo "=> Performing database migrations..."
python manage.py migrate

echo "=> Ensuring Superusers..."
python manage.py ensureadmin

echo "=> Collecting Static.."
python manage.py collectstatic --noinput

# Start the first process
echo "=> Starting Server"
daphne -b 0.0.0.0 -p 80 --websocket_timeout -1 mikro_server.asgi:application 