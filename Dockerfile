# FROM openjdk:11-jdk-alpine			#使用openjdk:8-jdk-alpine作为基础镜像
FROM openjdk:11
ARG JAR_FILE						#定义JAR_FILE变量，在使用docker build时可以使用--build-arg <varname>=<value>对他赋值
COPY ${JAR_FILE} app.jar			#将JAR_FILE路径下的文件拷贝成app.jar文件
EXPOSE 8008
ENTRYPOINT ["java","-jar","/app.jar"]#使用java -jar命令运行app.jar文件
