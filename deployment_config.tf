resource "aws_codedeploy_deployment_config" "deployment_config" {
  deployment_config_name = var.deployment_config_name

  minimum_healthy_hosts {
    type  = "HOST_COUNT"
    value = 0
  }
}