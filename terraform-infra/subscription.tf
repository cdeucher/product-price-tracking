# TODO: fix policy too much permissive
resource "aws_iam_policy" "sns_access" {
  name        = "${local.get_project}-sns-access"
  description = "IAM policy for sns"
  policy = templatefile("./policies/sns_policy.json",{ })
}

module "lambda_subscription" {
  source              = "./lambda"
  src_path            = "../src/lambdas/filter" # same as filter
  function_name       = "subscription"
  project             = local.get_project
  lambda_env          = [var.lambda_env]
  dynamodb_arn        = [module.dynamodb.dymanodb_arn]
  # external_policies_arn = [aws_iam_policy.sns_access.arn]
}

module "subscription" {
  source          = "./sns"
  project         = local.get_project
  tags            = var.tags
}