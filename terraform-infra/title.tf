module "lambda_title" {
  source              = "./lambda"
  src_path            = "../src/lambdas/titles"
  function_name       = "titles"
  project             = local.get_project
  lambda_env          = [var.lambda_env]
  dynamodb_arn        = [module.dynamodb.dymanodb_arn]
}

module "lambda_filter" {
  source              = "./lambda"
  src_path            = "../src/lambdas/filter"
  function_name       = "filter"
  project             = local.get_project
  lambda_env          = [
    merge( var.lambda_env, {
            SUB_LAMBDA = module.lambda_subscription.function_name
    })
  ]
  dymanodb_stream_arn = [module.dynamodb.dymanodb_stream_arn]
  dynamodb_arn        = [module.dynamodb.dymanodb_arn]
  lambda_arn          = [module.lambda_subscription.function_arn]
}