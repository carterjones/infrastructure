FROM centos:7

# Update repo.
RUN yum update -y

# Shared requirements.
RUN yum group install -y "Development Tools"
RUN yum install -y \
    rpm-build

# Emacs dependencies.
RUN yum install -y \
    gnutls-devel \
    libjpeg-devel \
    libpng-devel \
    libtermcap-devel \
    libtiff-devel \
    libungif-devel \
    libXaw-devel \
    texinfo
