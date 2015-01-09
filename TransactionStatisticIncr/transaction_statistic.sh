#!/bin/bash

hadoop --config . jar combined.jar com.chinabank.wrycm.TransactionStatistic -r 100 -i
