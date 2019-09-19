create table date_range_sail_count ( 
date_range string comment'交易时间段',
sail_count int comment'手机销量' )

desc date_range_sail_count;

insert into date_range_sail_count
select  deal_time,count(*) as count
from goods_sail_tb g
join user_action_tb u on u.goods_id=g.goods_id 
group by deal_time
order by count desc
limit 10;

select * from date_range_sail_count limit 10;

create table price_range_sail_count (
price_range string comment'价格区间',
 sail_count int comment'手机销量' ) 
 
 desc price_range_sail_count;
 
 create table price_range_sail_count_mid as
 select 
 case
  when goods_price<1000  then  '1000 元以下' 
  when goods_price>=1000 and goods_price<2000 then  '1000-2000元'
  when goods_price>=2000 and goods_price<3000 then  '2000-3000元' 
  when goods_price>=3000 and goods_price<4000 then  '3000-5000元'
  when goods_price>=5000 and goods_price<8000 then  '5000-8000元'
  when goods_price>=8000 and goods_price<1000 then  '8000-10000元' 
  when goods_price>=10000 then  '10000元以上 ' 
  else   '1000 元以下' 
 end as pricerange
 from goods_sail_tb
 
 //drop table  price_range_sail_count_mid
 select * from price_range_sail_count_mid limit 50;
 
 insert into price_range_sail_count
 select pricerange,count(*) 
 from price_range_sail_count_mid 
 group by pricerange;
 
 select * from price_range_sail_count;
 
