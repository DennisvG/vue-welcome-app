pipeline {
  agent any
  stages {
    stage ('Debug docker cmd') {
      steps {
        sh 'echo "path setting: $PATH "'
        sh 'which docker'
      }
    }
    stage ('debug agent docker') {
      agent {
        docker {
          image 'node:lts-alpine'
          args '-p 3000:3000'
        }
      }
      steps {
        sh 'echo "path setting: $PATH "'
        sh 'which docker'
      }
    }
  //  stage('Build docker image') {
    //   steps {
    //     sh '''echo \'Create docker image\' '''
    //     script {
    //       dockerImage = docker.build imageName + ":$BUILD_ID"
    //     }
    //   }
    // }
    // stage('Push docker image') {
    //   steps {
    //     sh '''echo \'Push image to docker\' '''
    //     script {
    //       docker.withRegistry('', imageRegisterCredentials ) {
    //         dockerImage.push()
    //         dockerImage.push('latest')
    //       }
    //     }
    //   }
    // }

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