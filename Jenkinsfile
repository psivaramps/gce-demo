pipeline {
    agent any
     
    stages {
        stage ('checkout'){
            steps {
                git branch: 'main', url: 'hhttps://github.com/psivaramps/gce-demo.git'
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
                dir("terraform-gce") 
                {
                sh 'terraform init'
                sh 'terraform plan'
                sh 'terraform apply -auto-approve'
             }
        }
        }
       
    }
}
