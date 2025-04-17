#!/bin/bash

git submodule update --init

cd terraform/
tflint --init
cd ..

# Print version information
echo "Terraform: $(terraform --version | awk 'NR==1 {print $2}')"
echo "TFLint: $(tflint --version | awk 'NR==1 {print $3}')"
echo "tfprovidercheck: $(tfprovidercheck --version | awk 'NR==1 {print $3}')"
echo "Trivy: $(trivy --version -q | awk 'NR==1 {print $2}')"
echo "Actionlint: $(actionlint --version | awk 'NR==1 {print $1}')"
echo "ShellCheck: $(shellcheck --version | awk 'NR==2 {print $2}')"
echo "Dockerize: $(dockerize --version)"
echo "Hugo: $(hugo version | awk 'NR==1 {print $2}')"
echo "Bats: $(bats --version | awk 'NR==1 {print $2}')"
