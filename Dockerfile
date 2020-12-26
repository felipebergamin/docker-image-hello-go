FROM golang:alpine as builder

RUN apk add upx
WORKDIR /var/app
COPY main.go .
ENV GOOS=linux
ENV GOARCH=386
RUN go build -ldflags="-s -w" -o main
RUN upx ./main

FROM busybox:latest

WORKDIR /var/app
COPY --from=builder /var/app/main .

ENTRYPOINT [ "./main" ]
