pipeline {
    agent any
	environment {
    	SVC_ACCOUNT_KEY = credentials('terraform_auth')
 	 }
    stages {
        
      stage('Set creds') {
            steps {
              
                sh 'echo $SVC_ACCOUNT_KEY | base64 -d > ./terraform-dev.json'
		            sh 'pwd'
               }
        }
	stage('Set Terraform path') {
            steps {
                script {
                    def tfHome = tool name: 'Terraform'
                    env.PATH = "${tfHome}:${env.PATH}"
                }
                sh 'terraform --version'
          }
        }
        
         stage('Provision infrastructure') {
            steps {
                sh 'terraform init'
                sh 'terraform plan'
                sh 'terraform apply -auto-approve'
             }
        }
        }
       
    }

