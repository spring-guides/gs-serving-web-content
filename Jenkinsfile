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
         sh 'mvn -Dmaven.test.failure.ignore clean package'
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
