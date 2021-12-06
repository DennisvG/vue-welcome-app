pipeline {
  agent any
  stages {
    stage('Build docker image') {
      agent any
      steps {
        sh '''echo \'Create Docker image\'
        docker build -t $IMAGENAME:$BUILD_ID .
        docker tag $IMAGENAME:$BUILD_ID $IMAGENAME:latest'''
        sh '''echo \'inspect Docker image\'
        docker inspect -f . $IMAGENAME:$BUILD_ID'''
      }
    }  

  }
  environment {
    DOCKERIMAGEURL = ''
    DOCKERCREDENTIALS = 'Dockerhub'
    IMAGENAME = 'dengruns/vue-welcome-app'
  }
  post {
    cleanup {
      dir("${workspace}*") {
        deleteDir()
      }

    }

  }
}