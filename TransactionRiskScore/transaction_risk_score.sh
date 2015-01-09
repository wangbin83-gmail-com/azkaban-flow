#!/bin/bash

hadoop --config . jar combined.jar com.chinabank.wrycm.TransactionRiskScore -r 100 -i
