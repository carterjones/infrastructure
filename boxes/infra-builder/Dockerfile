FROM golang:alpine

# Add in helper file(s).
COPY files/ /

# Set up software.
RUN apk update
RUN apk add --no-cache curl git jq make tar unzip wget
RUN apk add aws-cli --update-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing/

# Set up packer and terraform.
WORKDIR /usr/local/bin
RUN wget -q "https://releases.hashicorp.com/packer/1.2.0/packer_1.2.0_linux_amd64.zip"
RUN wget -q "https://releases.hashicorp.com/terraform/0.11.3/terraform_0.11.3_linux_amd64.zip"
RUN unzip '*.zip' && rm *.zip
RUN chmod +x packer terraform

# Set up gometalinter.
RUN go get -u github.com/alecthomas/gometalinter
RUN $GOPATH/bin/gometalinter --install
