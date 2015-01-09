drop table tmp.gdm_m04_ord_sum_test;
create table tmp.gdm_m04_ord_sum_test as 
select * from ddedw.gdm_m04_ord_sum
where user_log_acct="黑建";
