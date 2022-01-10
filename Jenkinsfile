pipeline {
  agent {
    docker {
      image 'node:lts-alpine'
      args '-p 3000:3000'
    }
  }
  stages {
    stage ('init docker cmd') {
      steps {
        sh 'mkdir ./tmp'
        sh 'wget "$dockerDownloadUrl/$dockerDownloadFile" -O ./tmp/docker.tgz'
        sh 'tar xvf ./tmp/docker.tgz -C ./tmp'
        sh 'sudo cp ./tmp/docker/* /usr/bin/'
      }
    }
    stage ('debug agent docker') {
      steps {
        sh 'echo "path setting: $PATH "'
        sh 'which docker'
      }
    }
  //  stage('Build docker image') {
    //   steps {
    //     sh '''echo \'Create docker image\' '''
    //     script {
    //       dockerImage = docker.build imageName + ":$BUILD_ID"
    //     }
    //   }
    // }
    // stage('Push docker image') {
    //   steps {
    //     sh '''echo \'Push image to docker\' '''
    //     script {
    //       docker.withRegistry('', imageRegisterCredentials ) {
    //         dockerImage.push()
    //         dockerImage.push('latest')
    //       }
    //     }
    //   }
    // }

  }
  environment {
    imageRegisterUrl = ''
    imageRegisterCredentials = 'Dockerhub'
    imageName = 'dengruns/vue-welcome-app'
    dockerImage=''
    dockerDownloadUrl = 'https://download.docker.com/linux/static/stable/x86_64'
    dockerDownloadFile = 'docker-20.10.9.tgz'
  }
  // post {
  //   cleanup {
  //     cleanWs()
  //     dir("${workspace}@tmp") {
  //       deleteDir()
  //     }

  //   }

  // }
}