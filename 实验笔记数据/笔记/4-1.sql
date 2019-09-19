create table iphone_sail_top10(brand string,scount bigint) ;

手机品牌销量top10
insert into iphone_sail_top10
SELECT brand,count(*) as count FROM
goods_sail_tb
GROUP BY
brand
ORDER BY count DESC
limit  1,10

查询
select * from iphone_sail_top10

华为
create table huawei_model_info(model string,mcount bigint) ;

insert into huawei_model_info
SELECT brand,count(*) as count FROM goods_sail_tb 
where brand like '荣耀%' or  brand like '华为%'
group BY
brand
ORDER BY count DESC
limit  20

select * from huawei_model_info


苹果
create table iphone_model_info(model string,mcount bigint) ;

truncate table iphone_model_info;
insert into iphone_model_info
SELECT brand,count(*) as count FROM goods_sail_tb 
where brand like '%苹果%' or brand like '%apple%' or brand like '%iphone%'
group BY
brand
ORDER BY count DESC
limit  20


统计用户各年龄段手机销量

drop table age_region_sail_info;
create table age_region_sail_info(
age_region string,
model string,
count bigint);

insert into age_region_sail_info
select i.age_region_alias,g.brand ,count(*) as count
from user_comment_tb as c 
join user_info_new_tb as i on  i.user_id=c.user_id
join goods_sail_tb as g on g.goods_id =c.goods_id
group by i.age_region_alias,g.brand
order by count desc
limit 10

select count(*) from user_info_new_tb where age_region_alias =null


统计用户各地区手机销量
create table  city_region_sail_info(
addr string,
model string,
count bigint)


insert into city_region_sail_info
select substr(i.addr,1,3)  ,g.brand ,count(*) as count
from user_comment_tb as c 
join user_info_new_tb as i on  i.user_id=c.user_id
join goods_sail_tb as g on g.goods_id =c.goods_id
group by substr(i.addr,1,3) ,g.brand
order by count desc
limit 10

select * from city_region_sail_info limit 10;
