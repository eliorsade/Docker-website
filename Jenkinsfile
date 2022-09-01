pipeline {
  agent any

   stages {
      stage('Clone Sources') {
        steps {	  
          checkout scm
        } 
      }
	   
      stage('Build a docker image') {
         steps {
            echo 'Build process..'            
            sh '''
                docker build -t="webserver-domain:${BUILD_NUMBER}" .
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
				docker run -d -p 443:443 webserver-domain:${BUILD_NUMBER}
				echo "Check the URL: http://`hostname`:80"
			'''
         }
      }
      
   }
}
