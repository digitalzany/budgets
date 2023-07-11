#! /bin/bash

python /app/manage.py migrate

if [ $? == 1 ]; then
    echo "App initialization failed. Exiting."
    exit 1
else
    echo "Starting app..."
fi

python manage.py collectstatic --no-input

#python /app/manage.py runserver 0.0.0.0:8000
uwsgi --yaml budgets/uwsgi.yaml

exit $?
