# Docker Configurations

FROM glasswallsolutions/k8-centos7:latest as source

RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
RUN source $HOME/.bashrc && nvm install 12.14.1

RUN ln -s $HOME/.nvm/versions/node/v12.14.1/bin/node /usr/bin/node
RUN ln -s $HOME/.nvm/versions/node/v12.14.1/bin/npm /usr/bin/npm

# Work Directory 
WORKDIR /src/build-your-own-radar
COPY package.json ./
RUN npm install

# Copy Current Directory Files
COPY . ./
# RUN npm run build

# Nginx Server. Nginx Listen on 80 port
# FROM nginx:1.15.9
# WORKDIR /opt/build-your-own-radar
# COPY --from=source /src/build-your-own-radar/dist .
# COPY default.template /etc/nginx/conf.d/default.conf

EXPOSE 8080

CMD ["npm","start"]