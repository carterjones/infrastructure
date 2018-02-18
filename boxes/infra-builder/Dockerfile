FROM ubuntu:latest

# Add in helper file(s).
COPY files/ /

# Set up deb files.
RUN apt-get -qq update -y
RUN apt-get -qq install -y curl awscli git jq unzip wget
RUN apt-get -qq autoremove
RUN apt-get -qq clean

# Set up packer and terraform.
WORKDIR /usr/local/bin
RUN wget -q "https://releases.hashicorp.com/packer/1.2.0/packer_1.2.0_linux_amd64.zip"
RUN wget -q "https://releases.hashicorp.com/terraform/0.11.3/terraform_0.11.3_linux_amd64.zip"
RUN unzip '*.zip' && rm *.zip
RUN chmod +x packer terraform

# Set up golang.
WORKDIR /tmp
RUN go_tar="go1.10.linux-amd64.tar.gz" && \
    wget -q "https://storage.googleapis.com/golang/$go_tar" && \
    tar -C /usr/local -xzf $go_tar && \
    rm $go_tar
ENV GOPATH /root/go
ENV PATH=$PATH:/usr/local/go/bin
RUN mkdir $GOPATH

# Set up gometalinter.
RUN go get -u github.com/alecthomas/gometalinter
RUN $GOPATH/bin/gometalinter --install
