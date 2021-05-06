

resource "random_string" "dbpass" {
  count       = ((var.db_size > 0) || (var.db_restore_from != "")) ? 1 : 0
  length      = var.db_passlen
  min_upper   = 4
  min_lower   = 4
  min_numeric = 4

  // Harbor config file has trouble with special characters (per Aditya)
  // min_special = 4
  // override_special = "!-_=+[]{}:?" # RDS doesn't like @ signs

  special = false

}

resource "aws_ssm_parameter" "secret" {
  name        = "/production/database/password/master"
  description = "The parameter description"
  type        = "SecureString"
  value       = random_string.dbpass[0].result

  tags = {
    environment = "production"
  }
}



resource "aws_db_instance" "default" {
  allocated_storage      = 10
  storage_type           = "gp2"
  engine                 = "postgres"
  engine_version         = "13.2"
  instance_class         = "db.t3.micro"
  name                   = "mydb"
  username               = "postgresadmin"
  password               = random_string.dbpass[0].result
  skip_final_snapshot    = "true"
  vpc_security_group_ids = [var.sgid]
}

resource "aws_ssm_parameter" "endpoint" {
  name        = "/production/database/endpoint"
  description = "The parameter description"
  type        = "String"
  value       = aws_db_instance.default.endpoint

  tags = {
    environment = "production"
  }
}
