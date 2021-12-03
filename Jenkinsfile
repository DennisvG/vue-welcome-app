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

  }
  post { 
        always { 
            cleanWs()
        }
    }
  environment {
    HOME = '.'
  }
}