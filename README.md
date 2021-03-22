# touch-rugby

## Installation

### Dev

1. Run docker-compose up

### Prod

1. Create the docker network: `docker network create touchrugby`
2. Build the php container: `docker build --target php --tag touchrugby-php .`
3. Build the nginx container: `docker build --target nginx --tag touchrugby-nginx .`
