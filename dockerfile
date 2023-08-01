# Step 1: Build geth from source
FROM golang:1.20 AS builder

# Install required dependencies
RUN apt-get update && apt-get install -y --no-install-recommends git

# Set the working directory
WORKDIR /go/src/geth

# Clone the geth repository
RUN git clone https://github.com/ethereum/go-ethereum.git .

# # Checkout the desired version of geth (optional, you can remove this line if you want to use the latest version)
# RUN git checkout tags/vX.Y.Z

# Build geth
RUN make geth

# Step 2: Create the final minimal container
FROM debian:buster-slim

# Copy the built geth binary from the previous stage
COPY --from=builder /go/src/geth/build/bin/geth /usr/local/bin/

# Create a non-root user to run geth
RUN useradd -ms /bin/bash gethuser
USER gethuser

# Expose the necessary ports for geth (modify these ports as per your needs)
EXPOSE 8545 8546 30303 30303/udp

# Set the entrypoint to geth
ENTRYPOINT ["geth"]
