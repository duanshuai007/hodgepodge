##database
| 序号 | 停车场编号 | 车牌号 | 入场时间 | 出场时间 | 是否会员 | 成功收费|
| :-: |:-: |:-:   | :-:     | :-:     | :-:    | :-:|
|4 Byte| 1 Byte |20 Char| 14 Char | 14 Char | 1 Char Y/N| 1 Char Y/N |
|主键||索引|

查看表结构,显示所有行: 
`show full columns from 表名;`

删除表中对应的字段: 
`alter table 表名 drop column 字段名;`

修改表名:
`alter table 原表名 rename 新表名;`

在表中指定的字段后添加新的字段,类型为char(10):
`alter table 表名 add 新字段 char(10) after 指定字段;`

修改表中指定字段的数据类型为int(4):
`alter table 表名 modify column 指定字段 int(4);`

修改表中指定字段的名字，并指定新数据类型:
`alter table 表名 change 原字段名 新字段名 char(4);`

更新表中内容:
`update 表名 set 字段='新值' where 条件;`

删除一行信息：
`delete from mypark where number=3;`

添加一行内容:
`insert into mypark(number,parknumber,plate,dizhi,intime,isVIP) values(3,9,'辽A19872','SC','20190102190345','N');`

* `mysql_store_result()`把结果保存在本地，浪费内存。但是不用对所有结果进行处理。
* `mysql_use_result()`从服务器读取一行一行的结果，每次读取一行，必须读取到结果为空为止，否则再执行别的指令会出现错误。必须执行`mysql_fetch_row()`，直至返回NULL值。`mysql_use_result()`将初始化结果集检索，但并不像`mysql_store_result()`那样将结果集实际读取到客户端。

查找满足条件的行：

```
找出时间在两者之间，包括两者的消息
select * from park01 where intime between "20190123155456" and "20190123175456"
找出时间小于的消息
select * from park01 where intime < "20190123155456"
查询d_no是d001或d002的学生
select * from students where d_no in('d001','d002');
查询phone不为空的学生
select * from students where phone is not null;
查询姓李的学生
select * from students where s_name like'李%';
查询地址在北京路的学生
select * from students where address like'%北京%';
查询姓名是两个字的学生_表示一个字符
select * from students where s_name like '__';
在students表中按系(d_no)统计各系的学生人数，SQL语句如下
select d_no as '系别' count(*) as '各系人数' from students group by d_no;
在students表中统计各系(d_no)男女生(sex)人数。SQL语句如下。
select d_no as '系别', sex as '性别' ,count(*) as '人数' from students group by d_no,sex;
查询（students）表中学生所在系部(d_no)，去掉重复值。SQL语句 如下
select  d_no distinct from  students;


参考文章：https://www.cnblogs.com/lijinwen/p/5444956.html
```

主键索引:
```
ALTER TABLE `表名` ADD PRIMARY KEY (`字段名`)
```

UNIQUE(唯一索引):
```
ALTER TABLE `表名` ADD UNIQUE (`字段名`)
```

INDEX(普通索引):
```
ALTER TABLE `表名` ADD INDEX index_name (`字段名`) 
```

FULLTEXT(全文索引):
```
ALTER TABLE `表名` ADD FULLTEXT ( `字段名` )
```

组合索引:
```
ALTER TABLE `表名` ADD INDEX index_name ( `字段名1`, `字段名2`, `字段名3` ) 
```