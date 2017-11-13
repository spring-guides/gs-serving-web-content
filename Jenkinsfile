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
        stage('Publish artifacts to Nexus')
              {
                  steps {
					script {
          version = readFile 'version.txt'
		  jarpath = readFile 'jarpath.txt'
						nexusPublisher nexusInstanceId: 'nexus-host', nexusRepositoryId: 'releases', packages: [[$class: 'MavenPackage', mavenAssetList: [[classifier: '', extension: '', filePath: 'complete/target/gs-serving-web-content-1.0.jar']], mavenCoordinate: [artifactId: 'gs-serving-web-content', groupId: 'org.springframework', packaging: 'jar' ,version: '1.0']]]
        }
                    
                  }
              }

   stage('Results')
      {
          steps {
      junit '**/target/surefire-reports/TEST-*.xml'
      archive 'complete/target/*.jar'
      sh 'chmod 755 bumptonextsnapshot.sh'
         sh './bumptonextsnapshot.sh'
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

