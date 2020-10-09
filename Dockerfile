# Docker Configurations

FROM node:10.15.3 as source

# Work Directory 
WORKDIR /src/build-your-own-radar
COPY package.json ./
RUN npm install

# Copy Current Directory Files
COPY . ./
RUN npm run build

# Nginx Server. Nginx Listen on 80 port
FROM nginx:1.15.9
WORKDIR /opt/build-your-own-radar
COPY --from=source /src/build-your-own-radar/dist .
COPY default.template /etc/nginx/conf.d/default.conf
CMD ["nginx", "-g", "daemon off;"]