# This block configures Terraform itself, including the required providers.
terraform {
  required_providers {
    # We specify that we need the Docker provider.
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

# Configure the Docker provider. Terraform will connect to your local Docker daemon.
provider "docker" {}

# This resource tells Terraform to pull the latest Nginx image from Docker Hub.
# This is a good practice to ensure the image is available before creating a container.
resource "docker_image" "nginx" {
  name = "nginx:latest"
}

# This resource defines the Docker container we want to create.
resource "docker_container" "nginx_server" {
  # The name of the container.
  name  = "tutorial-nginx-server"
  
  # The image to use. We reference the 'docker_image' resource defined above.
  image = docker_image.nginx.image_id
  
  # This maps port 80 inside the container to port 8000 on your local machine.
  ports {
    internal = 80
    external = 8000
  }
}
