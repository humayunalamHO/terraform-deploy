pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
            checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/humayunalamHO/terraform-deploy.git']]])            

          }
        }
        
//        stage ("terraform init") {
//            when ${BRANCH_NAME} == 'main'
//            steps {
//                sh ('terraform init') 
//            }
//        }
//        
//        stage ("terraform Action") {
//            when ${BRANCH_NAME} == 'main'
//            steps {
//                echo "Terraform action is --> \$action"
//                sh ('terraform apply --auto-approve')
////                sh ('terraform destroy --auto-approve') 
//           }
//        }

        stage ("hello") {
            steps {
                echo "hello world!"
            }
        }

        stage ("Ansible deploy") {
            steps {
//                ansiblePlaybook become: true, credentialsId: 'jenkins-ssh', disableHostKeyChecking: true, playbook: 'site.yml', inventory: 'inventory.yml'
                ansiblePlaybook becomeUser: 'jenkins', credentialsId: 'jenkins-ssh', inventory: 'inventory.yml', playbook: 'main.yml'
            }
        }

        }
    }
