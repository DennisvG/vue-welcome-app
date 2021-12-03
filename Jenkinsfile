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

    stage('Cleanup Workspace') {
      steps {
        cleanWs(cleanWhenAborted: true, cleanWhenFailure: true, cleanWhenNotBuilt: true, cleanWhenSuccess: true, cleanWhenUnstable: true, cleanupMatrixParent: true, deleteDirs: true, disableDeferredWipeout: true, externalDelete: 'vue-welcome-app*')
      }
    }

  }
  environment {
    HOME = '.'
  }
}