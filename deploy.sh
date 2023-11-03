echo "*****************************************************"
echo "DEPLOYING SIT-RECIPE"
echo "*****************************************************"

chmod -R 777 *

# Set unix file delimiters
sed -i -e 's/^M$//' ./deploy.sh
sed -i -e 's/\r$//' ./ict3x03-team7-database/init/mysql-seed/seed.sh


# Load environment variables from .env file
if [ -f .env ]; then
    export $(cat .env | grep -v '#' | awk '/=/ {print $1}')
fi

# Stop and remove existing containers
docker-compose down -v

docker-compose build

# Start the containers in detached mode and follow the logs
docker-compose up --detach --remove-orphans