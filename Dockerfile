FROM node:14-alpine as builder
WORKDIR /apps
RUN npm install -g elm
COPY elm.json ./
COPY . .
RUN elm make src/HttpExamples.elm --output=elm.js
// EXPOSE 8000
// CMD ["elm", "reactor"]
# Stage 2: Serve the Elm application
FROM nginx:alpine

# Copy the built Elm files from the previous stage
COPY --from=builder /app/elm.js /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
