# keycloak-envsubst-import
Docker image based on bitnami/keycloak. Uses envsubst command to replace env variables names in realm configs and imports them.

Note that envsubst can read only exported variables. You can do this with docker compose or by hand.

## Configuration

Dockerfile has multiple arguments to configure if you wish:

```Dockerfile
ARG base_image=docker.io/bitnamilegacy/keycloak
ARG image_tag=26.3.2-debian-12-r1
ARG realms_dir=./realms
```

`realms_dir` argument defines where should Dockerfile search for your realm configs. It will copy all json files from that directory.
