pipeline{
    agent any
    tools {
  maven 'maven3'
}
    
    stages{
        stage('SCM'){
            steps{
                git credentialsId: 'github', 
                    url: 'https://github.com/Quophi11/CI-CD-Deployment-using-Ansible-CM-Tool.git'
            }
        }
        
        stage('Maven Build'){
            steps{
                sh "mvn clean package"
            }
        }
    
        stage('Docker Build'){
            steps{
                sh "docker build . -t quophi11/first-app"
            }
        }
        stage('DockerHub Push'){
            steps{
                withCredentials([string(credentialsId: 'dockerhub', variable: 'dockerhubpwd')]) {
                    sh "docker login -u quophi11 -p ${dockerhubpwd}"
                }
                    sh "docker push quophi11/first-app" 
            }
        }
    
        stage('Docker Deploy'){
            steps{
                ansiblePlaybook credentialsId: 'dev_server', disableHostKeyChecking: true, installation: 'ansible', inventory: 'dev.inv', playbook: 'deploy-docker.yml'
            }
        }
    }
}
