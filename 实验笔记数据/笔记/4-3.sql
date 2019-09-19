create table comment_word_count_tb( 
word string, 
count int) 
row format delimited fields terminated by ',';
load data local inpath '/xxx/result.txt' into table comment_word_count_tb; 