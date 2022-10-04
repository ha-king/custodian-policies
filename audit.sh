#!/bin/bash

docker run -it \
  -v $(pwd)/output:/home/custodian/output \
  -v $(pwd)/sg-policy-all.yml:/home/custodian/sg-policy-all.yml \
  -v $(cd ~ && pwd)/.aws/credentials:/home/custodian/.aws/credentials \
  -v $(cd ~ && pwd)/.aws/config:/home/custodian/.aws/config \
  --env-file <(env | grep "^AWS") \
  cloudcustodian/c7n run -v -s /home/custodian/output /home/custodian/sg-policy-all.yml --profile $1 --region $2 &&

docker run -it \
  -v $(pwd)/output:/home/custodian/output \
  -v $(pwd)/sg-policy-all.yml:/home/custodian/sg-policy-all.yml \
  -v $(cd ~ && pwd)/.aws/credentials:/home/custodian/.aws/credentials \
  -v $(cd ~ && pwd)/.aws/config:/home/custodian/.aws/config \
  --env-file <(env | grep "^AWS") \
  cloudcustodian/c7n report -v -s /home/custodian/output /home/custodian/sg-policy-all.yml --profile $1 --region $2

exit 0
