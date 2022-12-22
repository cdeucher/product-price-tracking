# Settings
authorizer_cognito_enabled = true
# service_account_ci_arn = "arn:aws:iam::xx:user/xx"

# General
region    = "us-east-1"
# accountId = "xx"
# domain    = "xx"
tags = {
    Name             = "app"
    Environment      = "dev"
    Owner            = "me"
    Application      = "app"
    Environment_Type = "dev"
    Environment_Name = "dev"
}
project = "app"
environment = "dev"

# Api Gateway
endpoint_api = "api"
endpoint_sub = "sub"
stage = "dev"

# Cognito
# gcp_client_id = ""
# gcp_client_secret = ""

# Lambda
lambda_env = { TITLES_TABLE = "titles" }

# Dynamo
tabe_name = "titles"
dynamodb_attributes = { sort_key = "site", sort_type = "S" }

cognito_user_pool_name = "login_pool"
cognito_user_pool_client_name = "api-gateway-pool"
