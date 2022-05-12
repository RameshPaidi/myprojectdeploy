pipeline {
    agent {
        kubernetes {
            inheritFrom 'k8s-jenkins-default'
            defaultContainer 'toolchain'
            yaml '''
spec:
  containers:
  - name: toolchain
    image: artifactory.itk-engineering.de/prj-itk_globale_ci-cd-toolchain-docker/itk-cicd-demo-toolchain:1.0
    command:
    - cat
    tty: true
'''
        }
    }
    options {
        disableConcurrentBuilds()
        timeout(time: 1, unit: 'HOURS')
        buildDiscarder logRotator(daysToKeepStr: '25', numToKeepStr: '30')
        timestamps()
    }

    stages {
        stage('Build') {
            steps {
                sh 'bash ./000_cicd/build_script.sh'
            }
        }
		stage('Tests-Coverage') {
			
			steps {
        sh 'bash ./000_cicd/test_coverage.sh'
								}
				
			}
		
		
		stage('SonarQube Analysis') {
			environment {
		  sonarqubeScannerHome = tool name: 'SonarQubeScanner'
			def sonarUrl = "https://sonarqube.itk-engineering.de"
			def sonarPropertiesPath = "sonar-project.properties" // Define path to the sonar-project.properties file. Depends on the directory structure of the repositorys
			def projectKey = "prj-itk_cicd-samples_PAH_toolchain" //projectKey is sonarqube project specific, get it from sonarqube webui
			def jenkinsCredentialsId = "4a83e573-6ae9-44f1-825f-f9b165db2d44" //jenkinsCredentialsId is jenkins project specific, get if from jenkins webui
      }
      steps{
			withCredentials([usernamePassword(
			  credentialsId: "${jenkinsCredentialsId}",
			  usernameVariable: 'USERNAME',
			  passwordVariable: 'PASSWORD')]) {
				withSonarQubeEnv('SonarQube') {
				  // add -X for more debug output
				  sh "${sonarqubeScannerHome}/bin/sonar-scanner -Dsonar.host.url=${sonarUrl} -Dsonar.login='${USERNAME}' -Dsonar.password='${PASSWORD}' -Dsonar.projectKey=${projectKey} -Dsonar.branch.name=${env.BRANCH_NAME} -Dproject.settings='${sonarPropertiesPath}' -Dsonar.verbose=true"
		
      	}
        }
      
			  }
		  }
		}
    }
    
    
