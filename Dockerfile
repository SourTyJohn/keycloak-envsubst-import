ARG base_image=docker.io/bitnamilegacy/keycloak
ARG image_tag=26.3.2-debian-12-r1
ARG realms_dir=./realms

FROM ${base_image}:${image_tag}
    USER root

    # install required libs
    RUN apt-get update && apt-get install gettext-base

    # copying required files
	COPY --chown=1001 ./keycloak-envsubst.sh .
	RUN chmod +x ./keycloak-envsubst.sh
	
	# creating required dirs and setting ownership
    RUN mkdir -p /opt/bitnami/keycloak/data/imports
    RUN mkdir -p /var/lib/apt/lists/partial
    RUN chown 1001 -R /opt/bitnami/
	
	# copy realms file
    COPY ${realms_dir}/*.json /tmp/realms

# run
USER 1001
ENTRYPOINT [ "sh", "keycloak-envsubst.sh" ]