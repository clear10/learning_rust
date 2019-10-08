# NOTE: make complete static link using musl and build single binary
FROM ekidd/rust-musl-builder:1.38.0 as builder
WORKDIR /home/rust/app
COPY Cargo.toml Cargo.lock /home/rust/app/
COPY src /home/rust/app/src
RUN sudo chown -R rust:rust /home/rust/app && cargo build --release


# NOTE: release stage
FROM alpine:3.10 as release
WORKDIR /app
COPY --from=builder /home/rust/app/target/x86_64-unknown-linux-musl/release/hello /app/hello
CMD ["/app/hello"]

