# angular-sandbox

If you need to rebuild image you can use `make build`. If you need to expose different ports or something.

You can create container like this:

docker stop angular-sandbox; docker rm angular-sandbox; docker create --name angular-sandbox -p 9000:9000 -p 35729:35729 -v $(pwd)/src:/home/yeoman/src bradojevic/angular-sandbox && docker start angular-sandbox

To execute and command:
  docker exec -it angular-sandbox bash

To scaffold angular project do:
  docker exec -it angular-sandbox yo cg-angular

In order for `serve` to work we need to change grunt config so you should have
`grunt.initConfig` updated to:
    connect: {
      main: {
        options: {
          port: 9000,
          hostname: '0.0.0.0',
          livereload: 35729
        }
      }
    },

docker exec -it angular-sandbox grunt serve
