pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID = credentials('aws-access-key')
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-key')
    }

    stages {
        stage('Stop Existing App') {
            steps {
                sh 'pm2 delete react-app || true'
            }
        }

        stage('Pull Latest Code') {
            steps {
                sh '''
                    cd /opt/checkout/react-todo-app
                    git pull origin master
                '''
            }
        }

        stage('Build App') {
            steps {
                sh '''
                    cd /opt/checkout/react-todo-app
                    npm install
                    npm run build
                '''
            }
        }

        stage('Deploy Build') {
            steps {
                sh '''
                    rm -rf /opt/deployment/react/*
                    cp -r /opt/checkout/react-todo-app/build/* /opt/deployment/react/
                '''
            }
        }

        stage('Start with PM2') {
            steps {
                sh '''
                    pm2 serve /opt/deployment/react 3000 --spa --name react-app
                    pm2 save
                '''
            }
        }

        stage('Upload to S3') {
            steps {
                sh '''
                    aws s3 cp /opt/deployment/react/index.html s3://your-s3-bucket-name/
                '''
            }
        }
    }
}
