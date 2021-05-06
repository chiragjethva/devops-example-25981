sudo amazon-linux-extras install docker -y
sudo service docker start
sudo usermod -a -G docker ec2-user
sudo yum install git -y

sudo curl -L https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/bin/docker-compose
sudo chmod +x /usr/bin/docker-compose

export postgres_pwd=$(aws ssm get-parameter --region us-west-2 --name /production/database/password/master --output text --query Parameter.Value --with-decryption)
export DATABASE_URL=$(aws ssm get-parameter --region us-west-2 --name /production/database/endpoint --output text --query Parameter.Value)
export REDIS_URL=$(aws ssm get-parameter --region us-west-2 --name /production/redis/endpoint --output text --query Parameter.Value):6379
export DEBUG=1
export HOST=localhost
export PORT=8000
export SECRET_KEY=x


