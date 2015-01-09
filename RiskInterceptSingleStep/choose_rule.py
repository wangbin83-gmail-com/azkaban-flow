#!/usr/bin/env python

import sys

class Rule(object):

    def __init__(self, rule, wrong_num, wrong_amount, risk_num, risk_amount, risk_ids):
        self.rule = rule
        self.rule_num = len(rule.split('#'))
        self.risk_num = int(risk_num)
        self.accuracy = int(risk_num) * 1.0 / (int(wrong_num) + int(risk_num))
        self.wrong_amount = float(wrong_amount)
        self.risk_amount = float(risk_amount)
        self.risk_ids = risk_ids

    def __str__(self):
        return "\t".join((self.rule, self.risk_ids))

    def __eq__(self, other): 
        if self.risk_amount == other.risk_amount:
            if self.wrong_amount == other.wrong_amount:
                if self.accuracy == other.accuracy:
                    if self.risk_num == other.risk_num:
                        if self.rule_num == other.rule_num:
                            return True
        return False

    def __lt__(self, other):
        if self.risk_amount == other.risk_amount:
            if self.wrong_amount == other.wrong_amount:
                if self.accuracy == other.accuracy:
                    if self.risk_num == other.risk_num:
                        if self.rule_num == other.rule_num:
                            return False
                        else:
                            return self.rule_num > other.rule_num
                    else:
                        return self.risk_num < other.risk_num
                else:
                    return self.accuracy < other.accuracy
            else:
                return self.wrong_amount > other.wrong_amount

        else :
            return self.risk_amount < other.risk_amount

rules = []
rule_file = open('rule.txt', 'a')
sql_file = open('hive.hql', 'w')

for line in sys.stdin:
    line = line.strip()
    words = line.split('\t')
    if float(words[2]) > float(words[4]):
        continue
    rule = Rule(words[0], words[1], words[2], words[3], words[4], words[5])
    rules.append(rule)
if len(rules) == 0:
    sys.exit(-1)
rules.sort(reverse = True)
rule_file.write(rules[0].rule)
rule_file.write("\n")
sql_file.write("USE DA; DROP TABLE IF EXISTS giftcard_rule_pre; ALTER TABLE giftcard_rule_curr RENAME TO giftcard_rule_pre;\n")
parent_ids = rules[0].risk_ids.split('#')
parent_ids.pop(-1)
str_parent_ids = ','.join(parent_ids)
sql_file.write("CREATE TABLE giftcard_rule_curr AS SELECT * FROM giftcard_rule_pre WHERE parent_sale_ord_id not IN( " + str_parent_ids + ");")
rule_file.close()
sql_file.close()