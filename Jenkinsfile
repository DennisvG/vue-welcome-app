pipeline {
  agent any
  stages {
    stage('Build docker image') {
      steps {
        sh '''echo \'Create docker image\' '''
        script {
          dockerImage = docker.build imageName + ":$BUILD_ID"
        }
      }
    }
    stage('Push docker image') {
      steps {
        sh '''echo \'Push image to docker\' '''
        script {
          docker.withRegistry(imageRegisterUrl, imageRegisterCredentials ) {
            dockerImage.push()
          }
        }
      }
    }

  }
  environment {
    imageRegisterUrl = ''
    imageRegisterCredentials = 'Dockerhub'
    imageName = 'dengruns/vue-welcome-app'
    dockerImage=''
  }
  post {
    cleanup {
      cleanWs()
      dir("${workspace}@tmp") {
        deleteDir()
      }

    }

  }
}