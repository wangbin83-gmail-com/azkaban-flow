set hive.mapjoin.maxsize=1000000;
set hive.auto.convert.join=true;
set hive.mapjoin.followby.map.aggr.hash.percentmemory=0.7;
set mapreduce.job.queuename=BI;
set hive.mapjoin.smalltable.filesize=100000000;
set mapreduce.map.memory.mb=4092;
drop table tmp.d03_agr_moto_pay_with_orderid_userinfo;
create table tmp.d03_agr_moto_pay_with_orderid_userinfo AS
select /*+ MAPJOIN(a) */ a.*, b.parent_sale_ord_id, b.user_actual_pay_amount, b.pay_tm, b.valid_flag, 
b.user_id, b.user_log_acct, b.user_lv_cd, b.user_reg_tm, b.sale_ord_type_cd, b.place_ord_ip,
b.reg_user_type_cd, b.ord_tm, b.ord_dt
from tmp.d03_agr_moto_pay_with_orderid a join ddedw.gdm_m04_ord_sum b 
on a.orderid = b.parent_sale_ord_id;
