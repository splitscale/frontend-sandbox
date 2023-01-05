def runServer() {
  sh 'docker run --name frontend-sandbox --network fordastore -p 3000:3000 -d frontend-sandbox:latest'
}

pipeline {
    agent any

    stages {
        stage('initialize') {
      steps {
        sh 'npm -v'
        sh 'git --version'
        sh 'docker -v'
      }
        }

        stage('pull') {
      steps {
        checkout([$class: 'GitSCM', branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/splitscale/frontend-sandbox.git']]])
      }
        }

        stage('build') {
      steps {
        script {
          sh 'npx next build'
        }
      }
        }

        stage('build docker image') {
      steps {
        sh 'docker build -t frontend-sandbox:latest .'
      }
        }

        stage('deploy') {
          steps {
            script {
              try {
            runServer()
                        } catch (Exception e) {
            sh 'docker stop frontend-sandbox'
            sh 'docker rm frontend-sandbox'
            runServer()
              }
            }
          }
        }
    }
}