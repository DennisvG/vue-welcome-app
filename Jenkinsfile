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
        }

      }
      steps {
        echo 'Create Docker image'
      }
    }

  }
  environment {
    HOME = '.'
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