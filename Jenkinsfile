    pipeline {
    agent { label 'dbt' }

    

    stages {
        stage('Git Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/AshantaP/Test.git/'
            }
        }
        stage('DBT Version') {
            steps {
                sh 'dbt --version'
            }
        }
        stage('DBT-Debug') {
            steps {
                sh '''
                    echo $WORKSPACE
                    cd $WORKSPACE
                    ls -lrt
                    dbt debug --profiles-dir {$WORKSPACE}
                '''
            }
        }
        stage('DBT Test') {
            steps {
                sh '''
                    dbt build
                    dbt test
                    dbt run
                
            }
        }
    }
}
