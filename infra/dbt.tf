# resource "aws_ecr_repository" "dbt_repo" {
#   name = "lambda_dbt_repo"
# }
#
# resource "null_resource" "build_push_dbt" {
#   triggers = {
#     dockerfile_hash = filesha256("../dbt/Dockerfile")
#     pyproject_hash  = filesha256("../pyproject.toml")
#     code_hash       = filesha256("../dbt/dbt_lambda.py")
#   }
#
#   provisioner "local-exec" {
#     command = <<EOT
#       aws ecr get-login-password --region ${var.aws_region} | podman login --username AWS --password-stdin ${aws_ecr_repository.dbt_repo.repository_url}
#       podman build --build-arg HANDLER_FILE=dbt_lambda.py -t ${aws_ecr_repository.dbt_repo.repository_url}:latest ../dbt
#       podman push ${aws_ecr_repository.dbt_repo.repository_url}:latest
#     EOT
#     environment = {
#       aws_region = var.aws_region
#     }
#   }
# }
#
# resource "aws_lambda_function" "dbt_lambda" {
#   function_name = "trigger_dbt_job"
#   package_type  = "Image"
#   image_uri     = "${aws_ecr_repository.dbt_repo.repository_url}:latest"
#   role          = aws_iam_role.lambda_dbt_role.arn
#   depends_on    = [null_resource.build_push_dbt]
#
#   environment {
#     variables = {
#       S3_BUCKET = aws_s3_bucket.health_data_bucket.bucket
#       # Add any additional DBT-specific environment variables here.
#     }
#   }
# }
#
# # Grant S3 permission to invoke the DBT Lambda
# resource "aws_lambda_permission" "s3_invoke_dbt_lambda" {
#   statement_id  = "AllowS3InvokeDBTLambda"
#   action        = "lambda:InvokeFunction"
#   function_name = aws_lambda_function.dbt_lambda.function_name
#   principal     = "s3.amazonaws.com"
#   source_arn    = aws_s3_bucket.health_data_bucket.arn
# }
