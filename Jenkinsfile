pipeline
{

    agent any
        tools {
        maven 'M3'
    }
    stages {
      stage('Bump release version')
      {
          steps {
          sh 'chmod 755 bumptonextrelease.sh'
          sh './bumptonextrelease.sh'
          }
      }
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
   stage('Provision/Devploy application'){
      steps {
             sh 'chmod 755 provision-app.sh'
			 sh './provision-app.sh ${BUILD_NUMBER}'
          }
          }
   stage('Smoke Test'){
	   steps {
	        sh 'chmod 755 Smoketest.sh'
			sh './Smoketest.sh'
          }
        
	}
    }
   }
