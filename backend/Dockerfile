FROM maven:3.8.2-openjdk-16-slim as builder

ARG VERSION

WORKDIR /usr/src/app
COPY ./src ./src
COPY *.xml ./
RUN curl https://storage.yandexcloud.net/cloud-certs/CA.pem -o YandexInternalRootCA.crt \
    && mvn package -Dversion.application=${VERSION}


FROM openjdk:16-jdk-alpine

ARG VERSION

WORKDIR /app
COPY --from=builder /usr/src/app/YandexInternalRootCA.crt .
COPY vault.crt .
RUN keytool -importcert -file YandexInternalRootCA.crt -alias yandex -cacerts -storepass changeit -noprompt \
    && keytool -importcert -file vault.crt -alias vault -cacerts -storepass changeit -noprompt \
    && rm -rf YandexInternalRootCA.crt vault.crt \
    && addgroup --system jaruser \
    && adduser -S -s /bin/false -G jaruser jaruser -D -H \
    && apk add --no-cache dumb-init=1.2.5-r0 curl=7.79.1-r3
COPY --chown=jaruser:jaruser \
     --from=builder /usr/src/app/target/sausage-store-${VERSION}.jar ./sausage-store.jar

EXPOSE 8080
USER jaruser
ENTRYPOINT ["dumb-init", "java", "-jar", "-Dmyserver.bindPort=8080", "./sausage-store.jar"] 
