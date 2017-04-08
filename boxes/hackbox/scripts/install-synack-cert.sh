#!/bin/bash

cd /usr/local/share/ca-certificates/
sudo mkdir synack
sudo chmod 755 synack
cd synack
sudo wget "https://s3.amazonaws.com/synack-app.synack.com/ca.crt"
sudo chmod 644 ca.crt
sudo update-ca-certificates
