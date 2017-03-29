FROM kalilinux/kali-linux-docker:latest

# Set up deb files.
RUN apt -qq update && \
    apt -qq upgrade -y && \
    apt -qq install -y \
        curl \
        git \
        jq \
        metasploit-framework \
        nmap \
        unzip && \
    apt -qq autoremove && \
    apt -qq clean

# Start a shell when the image is run.
CMD ["/bin/bash"]
