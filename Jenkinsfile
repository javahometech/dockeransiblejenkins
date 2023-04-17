pipeline{
    agent {
      label 'Built-In'   
    }
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
                deploy adapters: [tomcat9(credentialsId: 'pradnyesh', path: '', url: 'http://13.233.42.109:8080/')], contextPath: null, war: '**/*.war'
            }
        }
        stage('Docker Build'){
            steps{
                sh "sudo docker build . -t pradnyeo/hariapp:${DOCKER_TAG} "
            }
        }
        stage ('DeployToNexusArtifact') {
            steps {
                //Deploy to Nexus Repo
                nexusArtifactUploader artifacts: [
                    [artifactId: 'dockeransible', 
                    classifier: '', 
                    file: '/mnt/jenkins-slave/workspace/Project-2/target/dockeransible.war', 
                    type: 'war']], 
                    credentialsId: 'nexus', 
                    groupId: 'WebApp', 
                    nexusUrl: '15.206.124.160:8081/', 
                    nexusVersion: 'nexus3', 
                    protocol: 'http', 
                    repository: 'maven-deploy', 
                    version: '1.0-SNAPSHOT'
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
             // ansiblePlaybook credentialsId: 'ansible-node', disableHostKeyChecking: true, extras: "-e DOCKER_TAG=${DOCKER_TAG}", installation: 'ansible', inventory: 'dev.inv', playbook: 'deploy-docker.yml'
             // ansiblePlaybook credentialsId: 'ansible-node', extras: 'DOCKER_TAG', installation: 'ansible', inventory: 'dev.inv', playbook: 'deploy-docker.yml'
            ansiblePlaybook credentialsId: 'ansible', extras: 'DOCKER_TAG', installation: 'ansible', inventory: 'dev.inv', playbook: 'deploy-docker.yml'
            }
        }
    }
}

def getVersion(){
    def commitHash = sh label: '', returnStdout: true, script: 'git rev-parse --short HEAD'
    return commitHash
}
