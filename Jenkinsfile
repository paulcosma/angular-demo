pipeline {
  agent { label 'media' }
  environment {
        DEPLOY_TO = 'master'
  }
  options {
    buildDiscarder(logRotator(numToKeepStr: '1'))
  }
  triggers {
    cron('@weekly')
  }
  stages {
    stage('Checkout') {
      steps {
        git branch: 'master',
        credentialsId: '8cd52665-32ef-4dd3-b919-71f1dab02d84',
        url: 'git@github.com:paulcosma/angular-demo.git'

      }
    }
    stage('Build') {
      steps {
        sh 'docker build -t paulcosma/angular-demo-app .'
      }
    }
    stage('Publish') {
      steps {
        withDockerRegistry([ credentialsId: "052cba25-f00d-4ff2-b593-4e143b90515a", url: "" ]) {
          sh 'docker push paulcosma/angular-demo-app:latest'
        }
      }
    }
    stage ('DEPLOY-apps-stack') {
      steps {
        build job: 'DEPLOY-docker-apps'
      }
    }
  }
}
