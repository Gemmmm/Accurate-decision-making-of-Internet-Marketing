

3-1


, CONCAT(FIRST_NAME,' ', LAST_NAME) AS NAME
, EMAIL
, CONCAT('(',SUBSTR(PHONE_NUMBER,1,3),')',SUBSTR(PHONE_NUMBER,5)) AS PHONE_NUMBER




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



3-2




create table person_user_tag_gender(
user_id string comment'用户编码',
tag_id string comment '标签 id',
tag_name string comment'标签名称',
tag_type string comment'标签类型（主题）'
);


insert into person_user_tag_gender
select user_id,
case when gender='男' then "A111U001_001"
 when gender='女' then "A111U001_002" end,
 gender,
"用户性别" 
from user_info_new_tb
limit 5



create table person_user_tag_user_age_region(
user_id string comment'用户编码',
tag_id string comment '标签 id',
tag_name string comment'标签名称',
tag_type string comment'标签类型（主题）'
);

insert into person_user_tag_user_age_region
select user_id,
case when age_region=1 then "A111U002_001"
when age_region=2 then "A111U002_002"
when age_region=3 then "A111U002_003"
when age_region=4 then "A111U002_004"
when age_region=5 then "A111U002_005"
when age_region=6 then "A111U002_006"
when age_region=7 then "A111U002_007" end,
age_region,
"用户年龄段" 
from user_info_new_tb
limit 10

select * from person_user_tag_user_age_region limit 20;

create table person_user_tag_grade(
user_id string comment'用户编码',
tag_id string comment '标签 id',
tag_name string comment'标签名称',
tag_type string comment'标签类型（主题）'
);

insert into person_user_tag_grade
select user_id,
case when user_grade='注册会员' then "A111U003_001"
when user_grade='铜牌会员' then "A111U003_002"
when user_grade='银牌会员' then "A111U003_003"
when user_grade='金牌会员' then "A111U003_004"
when user_grade='钻石会员' then "A111U003_005"
when user_grade='企业会员' then "A111U003_006"
when user_grade='PLUS会员[试用]' then "A111U003_007" 
when user_grade='PLUS会员' then "A111U004_007" 
else "A111U003_000"
end,
user_grade,
"用户等级" 
from user_info_new_tb
limit 20


create table person_user_tag_action(
user_id string comment'用户编码',
tag_id string comment '标签 id',
tag_name string comment'标签名称',
tag_type string comment'标签类型',
action_count int comment'行为次数'
);

insert into person_user_tag_action
select user_id,
case
when user_action=0 then "B211U001_001"
 when user_action=1 then "B211U001_002"
when user_action=2 then "B211U001_003"
when user_action=3 then "B211U001_004"
end ,
case
when user_action=0 then "点击"
 when user_action=1 then "加入购物车"
when user_action=2 then "关注"
when user_action=3 then "购买"
end,
"用户行为", 
cast(count(*)/2 as int)
from user_action_tb
group by user_id,user_action
limit 10


4-1

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


insert into iphone_model_info
SELECT brand,count(*) as count FROM goods_sail_tb 
where brand like '%苹果%'
group BY
brand
ORDER BY count DESC
limit  20


统计用户各年龄段手机销量

create table age_region_sail_info(
age_region int,
model string,
count bigint)

insert into age_region_sail_info
select i.age_region_alias,g.brand ,count(*) as count
from user_comment_tb as c 
join user_info_new_tb as i on  i.user_id=c.user_id
join goods_sail_tb as g on g.goods_id =c.goods_id
group by i.age_region_alias,g.brand

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
group by substr(i.addr,1,3) ,g.brand;
order by count


4-2


drop table if exists act_weight_detail;

create table act_weight_detail ( 
user_id string comment "用户编码",
tag_id string comment "标签 id", 
tag_name string comment "标签名称", 
cnt int comment "行为次数", 
tag_type_id int comment "标签类型",
act_weight_detail float comment "行为权重" );


select user_id,tag_id,tag_name,action_count,tag_type,


from person_user_tag_action


create table profile_user_tb ( 
user_id string comment'用户编码',
 tag_id1 string comment '标签 1ID',
 tag_name1 string comment'标签 1 名称',
 tag_type1 string comment'标签 1 类型', 
 tag_id2 string comment '标签 2ID', 
 tag_name2 string comment'标签 2 名称', 
 tag_type2 string comment'标签 2 类型',
 tag_id3 float comment'标签 3ID',
 tag_name3 string comment'标签 3 名称',
 tag_type3 string comment'标签 3 类型',
 tag_id4 string comment '标签 4ID',
 tag_name4 string comment'标签 4 名称',
 action_count bigint comment'标签 4 行为次数',
 action_weight decimal(38,7) comment'标签 4 权重',
 tag_type4stringcomment'标签 4 类型' )


