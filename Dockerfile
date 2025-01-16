
FROM golang:1.21.5-bullseye 

WORKDIR /app

COPY . .

RUN go mod tidy

RUN go build  -a main.go

EXPOSE 8080

CMD ["./main"]
