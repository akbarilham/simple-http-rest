FROM ranbogmord/elm:latest
WORKDIR /app
COPY elm.json ./
# RUN npm install -g elm@latest-0.19.1 && \
#     npm install
COPY . .
RUN elm make src/HttpExamples.elm --output=elm.js
EXPOSE 8000
CMD ["elm", "reactor"]
