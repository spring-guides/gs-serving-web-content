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
         sh 'mvn clean package -f /complete/pom.xml'
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
