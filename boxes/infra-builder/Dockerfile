FROM ubuntu:latest

# Set up deb files.
RUN apt-get -qq update -y && \
    apt-get -qq install -y curl awscli git jq unzip wget && \
    apt-get -qq autoremove && \
    apt-get -qq clean

# Set up packer and terraform.
RUN cd /usr/local/bin && \
    wget -q "https://releases.hashicorp.com/packer/0.12.1/packer_0.12.1_linux_amd64.zip" && \
    wget -q "https://releases.hashicorp.com/terraform/0.8.2/terraform_0.8.2_linux_amd64.zip" && \
    unzip '*.zip' && \
    rm *.zip && \
    chmod +x packer terraform

# Set up golang.
RUN cd /tmp && \
    go_tar="go1.7.4.linux-amd64.tar.gz" && \
    wget -q "https://storage.googleapis.com/golang/$go_tar" && \
    tar -C /usr/local -xzf $go_tar && \
    rm $go_tar
ENV GOPATH /root/go
ENV PATH=$PATH:/usr/local/go/bin
RUN mkdir $GOPATH
