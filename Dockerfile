# build stage berfungsi untuk membangun hanya file binary dan membuat image secara bertahap
# CASE INI DILAKUKAN KETIKA IMAGE GOLANG OVER SIZE
FROM golang:1.18.3-alpine3.16 AS builder
WORKDIR /app
COPY . .
RUN go build -o main main.go

# install curl
RUN apk add curl

# install golang migrate
RUN curl -L https://github.com/golang-migrate/migrate/releases/download/v4.15.2/migrate.linux-amd64.tar.gz | tar xvz

# run stage
FROM alpine:3.16
WORKDIR /app
COPY --from=builder /app/main .

# membuat migrasi database diDocker
COPY --from=builder /app/migrate ./migrate 

# salin file migration 
COPY db/migration ./migration

# including file .env di Docker
COPY app.env .

# including file start.sh
COPY start.sh .
COPY wait-for.sh .

EXPOSE 8080
CMD [ "/app/main" ]

# eksekusi file start.sh
ENTRYPOINT [ "/app/start.sh" ]