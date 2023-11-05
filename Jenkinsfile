pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
            checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/humayunalamHO/terraform-deploy.git']]])            

          }
        }
        
        stage ("terraform init") {
            steps {
                sh ('terraform init') 
            }
        }
        
        stage ("terraform Action") {
            steps {
                echo "Terraform action is --> \$action"
//                sh ('terraform apply --auto-approve')
                  sh ('terraform destroy --auto-approve') 
           }
        }

//        stage ("Execute Ansible") {
//            steps {
//                ansiblePlaybook become: true, becomeUser: 'jenkins', installation: 'ansible', inventory: '/ansible/inventory', playbook: '/ansible/main.yml', sudoUser: 'jenkins', vaultTmpPath: ''

        }
    }
