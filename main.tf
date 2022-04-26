# Create ECR Repository

resource "aws_ecr_repository" "backend" {
  name = "backend"
}
## Build docker images and push to ECR
#resource "docker_registry_image" "backend"{
#  name = "${aws_ecr_repository.backend.repository_url}:latest"
#  build {
#    context = "../mss-business-ui-servitisation"
#    dockerfile = "Dockerfile"
#    labels = {
#      author : "papapanda"
#    }
#  }
#}

resource "aws_ecs_cluster" "my_cluster" {
  name = "kash-cluster" # Naming the cluster
}

#
#resource "aws_ecs_task_definition" "my_first_task" {
#  family                   = "my-first-task" # Naming our first task
#  container_definitions    = <<DEFINITION
#  [
#    {
#      "name": "my-first-task",
#      "image": "${aws_ecr_repository.backend.repository_url}:latest",
#      "essential": true,
#      "portMappings": [
#        {
#          "containerPort": 5000,
#          "hostPort": 5000
#        }
#      ],
#      "memory": 1024,
#      "cpu": 512
#    }
#  ]
#  DEFINITION
#  requires_compatibilities = ["FARGATE"] # Stating that we are using ECS Fargate
#  network_mode             = "awsvpc"    # Using awsvpc as our network mode as this is required for Fargate
#  memory                   = 1024         # Specifying the memory our container requires
#  cpu                      = 512         # Specifying the CPU our container requires
#  execution_role_arn       = "${aws_iam_role.ecsT.arn}"
#}

resource "aws_iam_role" "ecsT" {
  name               = "ecsT"
  assume_role_policy = "${data.aws_iam_policy_document.assume_role_policy.json}"
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "ecsTaskExecutionRole_policy" {
  role       = "${aws_iam_role.ecsT.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_ecs_service" "my_first_service" {
  name            = "my-first-service"                             # Naming our first service
  cluster         = "${aws_ecs_cluster.my_cluster.id}"             # Referencing our created Cluster
  task_definition = "${aws_ecs_task_definition.my_first_task.arn}" # Referencing the task our service will spin up
  launch_type     = "FARGATE"
  desired_count   = 1 # Setting the number of containers we want deployed to 3

 network_configuration {
    subnets          = ["${aws_default_subnet.default_subnet.id}"]
    assign_public_ip = true # Providing our containers with public IPs
  }

}

# Reference to our default VPC
resource "aws_default_vpc" "default_vpc" {
}

# Reference to our default subnets

resource "aws_default_subnet" "default_subnet" {
  availability_zone = "eu-west-2a"
}
#
#resource "docker_image" "samplei" {
#  name = "sampleui"
#
#  build {
#    path = "../Sample-UI"
#    dockerfile = "Dockerfile"
#    tag  = ["sampleui:develop"]
#    build_arg = {
#      foo : "samplui"
#    }
#    label = {
#      author : "papapanda"
#    }
#  }
#}

data "aws_caller_identity" "current" {}
data "aws_ecr_authorization_token" "token" {}
locals {
  tags = {
    created_by  = "terraform"
  }
  aws_ecr_url = "${data.aws_caller_identity.current.account_id}.dkr.ecr.eu-west-2.amazonaws.com"
}


