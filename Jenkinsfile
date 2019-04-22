pipeline {
  agent { label 'web-server_root' }
  environment {
        DEPLOY_TO = 'master'
  }
  options {
    buildDiscarder(logRotator(numToKeepStr: '3'))
  }
  triggers {
    cron('@daily')
  }
  stages {
    stage('Checkout') {
      steps {
        git branch: 'master',
        credentialsId: '747596f4-8a62-4f10-889a-09db1e9cc9ae',
        url: 'git@github.com:paulcosma/angular-demo.git'

      }
    }
    stage('Build') {
      steps {
        sh 'docker build -t paulcosma/angular-demo-app .'
      }
    }
    stage('Login') {
      steps {
        sh 'docker login'
      }
    }
    stage('Publish') {
      when {
        // branch 'master'
        environment name: 'DEPLOY_TO', value: 'master'
      }
      steps {
        withDockerRegistry([ credentialsId: "e80fc77a-7fce-4fbd-98ee-c7aa4d5a6952", url: "" ]) {
          sh 'docker push paulcosma/angular-demo-app:latest'
        }
      }
    }
    stage('Start App') {
      steps {
        sh 'docker stop angular-demo-app || true && docker rm angular-demo-app || true'
        sh 'docker run -d --restart always --name angular-demo-app -p 49161:4200 paulcosma/angular-demo-app'
      }
    }
  }
}
