pipeline {
    agent any

    environment {
        // Injecte le token depuis Jenkins Credentials
        SONAR_TOKEN = credentials('sonar24')
    }

    stages {
        stage('Clone') {
            steps {
                checkout scm
            }
        }

        stage('Build') {
            steps {
                sh 'mvn -B clean package -DskipTests'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('SonarAnalyse') {
                    // Utilisation de """ et $VAR pour interpolation Shell correcte
                    sh """
                        mvn sonar:sonar \
                            -Dsonar.projectKey=ProjetStudentsManagement \
                            -Dsonar.host.url=\$SONAR_HOST_URL \
                            -Dsonar.login=\$SONAR_TOKEN
                    """
                }
            }
        }

        stage('Quality Gate') {
            steps {
                timeout(time: 5, unit: 'MINUTES') {
                    waitForQualityGate abortPipeline: true
                }
            }
        }
    }
    stage('Build Docker Image') {
        steps {
            sh 'docker build -t fatmaghiloufi/students-management:1.0 .'
            sh 'docker push fatmaghiloufi/students-management:1.0'
        }
    }

    post {
        success {
            echo '✅ Pipeline terminé avec succès !'
        }
        failure {
            echo '❌ Pipeline échoué.'
        }
        always {
            echo 'Pipeline terminé.'
        }
    }
}
