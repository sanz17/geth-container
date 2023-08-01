#Using GOlang
FROM golang:1.20 AS builder

# Since we are asked to build a toolchain, so we have to install all the dependencies
RUN apt-get update && apt-get install -y --no-install-recommends git

#installing libc6 is very important otherwise our dockerfile wont run or containerize
RUN apt-get install -y libc6

# Any working directory can be set
WORKDIR /go/src/geth

# Now we have to Clone the official geth repository
RUN git clone https://github.com/ethereum/go-ethereum.git .


# Build geth
RUN make geth

#always use stables-slim for the container to run, and never use buster-slim
FROM debian:stable-slim

# As mentioned in the problem statement, copy it from the binary
COPY --from=builder /go/src/geth/build/bin/geth /usr/local/bin/

#There must be a backup option Whenever a non root user wants to run
RUN useradd -ms /bin/bash gethuser
USER gethuser

# For ethereum we usually use 30303 udp, hence here we will be using the same
EXPOSE 8545 8546 30303 30303/udp

#Lastly setting an entry point to geth
ENTRYPOINT ["geth"]
