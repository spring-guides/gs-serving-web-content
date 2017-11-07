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
         sh 'mvn clean package -f complete/pom.xml'
      }
	  }
   stage('Results') 
      {
	  steps {
      junit '**/target/surefire-reports/TEST-*.xml'
      archive 'target/*.jar'
	  }
      }
   stage('Deploy to CF'){
      steps {
	     sh 'cf login -a https://api.run.pivotal.io -u rajranjandash@gmail.com -p Rajranjan@123'
		 sh 'cf push spring-web-app -p complete/target/gs-serving-web-content-0.1.0.jar'
	  }
	  }
    }
   }
