# touch-rugby

## Installation

### Dev

1. Run `docker-compose up`

### Prod

1. Create the docker network: `docker network create touchrugby`
2. Create the necessary volume(s):
   `docker volume create --driver local -o o=bind -o type=none -o device=$PWD/php/wp/src/wp-content touchrugby-wpcontent`
3. Build the php container: `docker build --target php --tag touchrugby-php .`
4. Build the nginx container: `docker build --target nginx --tag touchrugby-nginx .`
