# 1. Configure the required providers
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

# 2. Configure the Docker provider
provider "docker" {}

# 3. Pull the latest Nginx image from Docker Hub
resource "docker_image" "nginx_image" {
  name         = "nginx:latest"
  keep_locally = false # Do not keep the image cached locally after destroy
}

# 4. Create a Docker container using the Nginx image
resource "docker_container" "nginx_container" {
  image = docker_image.nginx_image.image_id
  name  = "tutorial-container"

  ports {
    internal = 80
    external = 8080
  }
}
