FROM golang:1.15-alpine as builder

RUN apk add upx
WORKDIR /var/app
COPY main.go .
RUN go build -ldflags="-s -w" -o main
RUN upx ./main

FROM busybox:latest

WORKDIR /var/app
COPY --from=builder /var/app/main .

ENTRYPOINT [ "./main" ]
