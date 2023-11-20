pipeline {
    agent any
    tools {
//      maven 'maven'

    }

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

        stage ('initialise') {
          steps {
            sh '''
                    echo "PATH = ${PATH}"
                    echo "M2_HOME = ${M2_HOME}"
            '''                    
          }
        }

        stage ('Build') {
          steps {
            sh 'mvn clean package'
          }
        }
        stage ("hello") {
            steps {
                echo "hello world!"
            }
        }

        stage ("Ansible deploy") {
            steps {
              sh 'ansible-playbook main.yml -i inventory.yml -u jenkins'
//                ansiblePlaybook become: true, credentialsId: 'jenkins-ssh', disableHostKeyChecking: true, playbook: 'site.yml', inventory: 'inventory.yml'
//                ansiblePlaybook become: 'true', credentialsId: 'jenkins-ssh', disableHostKeyChecking: true, inventory: 'inventory.yml', playbook: 'main.yml'
       }    
     }
  }
}
