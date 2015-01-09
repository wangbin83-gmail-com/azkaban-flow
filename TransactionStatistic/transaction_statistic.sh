#!/bin/bash

hadoop fs -rmr -skipTrash /BI/warehouse/tmp.db/tran_statistics_not_realtime/*
hadoop --config . jar combined.jar com.chinabank.wrycm.TransactionStatistic -r 100
