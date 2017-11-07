#!/usr/bin/env groovy

pipeline 
{

    agent any
	tools {
        maven 'apache-maven-3.3.9'
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
