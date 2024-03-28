FROM node:14-alpine as builder
WORKDIR /apps
RUN npm install -g elm
COPY elm.json ./
COPY . .
RUN elm make src/HttpExamples.elm --output=elm.js
# EXPOSE 8000
# CMD ["elm", "reactor"]

FROM nginx:alpine
COPY --from=builder /app/elm.js /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
