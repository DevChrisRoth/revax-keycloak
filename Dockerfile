FROM quay.io/keycloak/keycloak:latest as builder


# Enable health and metrics support
ENV KC_METRICS_ENABLED=${KC_METRICS_ENABLED}
ENV KC_DB=${KC_DB}
ENV KC_DB_URL=${DB_ADDR}
ENV KC_DB_USERNAME=${DB_USER}
ENV KC_DB_PASSWORD=${DB_PASSWORD}
ENV KEYCLOAK_ADMIN=${KEYCLOAK_ADMIN}
ENV KEYCLOAK_ADMIN_PASSWORD=${KEYCLOAK_ADMIN_PASSWORD}

# Change working directory
WORKDIR /opt/keycloak
RUN /opt/keycloak/bin/kc.sh build

FROM quay.io/keycloak/keycloak:latest

COPY --from=builder /opt/keycloak/ /opt/keycloak/

ENTRYPOINT [ "/opt/keycloak/bin/kc.sh" ]
CMD [ "start-dev" ]
