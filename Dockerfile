FROM node:alpine
WORKDIR /app
COPY package*.json elm.json ./
RUN npm install -g elm@latest-0.19.1 && \
    npm install
COPY . .
RUN elm make src/Main.elm --output=elm.js
EXPOSE 3000
CMD ["npm", "start"]
