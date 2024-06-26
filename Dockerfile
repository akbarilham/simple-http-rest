FROM node:14-alpine as builder
WORKDIR /apps
RUN apk --no-cache add curl
RUN curl -L -o elm.gz https://github.com/elm/compiler/releases/download/0.19.1/binary-for-linux-64-bit.gz && \
    gunzip elm.gz && \
    chmod +x elm && \
    mv elm /usr/local/bin
COPY elm.json ./
COPY . .
RUN elm make src/HttpExamples.elm --output=elm.js
# EXPOSE 8000
# CMD ["elm", "reactor"]

FROM nginx:alpine
COPY --from=builder /apps/elm.js /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
