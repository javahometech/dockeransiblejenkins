pipeline{
    agent any
    environment{
        DOCKER_TAG = getVersion()
    }

    stages{
        stage('SCM'){
            steps{
                git 'https://github.com/sunilkvasu/dockeransiblejenkins.git'
            }
        }
        stage('Maven Build'){
            steps{
                sh "mvn clean package"
            }
        }
        stage('Docker Build'){
            steps{
                sh "docker build . -t sunilvasu/sunilapp:${DOCKER_TAG}"
            }
        }
        stage('DockerHub Push'){
            steps{
                withCredentials([string(credentialsId: 'docker-hub', variable: 'dockerHubPwd')]) {
                    sh "docker login -u sunilvasu -p ${dockerHubPwd}"
            }
                sh "docker push sunilvasu/sunilapp:${DOCKER_TAG}"
            }
        }
        stage('Docker Deploy'){
            steps{
                ansiblePlaybook credentialsId: '03dc2487-f1ba-4b04-b03e-7a896032f78c', disableHostKeyChecking: true, extras: '-e DOCKER_TAG="${DOCKER_TAG}"', installation: 'ansible', inventory: 'dev.inv', playbook: 'deploy-docker.yml'
            }
        }
    }
}

def getVersion(){
    def commitHash = sh label: '', returnStdout: true, script: 'git rev-parse --short HEAD'
    return commitHash
}
