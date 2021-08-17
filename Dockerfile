FROM golang:1.12 as build-env

WORKDIR /go/src/app
ADD ./app /go/src/app

RUN go get -d -v ./...

RUN GOOS=linux GOARCH=amd64 go build -ldflags="-w -s" -o /go/bin/app
RUN ls -l /go/bin/app

FROM scratch
COPY --from=build-env /go/bin/app /
CMD ["/app"]