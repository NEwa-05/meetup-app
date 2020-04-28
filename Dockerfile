FROM golang:1.14-alpine as builder

COPY ./wiki.go .

RUN CGO_ENABLED=0 go build -o /wiki wiki.go

RUN mkdir /templates /pages

COPY templates/ /templates/

FROM scratch

COPY --from=builder /wiki .

COPY --from=builder /templates/ ./templates/

COPY --from=builder /pages/ ./pages/

CMD ["./wiki"]

EXPOSE 8080