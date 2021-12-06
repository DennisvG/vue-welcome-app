pipeline {
  agent any
  Stages {
    stage('Build docker image') {
      agent any
      steps {
        sh '''echo \'Create Docker image\'
        docker build -t $IMAGENAME:$BUILD_ID'''
        sh '''echo \'inspect Docker image\'
        docker inspect -f . $IMAGENAME:$BUILD_ID'''
      }
    }  

  }
  environment {
    HOME = '.'
    DOCKERIMAGEURL = 'https://hub.docker.com'
    DOCKERCREDENTIALS = 'Dockerhub'
    IMAGENAME = 'dengruns/vue-welcome-app'
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