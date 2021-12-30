def getAppVersion() {
  def pack = readJSON file: "package.json"
  return pack.version
}

pipeline {
  agent any
  stages {
    stage('Build docker image') {
      steps {
        sh '''echo \'Create docker image\' '''
        script {
          dockerImage = docker.build ("${imageName}:${applicationVersion}", "-f Dockerfile .")
        }
      }
    }
    stage('Push docker image') {
      steps {
        sh '''echo \'Push image to docker\' '''
        script {
          docker.withRegistry('', imageRegisterCredentials ) {
            dockerImage.push()
            dockerImage.push('latest')
          }
        }
      }
    }

  }
  environment {
    imageRegisterUrl = ''
    imageRegisterCredentials = 'Dockerhub'
    imageName = 'dengruns/vue-welcome-app'
    applicationVersion = getAppVersion()
    dockerImage=''
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