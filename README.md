# custodian-policies

## Cloud Custodian policies for fleet management and security audits.

### Prerequisite:

#### Pull Docker image
```
docker pull cloudcustodian/c7n
```
### Example policy: sg-remove-open.yml
```
policies:
  - name: sg-remove-open
    resource: security-group
    description: |
      Remove any rule from a security group that allows 0.0.0.0/0 or ::/0 (IPv6) ingress.
    mode:
        type: cloudtrail
        role: custodian-ec2-role
        events:
          - source: ec2.amazonaws.com
            event: AuthorizeSecurityGroupIngress
            ids: "requestParameters.groupId"
          - source: ec2.amazonaws.com
            event: AuthorizeSecurityGroupEgress
            ids: "requestParameters.groupId"
          - source: ec2.amazonaws.com
            event: RevokeSecurityGroupEgress
            ids: "requestParameters.groupId"
          - source: ec2.amazonaws.com
            event: RevokeSecurityGroupIngress
            ids: "requestParameters.groupId"
    filters:
      - or:
            - type: ingress
              IpProtocol: tcp
              Ports: [4441]
              Cidr:
                value: "0.0.0.0/0"
            - type: ingress
              IpProtocol: tcp
              Ports: [4441]
              CidrV6:
                value: "::/0"
    actions:
        - type: remove-permissions
          ingress: matched

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
