pipeline {
    agent any
    tools {
      maven 'maven'
    }

//    environment {
//    DEPLOY = 'YES'
//}
    parameters {
      choice choices: ['apply', 'destroy'], description: 'Humayun?', name: 'TERRAFOM-BUILD'
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
                echo "Terraform action is --> \$action"
                sh 'terraform ${action} --auto-approve'
//                sh ('terraform destroy --auto-approve') 
           }
        }

//        stage ("Ansible deploy") {
//            steps {
//              sh 'ansible-playbook ansible/tomcat-setup.yml -i ansible/inventory.yml -u jenkins'
//       }    
//     }

        stage ("ansible test") {
          when {
            expression { params.TERRAFOM-BUILD == 'apply' }
          }
          steps {
            sh 'ansible-playbook first_playbook.yml -i ansible/inventory.yml -u jenkins'
          }
        }
  }
}
