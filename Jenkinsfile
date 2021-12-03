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
        cleanup { 
          /* clean up our workspace */
            cleanWs()
          /* clean up tmp directory */
            dir("${workspace}@tmp") {
                deleteDir()
            }
        }
    }
  environment {
    HOME = '.'
  }
}