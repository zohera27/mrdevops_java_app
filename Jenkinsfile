@Library('Jenkins_Shared_Library') _

pipeline{

    agent any

    environment{

        JAVA8_HOME = "${tool 'JDK8'}"
        JAVA11_HOME = "${tool 'JDK11'}"
        MAVEN_HOME = "${tool 'MAVEN'}"
    }

    parameters{

        choice(name: 'action', choices: 'create\ndelete', description: 'Choose create/Destroy')
        string(name: 'ImageName', description: "name of the docker build", defaultValue: 'javapp')
        string(name: 'ImageTag', description: "tag of the docker build", defaultValue: 'latest')
        string(name: 'DockerHubUser', description: "name of the Application", defaultValue: 'vikashashoke')
    }

    stages{
         
        stage('Git Checkout') {

         when {expression { params.action == 'create' } }    
            
            steps {
                script {

                    git.gitcheckout(

                        branch: 'main',
                        url: 'https://github.com/zohera27/mrdevops_java_app.git'
                    )
                }            
            }
        }
        
        stage('Unit Test maven'){
         
         when { expression {  params.action == 'create' } }

            steps{

               script{
                   
                   mvn.mvntest(JAVA8_HOME)
               }
            }
        }
        
        stage('Integration Test maven'){
         
         when { expression {  params.action == 'create' } }
            
            steps{
               
               script{
                   
                   mvn.mvnverify(JAVA8_HOME)
               }
            }
        }

        stage('Maven Build : maven'){
         
         when { expression {  params.action == 'create' } }
            
            steps{
               
               script{

                    mvn.mvnbuild(JAVA8_HOME)

               }
            }
        }

        stage('Docker Image Build'){
         
         when { expression {  params.action == 'create' } }
            
            steps{
               
               script{
                   
                   docker.build("${params.ImageName}","${params.ImageTag}","${params.DockerHubUser}")
               }
            }
        }
        
        
        stage('Docker Image Push : DockerHub '){
         
         when { expression {  params.action == 'create' } }
            
            steps{
               
               script{
                   
                   docker.PushImage("${params.ImageName}","${params.ImageTag}","${params.DockerHubUser}")
               }
            }
        }

             
    }
}