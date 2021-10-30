FROM node:12.2.0

# Set working directory.
WORKDIR /app

# Install yarn.
RUN npm install -g yarn

# Install mysql-client.
RUN apt-get update && apt-get install -y mysql-client

# Add `/app/node_modules/.bin` to $PATH.
ENV PATH /app/node_modules/.bin:$PATH

# Expose api port.
EXPOSE 1337

# Add docker-compose-wait tool
ENV WAIT_VERSION 2.7.2
ADD https://github.com/ufoscout/docker-compose-wait/releases/download/$WAIT_VERSION/wait /wait
RUN chmod +x /wait

# Docker wait && build app.
CMD /wait && yarn install && yarn install --dev && yarn build --clean && yarn develop
