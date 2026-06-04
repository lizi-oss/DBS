create database student
on primary/*定义数据文件。*/
(
name='MySchhol_data',
filename='D:\MySchhol_data.mdf',
size=5MB,
maxsize=100MB,
filegrowth=15%
)
log on /*日志文件（记录操作记录，比如谁插入了、删除了）*/
(
name='MySchool_log',
filename='D:\MySchhol_log.ldf',
size=2MB,
filegrowth=1MB
 )
 create table student 
 (
sno char(9)  primary key,
sname char(10) not null ,
ssex char(2) ,
sage smallint check(sage>12),
sdept char(15)
);
/*错误的点有
1.主键的位置写在了最前面，给忘了。
2.长度忘记加括号了应该char（数）
3.not null连着写了
4.检查约束是check（内容）*/
create table course
(
cno char(4) primary key,
canme char(20) not null,
cpno char(4),
ccredit smallint
);
create table sc
(
sno char(9) ,
cno char(4) ,
primary key(sno,cno),
grade decimal(5,1) check(grade>=0 and grade<=100),
foreign key(sno) references student(sno),
foreign key(cno) references course(cno) 
);
/*错误的地方在于
1.联合主键写错了peimarykey (内容)。
2.decimal应该是（5，1）这里一般1是小数位
3.check不接受连写的条件表达式，必须用and或者or链接。
4.外码是foreign key（当前需要的列）references 外表（一样的列）*/
ALTER TABLE course
ALTER COLUMN canme VARCHAR(40);

ALTER TABLE student
ADD birthday DATETIME NULL;

ALTER TABLE sc
ALTER COLUMN grade DECIMAL(5,1);

ALTER TABLE sc
ADD CHECK (grade >= 0 AND grade <= 150);

ALTER TABLE student
ADD DEFAULT '男' FOR ssex;

ALTER TABLE student
ADD CONSTRAINT ck_student CHECK (Sdept IN ('CS', 'MA', 'IS'));

ALTER TABLE student
ADD UNIQUE (sname);

ALTER TABLE sc
ADD FOREIGN KEY (sno) REFERENCES student(sno);

ALTER TABLE student
NOCHECK CONSTRAINT ck_student;

CREATE INDEX idx_student_sname 
ON student (sname DESC);

CREATE UNIQUE INDEX idx_course_cname 
ON course (canme);


-- 1. 创建测试表
create table TableIndex
(
    ID int identity(1,1),
    DataValue decimal(18,2)
)
Go

-- 2. 插入20000条随机数据
declare @r numeric(15,8)
declare @n int
set @n = 0
while(1=1)
begin
    set @r = rand()
    insert into TableIndex (DataValue) values(@r)
    set @n = @n + 1
    if(@n>20000)
        break
end
Go

-- 3. 查看数据
select * from TableIndex
Go

-- ===================== 无索引查询耗时 =====================
set nocount on
declare @d datetime
set @d = getDate()

select * from TableIndex
where DataValue between 0.3 and 0.9

declare @time int
set @time = datediff(ms,@d,getDate())
print '无索引查询耗时：'+convert(varchar(10),@time)

-- ===================== 创建索引 =====================
if exists(select name from sys.indexes where name = 'IX_DataValue')
    drop index TableIndex.IX_DataValue

create nonclustered index IX_DataValue
on TableIndex(DataValue)
with fillfactor = 30
Go

-- ===================== 有索引查询耗时 =====================
set nocount on
declare @d datetime
set @d = getDate()

select * from TableIndex with(index=IX_DataValue)
where DataValue between 0.3 and 0.9

declare @time int
set @time = datediff(ms,@d,getDate())
print '有索引查询耗时：'+convert(varchar(10),@time)