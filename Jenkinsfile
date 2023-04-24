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
                    url: 'https://github.com/pradnyeo/dockeransiblejenkins.git'
            }
        }

        //Build war file

        stage('Maven Build'){
            steps{
                sh "mvn clean package"
            }
        }

	//Deploy war file on Dev Server
        stage('DeployToContainer'){
            steps{
                deploy adapters: [tomcat9(credentialsId: 'server-1', path: '', url: 'http://13.232.126.154:8080/')], contextPath: null, war: '**/*.war'
            }
        }

        // Deploy Artifact on Nexus

        stage ('DeployToNexusArtifact') {
            steps {
                //Deploy to Nexus Repo
              // nexusArtifactUploader artifacts: [[artifactId: 'dockeransible', classifier: '', file: '/mnt/jenkins-slave/workspace/Nexus_Project/target/dockeransible.war', type: 'war']], credentialsId: 'nexus', groupId: 'in.javahome', nexusUrl: '13.233.7.12:8081/', nexusVersion: 'nexus3', protocol: 'http', repository: 'maven-snapshots', version: '1.0-SNAPSHOT'
            nexusArtifactUploader artifacts: [
		    [artifactId: 'dockeransible', 
		     classifier: '', 
		     file: '/home/pradnyesh/.jenkins/workspace/Project-2/target/dockeransible.war', 
		     type: 'war']
	    ], 
		    credentialsId: 'nexus',
		    groupId: 'in.javahome', 
		    nexusUrl: '13.233.7.12:8081/', 
		    nexusVersion: 'nexus3', 
		    protocol: 'http', 
		    repository: 'maven-deploy', 
		    version: '1.0-SNAPSHOT'
	    }       
        }

       //Build an Docker Image
	stage('Docker Build'){
            steps{
                sh "sudo docker build . -t pradnyeo/hariapp:${DOCKER_TAG} "
            }
        }


      //Push docker image to DockerHub

        stage('DockerHub Push'){
            steps{
                
                withCredentials([string(credentialsId: 'docker-hub', variable: 'dockerHubPwd')]) {
                       sh "sudo docker login -u pradnyeo -p ${dockerHubPwd}"
                }
                
                sh "sudo docker push pradnyeo/hariapp:${DOCKER_TAG} "
            }
        }
        


     //Deployment using Ansible playbook

    //    stage('Docker Deploy'){
    //        steps{
             // ansiblePlaybook credentialsId: 'ansible-node', disableHostKeyChecking: true, extras: "-e DOCKER_TAG=${DOCKER_TAG}", installation: 'ansible', inventory: 'dev.inv', playbook: 'deploy-docker.yml'
             // ansiblePlaybook credentialsId: 'ansible-node', extras: 'DOCKER_TAG', installation: 'ansible', inventory: 'dev.inv', playbook: 'deploy-docker.yml'
        //    ansiblePlaybook credentialsId: 'ansible', extras: 'DOCKER_TAG', installation: 'ansible', inventory: 'dev.inv', playbook: 'deploy-docker.yml'
      //      }
      //  }
    }
}

def getVersion(){
    def commitHash = sh label: '', returnStdout: true, script: 'git rev-parse --short HEAD'
    return commitHash
}
