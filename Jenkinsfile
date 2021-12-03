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