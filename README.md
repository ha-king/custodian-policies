# custodian-policies

## Cloud Custodian policies for fleet management and security audits.

### Prerequisite:

#### Pull Docker image
```
docker pull cloudcustodian/c7n
```


### Usage:

#### Run
```
docker run -it \
  -v $(pwd)/output:/home/custodian/output \
  -v $(pwd)/sg-remove-open.yml:/home/custodian/sg-remove-open.yml \
  -v $(cd ~ && pwd)/.aws/credentials:/home/custodian/.aws/credentials \
  -v $(cd ~ && pwd)/.aws/config:/home/custodian/.aws/config \
  --env-file <(env | grep "^AWS") \
  cloudcustodian/c7n run -v -s /home/custodian/output /home/custodian/sg-remove-open.yml
```

#### Report
```
docker run -it \
  -v $(pwd)/output:/home/custodian/output \
  -v $(pwd)/sg-remove-open.yml:/home/custodian/sg-remove-open.yml \
  -v $(cd ~ && pwd)/.aws/credentials:/home/custodian/.aws/credentials \
  -v $(cd ~ && pwd)/.aws/config:/home/custodian/.aws/config \
  --env-file <(env | grep "^AWS") \
  cloudcustodian/c7n report -v -s /home/custodian/output /home/custodian/sg-remove-open.yml
```
