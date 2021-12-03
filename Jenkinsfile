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
npm --version
# fix for error on rights
sudo chown -R 992:991 "/.npm"
'''
        sh '''pwd
ls -l'''
        sh 'npm install'
      }
    }

  }
}