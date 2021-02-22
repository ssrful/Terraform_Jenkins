pipeline {
	agent any
	environment {
		//Docker Hub repository User ID and Image name
		DOCKER_HUB_REPO = "ssrful/Terraform"
		//Registry Credentials
		REGISTRY_ID = 'dockerhub_id'
		//Container Image name
		dockerImage = 'Terraform-Flask-App'
	}
	options {
		skipStagesAfterUnstable ()
	}
	stages {
		stage('Cleaning up previous Repositories') {
			steps {
				sh 'rm -rf $PWD/Terraform_Jenkins'
			}
		}
		stage('Pulling image from GitHub') {
			steps {
				sh 'git clone https://github.com/ssrful/Terraform_Jenkins.git'
			}
		}
		stage('Building the Image') {
	//This step will build Image in Docker with UserID/ProjectName
			steps{
				script {
					sh 'docker image build -t $DOCKER_HUB_REPO:latest .'
					sh 'docker image tag $DOCKER_HUB_REPO:latest $DOCKER_HUB_REPO:$BUILD_NUMBER'
					echo "Docker Image Build was successful"
				}			
			}
		}
		stage('Deploy to Docker') {
		//This step will push the successful image to Docker Hub
			steps{
				script {
					docker.withRegistry( '', REGISTRY_ID ) {
						sh 'docker push $DOCKER_HUB_REPO:$BUILD_NUMBER'
						sh 'docker push $DOCKER_HUB_REPO:latest'
						echo "Image was pushed to Docker Hub!"
					}
				}
			}
		}
		stage('Terraform Initilializtion & Apply') {
			steps{
				sh 'terraform init'
				sh 'terraform fmt'
				sh 'terraform apply '
			}
		}
	//Lastly let's deploy the application via ansible to Kubernetes
	//stage('Deploy to Kubernetes/Ansible') {
	//	steps {
	//		script {
	//			sh 'kubectl apply -f kubernetes.yaml'
	//		}
	//	}
	//}
	}
}