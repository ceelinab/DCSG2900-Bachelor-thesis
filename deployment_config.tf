resource "aws_codedeploy_deployment_config" "this" {
  deployment_config_name = var.deployment_config_name
  compute_platform = local.compute_platform

  minimum_healthy_hosts {
    type  = "HOST_COUNT"

  }

}