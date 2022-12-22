# Settings
variable "authorizer_cognito_enabled" {
  type = bool
  default = false
  description = "Activate Cognito"
}
variable "region" {
  description = "AWS region"
  type        = string
}
variable "environment" {
  default = "dev"
  type = string
  description = "Environment name"
}
variable "project" {
  default = "myapp"
  type = string
  description = "Project name"
}
variable "tags" {
  type = map(string)
  description = "Tags to apply to all resources"
}
variable "domain" {
  description = "Domain url of the website"
}
variable "service_account_ci_arn" {
  description = "Service account arn for CI"
  type = string
}

# Lambda Title
variable "lambda_env" {
    description = "Lambda environment"
    type = map(string)
}

# DYNAMODB
variable "tabe_name" {
  description = "DynamoDB table titles will be stored in"
  type        = string
}
variable "accountId" {
  description = "AWS account ID"
  type        = string
}
variable "dynamodb_attributes" {
  type        = object({ sort_key = string, sort_type = string })
}

# COGNITO
variable "cognito_user_pool_name" {
  type        = string
  description = "The name of the user pool"
  default     = "api-gateway-pool"
}
variable "cognito_user_pool_client_name" {
  type        = string
  description = "The name of the user pool client"
  default     = "login_pool"
}
variable "gcp_client_id" {
  type        = string
  sensitive   = true
  description = "The client id for the GCP application"
}
variable "gcp_client_secret" {
  type        = string
  sensitive   = true
  description = "The client secret for the GCP application"
}
# API GATEWAY
variable "endpoint_api" {
  type        = string
  description = "The endpoint for the API Gateway"
  default     = "api"
}
variable "endpoint_sub" {
  type        = string
  description = "The endpoint for the API Gateway"
  default     = "api"
}
variable "stage" {
  type        = string
  description = "The stage for the API Gateway"
  default     = "dev"
}