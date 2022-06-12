pipeline {
    agent any

    stages {
        stage('pull') {
            steps {
                echo 'pull code'
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: '26c0dc65-e2ce-43e7-8574-a950c0adfdb7', url: 'git@gitee.com:hhsheng/springboot_demo.git']]])
            }
        }
        
        stage('build') {
            steps {
                echo 'build code'
                sh 'mvn clean package'
            }
        }
        
        stage('deploy') {
            steps {
                echo 'deploy code'
            }
        }
    }
}

