pipeline {
  agent any
  stages {
    stage('Init app') {
      agent {
        docker {
          image 'node:lts-alpine'
        }

      }
      steps {
        sh '''node --version
npm --version'''
        sh 'npm install'
        sh '''pwd
ls -l'''
      }
    }

  }
}