## Hier rufst du das EC2-Modul auf und übergibst die notwendigen Variablen.

provider "aws" {
    region = "eu-central-1"
}

module "prediction_function_execution_role" {
    source = "./modules/iam"
    role_name = "prediction_generator_function_execution_role"
    policy_name = "AWSLambdaBasicExecutionRole"
}

module "predition_generator_lambda" {
    source = "./modules/lambda"
    function_name = "prediction_generator_function"
    runtime = "nodejs20.x"
    handler = "index.handler"
    lambda_role_arn = module.prediction_function_execution_role.lambda_execution_role_arn
    lambda_zip_path = "${path.module}/prediction-generator-lambda.zip"
    dynamodb_table_name = module.prediction_dynamodb_table.dynamodb_table_name
    lambda_environment_vars = {
      API_TOKEN = "test_value"
    }  
}

module "prediction_dynamodb_table" {
    source = "./modules/dynamodb"
    table_name = "predictions"
    hash_key = "predictionId"
}


module "ec2_instance" {
  source        = "./modules/ec2_instance"  # Pfad zu deinem EC2-Modul
  ami_id        = "ami-05d09a70429a7c087"            # Beispiel AMI-ID, ersetze sie mit einer gültigen ID
  instance_type = "t2.micro"                  # Instanztyp
  instance_name = "MyEC2Instance"             # Name der Instanz
  subnet_ids    = ["subnet-033755d7549d8b4d7", "subnet-0fa7b891283429a5f"]  # Beispiel-Subnetz-IDs
  security_group_id = "sg-0cf8d731f7c1f2760"        # Beispiel Sicherheitsgruppen-ID
}




