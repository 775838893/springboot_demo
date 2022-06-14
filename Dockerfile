FROM openjdk:11
ARG JAR_FILE
EXPOSE 8008
ENTRYPOINT ["java","-jar","springboot_demo.jar"]
