pipeline {
  agent any
  
	environment {
		username = credentials('DOCKERHUB_USER')
		password = credentials('DOCKERHUB_PASSWORD')
	} 
	
   stages {
      stage('Clone Sources') {
        steps {	  
          checkout scm
        } 
      }
      stage('Dockerlogin') {
			steps { 
				sh "docker login -u $username -p $password"
			} 
		} 
      stage('Build a docker image') {
         steps {
            echo 'Build process..'            
            sh '''
                docker build -t "webapp-randon-pics:${BUILD_NUMBER}" .
            '''
         }
      }
      stage('Docker push'){
          steps{
          sh '''
          docker tag app-randon-pics:${BUILD_NUMBER} eliorsade/webapp-randon-pics:latest
          docker push eliorsade/webapp-randon-pics:latest
          '''
      }
      }
      stage('Deploy the website') {
         steps {
            echo 'Deploy process..'
			sh '''
				echo "Stopping running containers"
				CONTAINER=`docker ps -q`
				if [ -z "$CONTAINER" ]; then
					echo "No running containers. Nothing to stop"
				else									
					docker stop ${CONTAINER}
					docker rm ${CONTAINER}
				fi
				echo "Running a new container"
				docker run -p 8888:5000 --name webapp-random-pics webapp-randon-pics
				echo "Check the URL: http://`hostname`:5000"
			'''
         }
      }
      	stage('Dockerlogout') {
		steps { 
				sh "docker logout"
			} 
		} 
      
   }
}
