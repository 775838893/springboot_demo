def project_url = "git@gitee.com:hhsheng/springboot_demo.git"
def gitlab_auth = "26c0dc65-e2ce-43e7-8574-a950c0adfdb7"
def tag = "latest"
def repo_url = "swr.cn-southwest-2.myhuaweicloud.com"
def docker_project_name = "dp-test"
def imageName = "${project_name}:${tag}"

node {
    def mvnHome
    stage('pull') {
        checkout([$class: 'GitSCM', branches: [[name: '*/${branch}']], extensions: [],
        userRemoteConfigs: [[credentialsId: "${gitlab_auth}", url: "${project_url}"]]])
    }

    stage('pack') {
        sh "mvn -f ${project_name} clean package dockerfile:build"
        sh "docker tag ${imageName} ${repo_url}/${docker_project_name}/${imageName}"
    }

    stage('uploading') {
        withCredentials([usernamePassword(credentialsId: 'huaweitmp', passwordVariable: 'password', usernameVariable: 'username')]) {
            sh "docker login -u ${username} -p ${password} ${repo_url}"
            sh "docker push ${repo_url}/${docker_project_name}/${imageName}"
            sh "echo 镜像上传成功"
        }
    }
    stage('远程发布') {
        //找到流水线语法sshPublisher:send bulid artifacts over ssh，其它的不管；execCommand中为deployy.sh脚本路径
        sshPublisher(publishers: [sshPublisherDesc(configName: 'sysnthesis-cloud', transfers: [sshTransfer(cleanRemote: false, excludes: '', execCommand: "/root/projectReleased/sysnthesiscloud/deploy.sh $harbor_url $docker_project_name $project_name $tag $port", execTimeout: 120000, flatten: false, makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', remoteDirectory: '', remoteDirectorySDF: false, removePrefix: '', sourceFiles: '')], usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: false)])
    }

}
