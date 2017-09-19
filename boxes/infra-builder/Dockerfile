FROM ubuntu:latest

# Add in helper file(s).
COPY files/ /

# Set up deb files.
RUN apt-get -qq update -y && \
    apt-get -qq install -y curl awscli git jq unzip wget && \
    apt-get -qq autoremove && \
    apt-get -qq clean

# Set up packer and terraform.
RUN cd /usr/local/bin && \
    wget -q "https://releases.hashicorp.com/packer/1.1.0/packer_1.1.0_linux_amd64.zip" && \
    wget -q "https://releases.hashicorp.com/terraform/0.10.5/terraform_0.10.5_linux_amd64.zip" && \
    unzip '*.zip' && \
    rm *.zip && \
    chmod +x packer terraform

# Set up golang.
RUN cd /tmp && \
    go_tar="go1.9.linux-amd64.tar.gz" && \
    wget -q "https://storage.googleapis.com/golang/$go_tar" && \
    tar -C /usr/local -xzf $go_tar && \
    rm $go_tar
ENV GOPATH /root/go
ENV PATH=$PATH:/usr/local/go/bin
RUN mkdir $GOPATH
