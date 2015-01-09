#!/bin/bash

python choose_rule.py
if [ $? -eq 0 ]:
  hive -f hive.hql
fi
