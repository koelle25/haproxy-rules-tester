# haproxy-rules-tester

## Prerequisites
You must already have installed [Docker] and [docker-compose].

## Info about the included example
The included example rewrites requests for [GitLab Pages][g-pages]. Usually it requires that a projects Pages-Website is accessed via `http(s)://<owner/group>.example.io/<project>`. In my case I did not have privileges to create a wildcard or additional subdomains for `example.io`. This example rewrites requests, so you can instead call `http://example.io/<owner/group>/<project>` and internally it gets converted to the "correct" URL which the backend then sees.

## Usage
Fire up the environment: `docker-compose up -d`.  
If you want to watch the logs you can use `docker-compose logs -f`.

The haproxy container listens on your http://localhost/ (default port 80). If you already have some other service listening change the port mapping in **docker-compose.yml** e.g. to "8080:80". Then you can instead visit http://localhost:8080/.

You can easily edit **haproxy.cfg** to test any rules and settings you'd like. After your changes you either have to:  
Reload the haproxy process running inside the container: `docker kill -s HUP haproxy-rules-tester_haproxy_1` (you may have to adjust the container name).  
OR  
Restart the haproxy container: `docker-compose restart haproxy`

By default the backends show the following information:
 - Status: `success` if your rules/ACLs were applied and forwarded your request to the success_backend, `fail` otherwise
 - Host: The hostname that the backend is getting from HAProxy (should match the requests hostname if not rewritten)
 - Path: The path that the backend is getting from HAProxy (should match the requests path if not rewritten)
 - Forwarded: If the backend got informed that this is a forwarded request
 - IP: Client-IP the backend sees
 - X-Forwarded-For: Well-known HTTP header indicating the real IP of the requesting client instead of the HAProxy IP
 - X-Forwarded-Host: Custom HTTP header containing the rewritten hostname (if applicable)
 - X-Forwarded-Server: Custom HTTP header indicating the requests original hostname (if applicable)

See [Sinatra Docs](sinatra-docs) for more possibilities.

[Docker](https://docs.docker.com/get-docker/)
[docker-compose](https://docs.docker.com/compose/install/)
[g-pages](https://docs.gitlab.com/ee/user/project/pages/)
[sinatra-docs](https://rubydoc.info/gems/sinatra)
