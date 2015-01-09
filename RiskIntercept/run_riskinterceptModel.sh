#!/bin/bash

export JAVA_HOME=/usr/java/jdk1.7.0_45/

hadoop fs -rmr -skipTrash /tmp/riskintercept/
cd /export/azkaban/jar/TransactionStatistic
hadoop --config /export/azkaban/jar/hadoop_conf/ -files rule.yaml jar /export/azkaban/jar/TransactionStatistic/combined.jar  com.chinabank.wrycm.RiskinterceptModel -r 20 -o /tmp/riskintercept/ -d tmp -t giftcard_test
