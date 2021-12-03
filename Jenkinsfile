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

    stage('Build Application') {
      steps {
        sh 'npm run build'
      }
    }

    stage('Build docker image') {
      agent {
        dockerfile {
          filename 'Dockerfile'
          additionalBuildArgs "--no-cache"
          //registryUrl "${DOCKERIMAGEURL}"
          registryCredentialsId "${DOCKERCREDENTIALS}"
        }

      }
      steps {
        echo 'Create Docker image'
      }
    }

  }
  environment {
    // home nessecary for running npm install
    HOME = '.'
    DOCKERIMAGEURL = "https://hub.docker.com"
    DOCKERCREDENTIALS = "Dockerhub"
    IMAGENAME = "dengruns/vue-welcome-app"
  }
  post {
    cleanup {
      // clean workspace
      cleanWs()
      // remove tmp dir
      dir("${workspace}@tmp") {
        deleteDir()
      }

    }

  }
}