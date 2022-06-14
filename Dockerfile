# FROM openjdk:11-jdk-alpine			#使用openjdk:8-jdk-alpine作为基础镜像
FROM openjdk:11
COPY *.jar /app.jar			#将JAR_FILE路径下的文件拷贝成app.jar文件
EXPOSE 8008
ENTRYPOINT ["java","-jar","/app.jar"]#使用java -jar命令运行app.jar文件
