FROM node:14-alpine as builder
WORKDIR /apps
#RUN apt install wget
RUN wget https://github.com/elm/compiler/releases/download/0.19.1/binary-for-linux-64-bit.gz  && \
    tar -xvzf binaries-for-linux-64-bit.gz && \
    mv elm /usr/local/bin && \
    rm binaries-for-linux-64-bit.gz
COPY elm.json ./
COPY . .
RUN elm make src/HttpExamples.elm --output=elm.js
# EXPOSE 8000
# CMD ["elm", "reactor"]

FROM nginx:alpine
COPY --from=builder /apps/elm.js /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
