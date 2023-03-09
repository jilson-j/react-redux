### STAGE 1: Build ###
FROM node:12-alpine AS build
RUN mkdir -p /usr/src/360-webapp
WORKDIR /usr/src/360-webapp
ENV PATH /usr/src/360-webapp/node_modules/.bin:$PATH
COPY package.json /usr/src/360-webapp/package.json
RUN npm install --silent
RUN npm install react-scripts -g --silent
COPY . /usr/src/360-webapp
RUN npm run build

### STAGE 2: Production Environment ###
FROM nginx:1.13.12-alpine
COPY --from=build /usr/src/360-webapp/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
