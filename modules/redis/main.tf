
resource "aws_elasticache_cluster" "redis-cluster" {
  cluster_id           = "redis-cluster"
  engine               = "redis"
  node_type            = "cache.t2.micro"
  num_cache_nodes      = 1
  parameter_group_name = "default.redis3.2"
  engine_version       = "3.2.10"
  port                 = 6379
  security_group_ids   = [var.sgid]
}

resource "aws_ssm_parameter" "redis-endpoint" {
  name        = "/production/redis/endpoint"
  description = "The parameter description"
  type        = "String"
  value       = aws_elasticache_cluster.redis-cluster.cache_nodes.0.address

  tags = {
    environment = "production"
  }
}
