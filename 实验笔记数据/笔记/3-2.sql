
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

desc  person_user_tag_user_age_region;

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
when user_grade='PLUS会员' then "A111U004_008" 
else "A111U003_000"
end,
user_grade,
"用户等级" 
from user_info_new_tb
limit 20

select * from person_user_tag_grade limit 10;



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

select * from person_user_tag_action limit 10;
