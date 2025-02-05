sudo amazon-linux-extras install docker -y
sudo service docker start
sudo usermod -a -G docker ec2-user
sudo yum install git -y

sudo curl -L https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/bin/docker-compose
sudo chmod +x /usr/bin/docker-compose

rm -rf devops-example-25981

git clone https://github.com/chiragjethva/devops-example-25981.git
cd devops-example-25981

pwd

mv /home/ec2-user/devops-example-25981/.env.example /home/ec2-user/devops-example-25981/src/.env

pwd

perl -i -pe's/postgres_pwd=.*/postgres_pwd='"${postgres_pwd}"'/g' /home/ec2-user/devops-example-25981/src/.env
perl -i -pe's/DATABASE_URL=.*/DATABASE_URL='"${DATABASE_URL}"'/g' /home/ec2-user/devops-example-25981/src/.env
perl -i -pe's/REDIS_URL=.*/REDIS_URL='"${REDIS_URL}"'/g' /home/ec2-user/devops-example-25981/src/.env

cd /home/ec2-user/devops-example-25981/src/


docker-compose down
docker-compose -f docker-compose.override.yml up -d --build
docker-compose exec web python3 manage.py makemigrations
docker-compose exec web python3 manage.py migrate


export DEBUG=1
export HOST=localhost
export PORT=8000
export SECRET_KEY=x

