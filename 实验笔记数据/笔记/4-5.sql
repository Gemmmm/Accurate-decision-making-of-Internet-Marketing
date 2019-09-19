在Hive中，创建用户评论周期分析结果表typenums，包含两个字段类型及数量
	create table typenums(  leixing string,   num int  )  
	row format delimited fields terminated by '\t'  
	stored as textfile;  
对用户评论间隔时间进行统计，并将统计结果导入到Hive中的typenums表中。
	insert into table  select  
	 leixing,  count(*) as num  
	from govdata  
	group by leixing  
	order by num desc;  
查看Hive表typenums中的数据
	select * from typenums;  
在Mysql端口创建typenum表，用于存储typenums中的数据。typenum中同样包含两个字段类型及数量
	create table typenum(leixing varchar(,num int);  
使用Sqoop命令将Hive的typenums表导入到Mysql的typenum里。
	sqoop export \  
	--connect jdbc:mysql://localhost:eduut?characterEncoding=UTF-\  
	--username root \  
	--password strongs \  
	--table typenum \  
	--export-dir /user/hive/warehouse/edudb/typenums/\  
	--input-fields-terminated-by '\t';  
查看mysql中typenum表。
	select * from typenum;  

	
	bin/sqoop export \  
	--connect jdbc:mysql://localhost:3306/sail \
	--username root \  
	--password hadoop \  
	--table typenum \  
	--export-dir /user/hive/warehouse/edudb/typenums/\  
	--input-fields-terminated-by '\t';  
	
act_weight_detail
age_region_sail_info
city_region_sail_info
comment_word_count_tb
date_range_sail_count
goods_sail_tb
huawei_model_info
iphone_model_info
iphone_sail_top10
person_user_tag_action
person_user_tag_gender
person_user_tag_grade
person_user_tag_user_age_region
price_range_sail_count
price_range_sail_count_mid
user_action
user_action_tb
user_comment_tb
user_info_mid
user_info_new_tb
user_info_tb
userinfo_mid


导出用户各年龄段销量表数据到 postgres；
 insert overwrite local directory '/home/hadoop/data/data0/age_region_sail_info' 
 row format delimited  fields terminated by ',' 
 select * from age_region_sail_info;
	 
导出各地区手机单品销量数据到 postgres；
 insert overwrite local directory '/home/hadoop/data/data0/city_region_sail_info' 
 row format delimited  fields terminated by ',' 
 select * from city_region_sail_info;
  
导出手机销量 Top10 表中数据到 postgres； 
insert overwrite local directory '/home/hadoop/data/data0/iphone_sail_top10' 
 row format delimited  fields terminated by ',' 
 select * from iphone_sail_top10; 
导出华为手机单品销量 Top20 数据到 postgres；
  huawei_model_info
 insert overwrite local directory '/home/hadoop/data/data0/huawei_model_info' 
 row format delimited  fields terminated by ',' 
 select * from huawei_model_info;
导出苹果手机单品销量 Top20 数据到 postgres；
 insert overwrite local directory '/home/hadoop/data/data0/iphone_model_info' 
 row format delimited  fields terminated by ',' 
 select * from iphone_model_info;
导出各时间段手机销量数据到 postgres； 	
insert overwrite local directory '/home/hadoop/data/data0/date_range_sail_count' 
 row format delimited  fields terminated by ',' 
 select * from date_range_sail_count;
	 
导出各价格区间手机销量数据到 postgres；
price_range_sail_count

insert overwrite local directory '/home/hadoop/data/data0/price_range_sail_count' 
 row format delimited  fields terminated by ',' 
 select * from price_range_sail_count;  
导出用户评论词频统计 Top200 数据到 postgres；
导出用户标签宽表数据到 postgres；
	