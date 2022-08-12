﻿FROM --platform=$BUILDPLATFORM golang:1.19-bullseye AS build
ARG TARGETARCH
ARG TARGETOS
WORKDIR /src

COPY go.mod .
RUN go mod download

COPY *.go .
RUN GOARCH=$TARGETARCH GOOS=$TARGETOS go build -o /app/health

FROM gcr.io/distroless/base:latest
WORKDIR /app
COPY --from=build /app ./
ENTRYPOINT ["./health"]