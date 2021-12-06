pipeline {
  agent {
    any
  }
  stages {
    stage('Init app') {
      agent {
        docker {
          image 'node:lts-alpine'
        }
      }
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
      agent {
        docker {
          image 'node:lts-alpine'
        }
      }
      steps {
        echo 'Application test'
      }
    }

    stage('Build production dist') {
      agent {
        docker {
          image 'node:lts-alpine'
        }
      }
      steps {
        sh 'npm run build'
      }
    }

    stage('Build docker image') {
      agent {
        any
      }
      steps {
        sh '''echo \'Create Docker image\'
        docker build -t $IMAGENAME:$BUILD_ID'''
        sh '''docker run -d --name $IMAGENAME-$BUILD_ID $IMAGENAME:$BUILD_ID
        sleep 6'''
        sh '''echo "container logging:"
        docker logs $IMAGENAME-$BUILD_ID'''
        sh '''echo "Stopping and remove docker container"
        docker kill $IMAGENAME-$BUILD_ID
        docker rm $IMAGENAME-$BUILD_ID'''
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