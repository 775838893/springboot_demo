#!/bin/bash

harbor_url=$1
harbor_project_name=$2
project_name=$3
tag=$4
port=$5

imageName=$harbor_url/$harbor_project_name/$project_name:$tag

echo "$imageName"

containerId=`docker ps -a | grep -w ${project_name}:${tag} | awk '{print $1}'`
if [ "$containerId" != "" ] ; then
    docker stop $containerId
    docker rm $containerId

        echo "成功删除容器"
fi


imageId=`docker images | grep -w $project_name | awk '{print $3}'`
if [ "$imageId" != "" ] ; then

    docker rmi -f $imageId

        echo "删除成功"
fi


docker login -u yourname -p yourpasswd $harbor_url


docker pull $imageName

docker run -di -p $port:$port  --name $project_name $imageName
# docker run -di -p $port:$port --net=host $imageName
echo "启动成功"