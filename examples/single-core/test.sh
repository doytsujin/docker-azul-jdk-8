#!/bin/bash

CMD="docker run --cpus 1 \
                --interactive \
                --name single-core-jdk \
                --rm \
                --tty \
                --memory 268435546 \
                --memory-swap 0 \
                singlecore_single-core-jdk:latest"
echo $CMD
$CMD
