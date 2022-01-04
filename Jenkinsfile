def getAppVersion() {
  def pack = readJSON file: "package.json"
  return pack.version
}

pipeline {
  agent any
  stages {
    stage('Package helm') {
      steps {
        milestone 0
        withCredentials([usernamePassword(credentialsId: "Artifactory", usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
        sh """                        
                helm repo add dengruns-helm https://dengruns.jfrog.io/artifactory/api/helm/dengruns-helm --username \'$USERNAME\' --password \'$PASSWORD\'
                helm dependency update \$PWD/\$HELM_DIR/
              
                helm package \$PWD/\$HELM_DIR/
                helm push-artifactory vue-welcome-app-0.1.0.tgz helm-local --username \'$USERNAME\' --password \'$PASSWORD\'
            """
        }
      }
    }
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