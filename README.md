# django-prod


This is simple django production ready docker container. It contains nginx+gunicorn serving static content and running wsgi server for django project, managed by supervisord.


## Simple usage example

~~~~
# clone django structure for easy start
mkdir django-prod
cd django-prod
git init
git remote add upstream https://github.com/bradojevic/django-prod
git pull upstream master
# run django
docker run --name django-app --restart=always -d -p 80:80 -v $(pwd):/opt/app bradojevic/django-prod
~~~~

## Using it with MYSQL

in settings.py set mysql as your database

~~~~
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': os.environ.get('MYSQL_ENV_MYSQL_DATABASE'),
        'USER': os.environ.get('MYSQL_ENV_MYSQL_USER'),
        'PASSWORD': os.environ.get('MYSQL_ENV_MYSQL_PASSWORD'),
        'HOST': os.environ.get('MYSQL_PORT_3306_TCP_ADDR'),
        'PORT': os.environ.get('MYSQL_PORT_3306_TCP_PORT'),
    }
}
~~~~

~~~~
# run django
docker run --name django-app --restart=always -d -p 80:80 \
  -v $(pwd):/opt/app \
  -e MYSQL_PORT_3306_TCP_ADDR=172.17.0.1 \
  -e MYSQL_ENV_MYSQL_DATABASE='your db name' \
  -e MYSQL_ENV_MYSQL_USER='your db user' \
  -e MYSQL_ENV_MYSQL_PASSWORD='your db password' \
  -e MYSQL_PORT_3306_TCP_PORT=3306 \
  bradojevic/django-prod
~~~~

Note: 172.17.0.1 is my docker host ip, you can find yours using `ifconfig | grep -A 1 docker`.


## Customizations

You should add your git repo as 'origin' remote so something like this

~~~~
cd django-prod
git remote add origin http://your-git-repo
git push origin master
~~~~

Now you could edit `run` command in Makefile to support your needs, and commit this to your git repo.
