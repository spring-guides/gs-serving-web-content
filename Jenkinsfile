#!/usr/bin/env groovy

pipeline 
{

    agent any
	tools {
        maven 'M3'
    }
    stages {
      stage('Build') 
      {
	  steps {
         sh 'cd ./complete/'
         sh 'mvn clean package'
      }
	  }
   stage('Results') 
      {
	  steps {
      junit '**/target/surefire-reports/TEST-*.xml'
      archive 'target/*.jar'
	  }
      }
    }
   }
