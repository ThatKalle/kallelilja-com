#!/bin/bash

git submodule update --init || echo "no submodules to update"

cd terraform/
tflint --init
cd ..

cd web/
nohup hugo server --baseURL localhost --poll 500ms & dockerize -wait tcp://localhost:1313 -timeout 30s
