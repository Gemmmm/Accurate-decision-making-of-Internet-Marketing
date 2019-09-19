性别
select gender,count(*) 
from user_info_new_tb
group by gender;

用户行为分布
select user_action,count(*) from user_action_tb group by action

单品用户区域分布

用户等级分布
select user_grade,count(*)
from user_info_new_tb
group by user_grade



用户等级分布
单品用户区域分布
用户行为分布
用户性别比例
苹果手机单品销售Top20
用户年龄段销售统计
价格区间销售统计
某年各时间段销售统计
华为手机单品销售Top20
手机销售Top10
评论热词top200