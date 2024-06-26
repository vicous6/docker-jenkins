FROM node:21-alpine
WORKDIR /app
COPY ./app/* ./

RUN npm install
CMD ["npm", "start"]
