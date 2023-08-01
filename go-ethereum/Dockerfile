# Step 1: Build geth from source
FROM golang:1.20 AS builder

# Install required dependencies
RUN apt-get update && apt-get install -y --no-install-recommends git

RUN apt-get install -y libc6

# Set the working directory
WORKDIR /go/src/geth

# Clone the geth repository
RUN git clone https://github.com/ethereum/go-ethereum.git .


# Build geth
RUN make geth

FROM debian:stable-slim

# Copy the built geth binary from the previous stage
COPY --from=builder /go/src/geth/build/bin/geth /usr/local/bin/

# If a non root user wants to run geth
RUN useradd -ms /bin/bash gethuser
USER gethuser

# For ethereum we usually use 30303 udp, hence here we will be using the same
EXPOSE 8545 8546 30303 30303/udp

# Set the entrypoint to geth
ENTRYPOINT ["geth"]
