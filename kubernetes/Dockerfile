FROM node:18-alpine
WORKDIR /src
COPY app/ .
RUN npm install --quiet
EXPOSE 3000
CMD ["npm", "start"]