terraform {
  
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
    acme = {
      source = "vancluever/acme"
    }
    pkcs12 = {
      source = "chilicat/pkcs12"
    }
  }
}


locals {

  default-tradex-env = {
    APP_DEFAULT_DB_USER = var.db-user
    APP_DEFAULT_DB_PWD = var.db-password
    APP_DEFAULT_DB_NAME = var.db-name
    APP_SINGLE_DB_HOST = one(aws_route53_record.single-region[*].name)
    APP_SINGLE_DB_TP_KEYS = "aws.us-east-1.us-east-1a,aws.us-east-1.us-east-1b,aws.us-east-1.us-east-1c"
    APP_MULTI_REGION_DB_HOST = one(aws_route53_record.multi-region[*].name)
    APP_MULTI_REGION_DB_TP_KEYS = "aws.us-east-1.us-east-1a,aws.us-east-2.us-east-2a,aws.us-west-1.us-west-1a"
    APP_MULTI_REGION_READ_REPLICA_DB_HOST = one(aws_route53_record.multi-region-read-replica[*].name)
    APP_MULTI_REGION_READ_REPLICA_DB_TP_KEYS = "aws.us-east-1.us-east-1c,aws.us-west-1.us-west-1a,aws.ap-south-1.ap-south-1a"
    APP_GEO_PART_DB_HOST = one(aws_route53_record.geopart[*].name)
    APP_GEO_PART_DB_TP_KEYS = "aws.us-east-1.us-east-1a,aws.us-west-2.us-west-2a,aws.eu-west-2.eu-west-2a,aws.ap-south-1.ap-south-1a,aws.ap-southeast-2.ap-southeast-2a"
    APP_DB_LOADBALANCE = "true"
    APP_GEO_PART_DB_PWD = var.db-password
    APP_GEO_PART_DB_URL = "jdbc:yugabytedb://${one(aws_route53_record.geopart[*].name)}:5433/${var.db-name}"
    APP_GEO_PART_DB_USER = var.db-user
    APP_MULTI_REGION_DB_PWD = var.db-password
    APP_MULTI_REGION_DB_URL = "jdbc:yugabytedb://${one(aws_route53_record.multi-region[*].name)}:5433/${var.db-name}"
    APP_MULTI_REGION_DB_USER = var.db-user
    APP_MULTI_REGION_READ_REPLICA_DB_PWD = var.db-password
    APP_MULTI_REGION_READ_REPLICA_DB_URL = "jdbc:yugabytedb://${one(aws_route53_record.multi-region-read-replica[*].name)}:5433/${var.db-name}"
    APP_MULTI_REGION_READ_REPLICA_DB_USER = var.db-user
    APP_SINGLE_DB_PWD = var.db-password
    APP_SINGLE_DB_URL = "jdbc:yugabytedb://${one(aws_route53_record.single-region[*].name)}:5433/${var.db-name}"
    APP_SINGLE_DB_USER = var.db-user
    APP_PROD_DOCKER_IMG_TAG = var.docker-image-prod
    APP_DEV_DOCKER_IMG_TAG = var.docker-image-dev
    YB_API_HOST = var.yba.api-endpoint
    YB_API_CUST = local.yba-customer-uuid 
    YB_API_TOKEN = var.yba.api-token
    SPRING_PROFILES_ACTIVE = "SINGLE,MR,MRR,GEO"
  }

  
  tradex-env = {
    boston =  templatefile("${path.module}/templates/tradex-env.properties", merge(local.default-tradex-env, {APP_INSTANCE_LOCATION = "BOSTON"}))
    washington =  templatefile("${path.module}/templates/tradex-env.properties", merge(local.default-tradex-env, {APP_INSTANCE_LOCATION = "WASHINGTON"}))
    london =  templatefile("${path.module}/templates/tradex-env.properties", merge(local.default-tradex-env, {APP_INSTANCE_LOCATION = "LONDON"}))
    mumbai =  templatefile("${path.module}/templates/tradex-env.properties", merge(local.default-tradex-env, {APP_INSTANCE_LOCATION = "MUMBAI"}))
    sydney =  templatefile("${path.module}/templates/tradex-env.properties", merge(local.default-tradex-env, {APP_INSTANCE_LOCATION = "SYDNEY"}))
  }
}
