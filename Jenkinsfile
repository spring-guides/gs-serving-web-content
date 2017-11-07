#!/usr/bin/env groovy

pipeline {
node {
   def mvnHome
   stage('Preparation') 
      git 'https://github.com/Rajdash/gs-serving-web-content.git'
              
      mvnHome = tool 'M3'
   }
   stage('Build') {
         sh "'${mvnHome}/bin/mvn' -Dmaven.test.failure.ignore clean package"
   }
   stage('Results') {
      junit '**/target/surefire-reports/TEST-*.xml'
      archive 'target/*.jar'
   }
   
}
