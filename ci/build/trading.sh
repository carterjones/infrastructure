#!/bin/bash
set -euxo pipefail

# Save the output directory.
out="$PWD/out/bundle/"
mkdir -p $out

# Copy private dependencies to the go path.
trading_go_path="$GOPATH/src/git.carterjones.info/personal/trading/"
mkdir -p $trading_go_path
for dir in coinigy slack socketcluster trading; do
    cp -R "repo-trading/${dir}" $trading_go_path
    ls -l $trading_go_path
done

# Get the prerequisites.
go get github.com/fatih/structs
go get github.com/go-redis/redis
go get github.com/go-sql-driver/mysql
go get github.com/gorilla/websocket
go get github.com/jinzhu/gorm
go get github.com/jinzhu/gorm/dialects/mysql
go get github.com/montanaflynn/stats
go get gopkg.in/ini.v1

# Define the utilities to build.
utilities="analyze clean persist trade"

# Build each utility.
for util in $utilities; do
    pushd repo-trading/cmd/$util
    GOOS=linux go build

    # Move the compiled binary to the output directory.
    mv $util $out
    popd
done

# Combine all the output.
pushd out
tar -zcvf bundle.tar.gz bundle
popd
