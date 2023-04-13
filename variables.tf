variable "build_name" {
  type    = string
  default = "build2"
}

variable "build_desc" {
  type    = string
  default = "test build"
}

variable "pipeline_name" {
  type    = string
  default = "code-pipeline2"
}

variable "git_repo" {
  type    = string
  default = "theaurne/juice-shop"
}

variable "git_branch" {
  type    = string
  default = "master"
}

variable "bucket_name" {
  type    = string
  default = "artifact-bucket-thea2"
}

variable "deployment_config_name" {
  type    = string
  default = "deploy-tf-cicd"
}

variable "deployment_platform" {
  type    = string
  default = "EC2"
}

variable "deploy_group_name" {
  type    = string
  default = "deploy_group1"
}

variable "ami" {
  type    = string
  default = "ami-0f960c8194f5d8df5"
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "instance_key" {
  type    = string
  default = "myfirstkey"
}

variable "vpc" {
  type    = string
  default = "vpc-0e86f4e2a1a764e0d"
}