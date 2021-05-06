echo export postgres_pwd=$(aws ssm get-parameter --region us-west-2 --name /production/database/password/master --output text --query Parameter.Value --with-decryption) >> script.sh
echo export DATABASE_URL=$(aws ssm get-parameter --region us-west-2 --name /production/database/endpoint --output text --query Parameter.Value) >> script.sh
echo export REDIS_URL=$(aws ssm get-parameter --region us-west-2 --name /production/redis/endpoint --output text --query Parameter.Value):6379 >> script.sh
