module "apigateway" {
  source = "./apigateway"
  project                 = local.get_project
  stage                   = var.stage
  sub_domain              = local.get_subdomain
  domain                  = var.domain
  tags                    = var.tags
  depends_on = [
    module.lambda_title,
    module.lambda_filter,
    module.dynamodb,
    module.cognito
  ]
}

module "resource_api" {
  source = "./apigateway/resource"
  endpoint         = var.endpoint_api
  rest_api_id      = module.apigateway.rest_api_id
  root_resource_id = module.apigateway.root_resource_id
}

module "post_method" {
  source                  = "./apigateway/post_method"
  rest_api_id             = module.apigateway.rest_api_id
  resource_id             = module.resource_api.resource_id
  resource_path           = module.resource_api.resource_path
  cognito_user_pool_arn   = module.cognito.cognito_user_pool_arn
  project                 = var.project
  authorizer_cognito_enabled = var.authorizer_cognito_enabled
  lambda_invoke_arn       = module.lambda_title.invoke_arn
  function_name           = module.lambda_title.function_name
  account_id              = var.accountId
  region                  = var.region
}

module "get_method" {
  source = "./apigateway/get_method"
  rest_api_id             = module.apigateway.rest_api_id
  resource_id             = module.resource_api.resource_id
  resource_path           = module.resource_api.resource_path
  invoke_url              = module.lambda_title.invoke_arn
  function_name           = module.lambda_title.function_name
  account_id              = var.accountId
  region                  = var.region
}

module "resource_subscription" {
  source = "./apigateway/resource"
  endpoint         = var.endpoint_sub
  rest_api_id      = module.apigateway.rest_api_id
  root_resource_id = module.resource_api.resource_id
}

module "get_sub_method" {
  source = "./apigateway/get_method"
  rest_api_id             = module.apigateway.rest_api_id
  resource_id             = module.resource_subscription.resource_id
  resource_path           = module.resource_subscription.resource_path
  invoke_url              = module.lambda_subscription.invoke_arn
  function_name           = module.lambda_subscription.function_name
  account_id              = var.accountId
  region                  = var.region
}