pipeline {
  agent {
    docker {
      image 'node:lts-alpine'
    }
  }
  stages {
    stage('Init app') {
      steps {
        sh '''node --version
npm --version
'''
        sh '''pwd
ls -l'''
        sh 'npm install'
      }
    }

    stage('Test application') {
      steps {
        echo 'Application test'
      }
    }

    stage('Build production dist') {
      steps {
        sh 'npm run build'
      }
    }

    stage('Build docker image') {
      agent any
      steps {
        sh '''echo \'Create Docker image\'
        docker build -t $IMAGENAME:$BUILD_ID'''
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