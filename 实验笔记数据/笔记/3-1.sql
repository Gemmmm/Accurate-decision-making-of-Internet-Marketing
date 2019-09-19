


create table test(
name string,
friends array<string>,
children map<string, int>,
address struct<street:string, city:string>
)
row format delimited fields terminated by ','
collection items terminated by '_'
map keys terminated by ':'
lines terminated by '\n';


create table goods_sail_tb(
goods_id string,
goods_name string,
goods_property string,
store_name string,
stroe_id string,
goods_url string,
goods_price float,
keyword string,
sail_count int,
good_rate int,
brand string,
model string,
color string,
time_to_market string,
operate_system string)
row format delimited fields terminated by ','
lines terminated by '\n';

load data local inpath '/home/hadoop/data/data1/iphone.txt' into table goods_sail_tb;



create table user_action(
user_id string,
goods_id string,
user_action int,
month string,
day string)
row format delimited fields terminated by ','
lines terminated by '\n';

load data local inpath '/home/hadoop/data/data1/action.txt' into table user_action;



create table user_action_tb(
user_id string,  
goods_id string,
user_action int,
deal_time string)
row format delimited fields terminated by ','
lines terminated by '\n';


insert into table user_action_tb  select user_id,goods_id,user_action,concat(month,'-',day) from user_action;


create table user_info_tb(
user_id string,
user_name string,
addr string ,
gender string,
birthday string)
row format delimited fields terminated by ','
lines terminated by '\n';


load data local inpath '/home/hadoop/data/data1/userinfo.txt' into table user_info_tb;


create table user_info_new_tb(
user_id string,
user_name string,
addr string ,
gender string,
age_region int,
age_region_alias string,
user_grade string)

//select user_id,user_name,addr,gender from user_action_tb where birthday between "2001" and "2019"

//select * from user_info_tb where  birthday between '1998-3-16' and'1998-3-17';


create table user_comment_tb(
goods_id string,
comment string,
releasetime string ,
user_id string,
user_name string,
user_level string,
goods_color string,
answercount string,
e_score string,
resource string)
row format delimited fields terminated by ','
lines terminated by '\n';


load data local inpath '/home/hadoop/data/data1/comment.txt' into table user_comment_tb;


create table user_info_mid as 
select i.user_id,i.user_name,i.addr,i.gender,
floor(datediff(concat('',from_unixtime(unix_timestamp()),''),
concat('',birthday,'')) / 365) age,
c.user_level 
from user_info_tb i 
join user_comment_tb c on i.user_id=c.user_id;



insert into user_info_new_tb select user_id,user_name,addr,gender,
case when age>=0 and age<=17 then 1
when age >= 18 and age <=24 then 2
when age >= 25 and age <= 29 then 3
when age>= 30 and age <= 34 then 4
when age>= 35 and age <= 39 then 5
when age>=40 and age<=49 then 6
when age>=50 then 7 end as age_region,
case when age>=0 and age<=17 then "18岁以下"
when age>=18 and age<=24 then "[18,24]"
when age>=25 and age<=29 then "[25,29]"
when age>=30 and age<=34 then "[30,34]"
when age>=35 and age<=39 then "[35,39]"
when age>=40 and age<=49 then "[40,49]"
when age>=50 then "50岁以上" end as age_region_alias
,user_level from user_info_mid ;

