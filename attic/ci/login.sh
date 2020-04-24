#!/bin/bash

# Yeah, -k is insecure, but that's how it's gonna be for now so #YOLO
fly -t ci login -k -c https://ci.carterjones.info
