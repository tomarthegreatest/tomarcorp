pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                script {
                    def app = docker.build("glpi_app")
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    sh 'docker-compose down'
                    sh 'docker-compose up -d --build'
                }
            }
        }
    }
}