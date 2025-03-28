#!/bin/bash

git submodule update --init

cd terraform/
tflint --init

terraform --version
tflint --version
trivy --version
tfprovidercheck --version
cd ..

cd .github/workflows
actionlint --version
shellcheck --version
cd ../..

cd web/
dockerize --version
hugo version

if [ -f "nohup.out" ]; then rm nohup.out; fi
nohup hugo server --baseURL localhost --poll 500ms & dockerize -wait tcp://localhost:1313 -timeout 30s
cd ..
