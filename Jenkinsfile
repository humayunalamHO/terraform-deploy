pipeline {
    agent any
    tools {
      maven 'maven'
    }

    parameters {
      choice choices: ['apply', 'destroy'], description: 'Action to be taken on the Terraform configuration', name: 'action'
    }

    stages {
        stage('Checkout') {
            steps {
            checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/humayunalamHO/terraform-deploy.git']]])            

          }
        }

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
        stage ("terraform init") {
//            when ${BRANCH_NAME} == 'main'
            steps {
                sh 'terraform init' 
            }
        }
        
        stage ("terraform Action") {
//            when ${BRANCH_NAME} == 'main'
            steps {
                echo "Terraform action is --> {$action}"
                sh 'terraform ${action} --auto-approve'
           }
        }

        stage ("Ansible deploy") {
          when {
            expression { params.action == 'apply' }
            steps {
              sh 'ansible-playbook ansible/tomcat-setup.yml -i ansible/inventory.yml -u jenkins'
          }    
       }    
     }
  }
}

