#!/bin/bash

docker run -it -v ~/github:/root/github -v ~/.ssh:/root/.ssh myubuntu:latest bash
