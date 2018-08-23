FROM archlinux/base:latest

RUN pacman -Syu --noconfirm \
    git \
    grep \
    lsb-release \
    sudo

# Manually set the lsb-release value. This is a total hack, but it works for
# what I need for my testing purposes.
RUN sed -i"" "s/DISTRIB_ID.*/DISTRIB_ID=Manjaro/;s/DISTRIB_DESCRIPTION.*/DISTRIB_DESCRIPTION=Manjaro/" /etc/lsb-release
