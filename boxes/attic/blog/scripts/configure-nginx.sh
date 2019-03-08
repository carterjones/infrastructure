#!/bin/bash
set -eux -o pipefail

sudo rm /etc/nginx/sites-enabled/*
sudo ln -s /etc/nginx/sites-available/ghost /etc/nginx/sites-enabled/
