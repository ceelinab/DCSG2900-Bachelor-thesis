variable "build_name"{
    type = string
    default = "build2"
}

variable "build_desc"{
    type = string
    default = "test build"
}

variable "pipeline_name"{
    type = string
    default = "code-pipeline2"
}

variable "git_repo"{
    type = string
    default = "theaurne/juice-shop"
}

variable "git_branch"{
    type = string
    default = "master"
}

variable "bucket_name"{
    type = string
    default = "artifact-bucket-thea2"
}

variable "deployment_config_name"{
    type = string
    default = "deploy-tf-cicd"
}

variable "deployment_platform"{
    type = string
    default = "EC2"
}