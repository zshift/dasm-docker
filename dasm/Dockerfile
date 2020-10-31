FROM ubuntu:20.04

WORKDIR /home/dasm/src

RUN apt-get update && \
    apt-get install -y wget -V

# Install dasm
RUN wget https://github.com/dasm-assembler/dasm/releases/download/2.20.14/dasm-2.20.14-linux-x64.tar.gz -O/tmp/dasm.tar.gz 2>/dev/null && \
    tar -xzf /tmp/dasm.tar.gz -C /usr/bin

ENTRYPOINT [ "dasm" ]