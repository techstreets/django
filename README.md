# django-prod

This is simple django production ready docker container. It contains nginx+gunicorn serving static content and running wsgi server for django project, managed by supervisord.

By default this machine will create container listening on all interfaces on port 8001. Container is called 'django_app'.


## Simple usage example

~~~~
# clone django structure for easy start
mkdir django-prod
cd django-prod
git init
git remote add upstream https://github.com/bradojevic/django-prod
git pull upstream master
make create
~~~~

## Using it with MYSQL

in settings.py un-comment this part

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

To export needed env variables, you need to define env file. For development simply add needed env variables in env file in root. This is all you need to do. Actually there are mysql settings comment out in that file already, just make them work for your machine.


## Customizations

You should add your git repo as 'origin' remote so something like this

~~~~
cd django-prod
git remote add origin http://your-git-repo
git push origin master
~~~~

Now you could edit `create` command in Makefile to support your needs, and commit this to your git repo.


## Development

In dev mode, you could simple run this docker container, simply use make tool. However, it could be easier to user virtualenv in dev mode. Install virtualenvwrapper and make new env. Activate it and source env.sh if you need to load some env variables.


## Production

You should change 'SECRET_KEY', 'DEBUG' and 'ALLOWED_HOSTS' for sure! You can generate secret key using provided make.

If you need to provide some env variables, you should probably place env file on some place on prod machine other then git repo for security reasons.
To do this, simply `export django_app_env=/path/to/your/env/file` and it will be used when you `make create`.
