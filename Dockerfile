FROM registry.redhat.io/ubi8/go-toolset:latest as builder
WORKDIR /go/src/app
COPY . .
USER 0
RUN go get -d ./... && \
    go build -o rosocp rosocp.go

FROM registry.redhat.io/ubi8/ubi-minimal:latest
WORKDIR /
COPY --from=builder /go/src/app/rosocp ./rosocp
COPY migrations ./migrations
COPY openapi.json ./openapi.json
COPY resource_optimization_openshift.json ./resource_optimization_openshift.json
USER 1001
