pipeline{
    agent any
    tools {
      maven 'maven'
    }
    environment {
      DOCKER_TAG = getVersion()
    }
    stages{
        stage('SCM'){
            steps{
                git credentialsId: 'github', 
                    url: 'https://github.com/javahometech/dockeransiblejenkins'
            }
        }
        
        stage('Maven Build'){
            steps{
                sh "mvn clean package"
            }
        }
        stage('DeployToContainer'){
            steps{
                deploy adapters: [tomcat9(credentialsId: 'pradnyesh', path: '', url: 'http://3.109.211.207:8080/')], contextPath: null, war: '**/*.war'
            }
        }
        stage('Docker Build'){
            steps{
                sh "sudo docker build . -t pradnyeo/hariapp:${DOCKER_TAG} "
            }
        }
        
        stage('DockerHub Push'){
            steps{
                
                withCredentials([string(credentialsId: 'docker-hub', variable: 'dockerHubPwd')]) {
                       sh "sudo docker login -u pradnyeo -p ${dockerHubPwd}"
                }
                
                sh "sudo docker push pradnyeo/hariapp:${DOCKER_TAG} "
            }
        }
        
        stage('Docker Deploy'){
            steps{
              ansiblePlaybook credentialsId: 'ansible-node', disableHostKeyChecking: true, extras: "-e DOCKER_TAG=${DOCKER_TAG}", installation: 'ansible', inventory: 'dev.inv', playbook: 'deploy-docker.yml'
            }
        }
    }
}

def getVersion(){
    def commitHash = sh label: '', returnStdout: true, script: 'git rev-parse --short HEAD'
    return commitHash
}
