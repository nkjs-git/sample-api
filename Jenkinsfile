pipeline {
  environment {
    registry = "naveen19/sample-js"
    registryCredential = "dockerhub" #just a placeholder
    dockerImage = ''
  }
  agent any
  stages {
    stage('Cloning Git') {
      steps {
        git 'https://github.com/nkjs-git/sample-api.git'
      }
    }
    stage('Building image') {
      steps{
        script {
          dockerImage = docker.build registry + ":1.0.$BUILD_NUMBER"
        }
      }
    }
    stage('Push Image') {
      steps{
        script {
          docker.withRegistry( '', registryCredential ) {
            dockerImage.push()
          }
        }
      }
    }
    stage('Remove previous container and image') {
      steps{
        script {
            sh "sh cleanup-script.sh"
          }
        }
    }
    stage('Deploy Container') {
      steps{
        script {
          docker.withRegistry( '', registryCredential ) {
            dockerImage.run('-p 8080:8080 --name sample-service')
          }
        }
      }
    }
  }
}
