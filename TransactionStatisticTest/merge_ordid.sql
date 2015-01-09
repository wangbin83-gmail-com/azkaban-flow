set mapreduce.job.queuename=BI;
drop table tmp.d03_agr_moto_pay_with_orderid;
create table tmp.d03_agr_moto_pay_with_orderid AS
select a.orderid, b.MER_ORDER_NO, b.sys_tra_dt, b.SYS_TRA_TM, b.TRA_TYPE, b.TRA_STATUS, b.CARD_NO
from ddedw.fdm_paymentpipe_payordrelations_chain a join dw.d03_agr_moto_pay b
on a.payorderid = b.mer_order_no;

