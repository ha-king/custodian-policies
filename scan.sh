#!/bin/bash

account_list=(sandbox anthem-ops hach blackbaud canon elk default)
region_list=(us-east-1 us-east-2 us-west-1 us-west-2)

for account in "${account_list[@]}"; do
  for region in "${region_list[@]}"; do
    /bin/bash audit.sh $account $region >> sg-scan/$account.csv
  done;
done

exit 0
