#!/usr/bin/env groovy

pipeline 
{

    agent any
    stages 
   {
      stage('Preparation'){
	      steps {
          git 'https://github.com/Rajdash/gs-serving-web-content.git'
          def mvnHome       
          mvnHome = tool 'M3'
         }
		 }
      stage('Build') 
      {
	  steps {
         sh "'${mvnHome}/bin/mvn' -Dmaven.test.failure.ignore clean package"
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
