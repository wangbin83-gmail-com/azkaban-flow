export JAVA_HOME=/usr/java/jdk1.7.0_45/

flag=0
while [ $flag -eq 0 ]; do
  bash /export/azkaban/shell/split_and_load_giftcard_rule.sh giftcard_rule_curr
  hadoop fs -rmr -skipTrash /tmp/riskintercept/
  hadoop --config /export/azkaban/jar/hadoop_conf/ jar combined.jar  com.chinabank.wrycm.RiskinterceptModel -r 20 -o /tmp/riskintercept/ -d tmp -t giftcard_test
  bash /export/azkaban/shell/filter_and_sort.sh
  cat /tmp/riskintercept/result.sort | python choose_rule.py
  flag=$?
  echo $flag
  if [ $flag -eq 0 ];
  then
    hive -f hive.hql
  fi
done
hadoop fs -put rule.txt /tmp/
