#!/bin/bash
set -e

if [[ -z "${1}" ]]; then
    echo "Please supply an image name to release."
    exit 1
fi

not_after=$(date -d "2021-04-01T00:00:00+00:00" +%s)
if [[ "${1}" == "manjaro" ]] && (( $(date +%s) < "${not_after}" )); then
    echo "Skipping Manjaro build until April 2021 due to a known glibc bug."
    echo "https://www.reddit.com/r/archlinux/comments/lek2ba/arch_linux_on_docker_ci_could_not_find_or_read/"
    exit
fi

image="${1}"
git_hash=$(git rev-parse --verify HEAD)

docker build -f "Dockerfile.${image}" -t "carterjones/${image}:latest" .
docker tag "carterjones/${image}:latest" "carterjones/${image}:${git_hash}"

if [[ $(git branch --show-current) == "main" ]]; then
    docker login -u "${DOCKERHUB_USERNAME}" -p "${DOCKERHUB_PASSWORD}"
    docker push "carterjones/${image}:${git_hash}"
    docker push "carterjones/${image}:latest"
fi
