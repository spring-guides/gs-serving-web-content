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
   stage('Provision/Devploy application'){
      steps {
             sh 'chmod 755 provision-app.sh'
			 sh './provision-app.sh ${BUILD_NUMBER}'
          }
          }
    }
   }
