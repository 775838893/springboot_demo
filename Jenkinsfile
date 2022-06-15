def project_url = "git@gitee.com:hhsheng/springboot_demo.git"
def tag = "latest"
def repo_url = "swr.cn-southwest-2.myhuaweicloud.com"
def imageName = "${project_name}:${tag}"

node {
    def mvnHome
    stage('pull') {
        checkout([$class: 'GitSCM', branches: [[name: '*/${branch}']], extensions: [],
        userRemoteConfigs: [[credentialsId: "${gitlab_auth}", url: "${project_url}"]]])
    }

    stage('pack') {
        sh "mvn clean package dockerfile:build"
        sh "docker tag ${imageName} ${repo_url}/${docker_project_name}/${imageName}"
        sh "docker rmi ${imageName}"
    }

    stage('uploading') {
        withCredentials([usernamePassword(credentialsId: 'huaweitmp', passwordVariable: 'password', usernameVariable: 'username')]) {
            sh "docker login -u ${username} -p ${password} ${repo_url}"
            sh "docker push ${repo_url}/${docker_project_name}/${imageName}"
            sh "echo 镜像上传成功"
        }
    }
    stage('releases') {
        //找到流水线语法sshPublisher:send bulid artifacts over ssh，其它的不管；execCommand中为deployy.sh脚本路径
        sshPublisher(publishers: [sshPublisherDesc(configName: 'nginx1', transfers: [sshTransfer(cleanRemote: false, excludes: '', execCommand: "${env.WORKSPACE}/deploy.sh $repo_url $docker_project_name $project_name $tag $port", execTimeout: 120000, flatten: false, makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', remoteDirectory: '', remoteDirectorySDF: false, removePrefix: '', sourceFiles: '')], usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: false)])
    }

}
