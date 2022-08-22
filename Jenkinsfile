pipeline {
    agent { label 'database' }

    stages {
        stage('Pre-Check') {
            steps {
                sh '''
                    python3 --version
                    free -m
                    free -g
                '''
            }
        }
        stage('CleanWS') {
            steps {
                cleanWs()
            }
        }
        stage('Github Checkout') {
            steps {
                git 'https://github.com/AshantaP/Test.git'
            }
        }
        stage('Code Quality') {
            environment {
                SCANNER_HOME = tool 'sonar-lin'
                PROJECT_NAME = 'sql'
            }
            steps {
                withSonarQubeEnv('sonarqube') {
                    sh '''$SCANNER_HOME/bin/sonar-scanner \
                    -Dsonar.java.binaries=build/classes/java/ \
                    -Dsonar.projectKey=$PROJECT_NAME \
                    -Dsonar.sources=.'''
                }
            }
            
        }
        stage('Quality Gate') {
            steps {
                timeout(time: 1, unit: 'HOURS') {
                    waitForQualityGate abortPipeline: true
                }
            }
        }
        stage('DBT Configuration') {
            steps {
                sh '''
                    cd ${WORKSPACE} \
                    pip -r requirements.txt
                '''
            }
        }
        stage('DBT-Deploy') {
            steps {
                sh '''
                    dbt debug
                    dbt run
                '''
            }
        }

    }
    post {
        success {
            mail to:"someone@hotmail.com", subject:"SUCCESS: ${currentBuild.fullDisplayName}", body: "Build, Successfully completed."
        }
        failure {
            mail to:"someone@hotmail.com", subject:"FAILURE: ${currentBuild.fullDisplayName}", body: "Oops. Build failed"
        }
    }   
}  
