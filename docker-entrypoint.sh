#! /bin/bash

python /app/manage.py migrate

if [ $? == 1 ]; then
    echo "App initialization failed. Exiting."
    exit 1
else
    echo "Starting app..."
fi

# TODO to use uWSGI
python /app/manage.py runserver 0.0.0.0:8000
#uwsgi --http 8000 --module=budgets.wsgi

exit $?
