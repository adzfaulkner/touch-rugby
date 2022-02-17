serviceName: ${SERVICE_NAME}
containers:
  nginx:
    command: []
    image: ${LATEST_NGINX_LIGHTSAIL_DOCKER_IMAGE}
    ports:
      "80": HTTP
  php:
    command: []
    environment:
      DB_DATABASE: ${DB_DATABASE}
      DB_USER: ${DB_USER}
      DB_PASSWORD: ${DB_PASSWORD}
      DB_HOST: ${DB_HOST}
      RECAPTCHA_SITE_KEY: ${RECAPTCHA_SITE_KEY}
      RECAPTCHA_SECRET_KEY: ${RECAPTCHA_SECRET_KEY}
    image: ${LATEST_PHP_LIGHTSAIL_DOCKER_IMAGE}
publicEndpoint:
  containerName: nginx
  containerPort: 80
  healthCheck:
    healthyThreshold: 2
    intervalSeconds: 20
    path: /
    successCodes: 200-499
    timeoutSeconds: 4
    unhealthyThreshold: 2