data "archive_file" "code" {
    type        = "zip"
    source_dir  = "${var.src_path}/src"
    output_path = "outputs/${var.function_name}-src.zip"
}
data "archive_file" "layer" {
    type        = "zip"
    source_dir  = "${var.src_path}/layer"
    output_path = "outputs/${var.function_name}-layer.zip"
}
resource "aws_lambda_layer_version" "this" {
    filename    = "outputs/${var.function_name}-layer.zip"
    layer_name  = "${var.project}-${var.function_name}-layer"
    description = "${var.project}-${var.function_name}-layer"
    source_code_hash = data.archive_file.layer.output_base64sha256
    compatible_runtimes = ["python3.8"]
    compatible_architectures = ["x86_64"]
}
resource "aws_lambda_function" "lambda" {
    function_name    = "${var.project}-${var.function_name}"
    role             = aws_iam_role.role_for_lambda.arn
    runtime          = "python3.8"
    filename         = data.archive_file.code.output_path
    layers           = [aws_lambda_layer_version.this.arn]
    handler          = "app.handle"
    source_code_hash = data.archive_file.code.output_base64sha256
    publish          = true
    timeout          = 300
    dynamic "environment" {
        for_each = length(var.lambda_env) > 0 ? var.lambda_env : []
        content {
            variables = environment.value
        }
    }
    lifecycle {
        ignore_changes = [
            source_code_hash
        ]
    }
}

resource "aws_lambda_event_source_mapping" "allow_dynamodb_table_to_trigger_lambda" {
    count = length(var.dymanodb_stream_arn) > 0 ? 1 : 0
    event_source_arn  = var.dymanodb_stream_arn[count.index]
    function_name     = aws_lambda_function.lambda.arn
    starting_position = "LATEST"
    batch_size = 1
    maximum_retry_attempts = 1

    # @TODO: Add support for filter parameters
    # filter_criteria {
    #    filter {
    #        pattern = jsonencode({
    #            "eventName": [ "INSERT" ]
    #        })
    #    }
    # }
}