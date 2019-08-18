#!/bin/bash

# build the dex container
tag=$(git log -1 --date=format:%y.%m.%d_%H.%M --pretty=%ad)
sudo docker build -t aparmar/apache-letsencrypt:latest -t aparmar/apache-letsencrypt:$tag .
