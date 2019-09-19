
drop table if exists act_weight_detail;

create table act_weight_detail ( 
user_id string comment "用户编码",
tag_id string comment "标签 id", 
tag_name string comment "标签名称", 
cnt int comment "行为次数", 
tag_type_id int comment "标签类型",
act_weight_detail float comment "行为权重" );

insert into table act_weight_detail
select user_id,tag_id,tag_name,action_count,tag_type,
case
when  tag_id="B211U001_001" then 2*action_count*100*exp(0.067)
when  tag_id="B211U001_002" then 3*action_count*100*exp(0.067)
when  tag_id="B211U001_003" then 4*action_count*100*exp(0.067)
when  tag_id="B211U001_004" then 5*action_count*100*exp(0.067)
end
from person_user_tag_action
limit 5

select * 
from  person_user_tag_action p
join user_comment_tb  a on a.user_id=p.user_id
limit 5;

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
