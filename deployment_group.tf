/**
resource "aws_codedeploy_deployment_group""deploy_group"{
    deployment_group_name = var.deploy_group_name
    deployment_config_name = aws_codedeploy_deployment_config.deployment_config.id
    app_name = aws_codedeploy_app.codedeploy2.name 
    service_role_arn = 
}
*/