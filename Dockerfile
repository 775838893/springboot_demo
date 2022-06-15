FROM openjdk:11-jre-slim-buster
ARG artifactid
ENV ARTIFACTID=${artifactid} \
    ARTIFACTVERSION=0.0.1-SNAPSHOT \
    HOME_PATH=/home
WORKDIR $HOME_PATH
ADD $ARTIFACTID-$ARTIFACTVERSION.jar $HOME_PATH/$ARTIFACTID.jar
EXPOSE 8008
ENTRYPOINT ["/bin/sh", "-c", "exec java -jar /home/${ARTIFACTID}.jar"]
