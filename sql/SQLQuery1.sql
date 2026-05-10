CREATE TABLE student_2024 (
    stu_id VARCHAR(20) PRIMARY KEY,
    stu_name VARCHAR(10) NOT NULL,
    gender CHAR(2) CHECK (gender IN ('男','女')),
    class_name VARCHAR(30) NOT NULL,
    major VARCHAR(50) NOT NULL,
    college VARCHAR(50) NOT NULL,
    enter_year INT DEFAULT 2024
);
CREATE TABLE student_2025 (
    stu_id VARCHAR(20) PRIMARY KEY,
    stu_name VARCHAR(10) NOT NULL,
    gender CHAR(2) CHECK (gender IN ('男','女')),
    class_name VARCHAR(30) NOT NULL,
    major VARCHAR(50) NOT NULL,
    college VARCHAR(50) NOT NULL,
    enter_year INT DEFAULT 2024
);
SELECT DB_NAME() AS 当前数据库名;
-- 1. 强制切换到 Student 数据库
USE Student;
GO

-- 2. 删除 master 里那个“看不见”的旧表（避免再报错）
USE master;
GO
DROP TABLE IF EXISTS student_2024;
DROP TABLE IF EXISTS student_2025;
GO

-- 3. 回到 Student 数据库，创建你需要的表
USE Student;
GO
GO
USE Student;
GO

INSERT INTO stu2024 (stu_id, stu_name, gender, class_name, major, college)
VALUES
('2024001','张三','男','计算机1班','计算机科学与技术','信息工程学院'),
('2024002','李四','女','计算机1班','计算机科学与技术','信息工程学院'),
('2024003','王五','男','软件1班','软件工程','信息工程学院'),
('2024004','赵六','女','软件1班','软件工程','信息工程学院'),
('2024005','孙七','男','网络1班','网络工程','信息工程学院'),
('2024006','周八','女','网络1班','网络工程','信息工程学院'),
('2024007','吴九','男','数据1班','数据科学','信息工程学院'),
('2024008','郑十','女','数据1班','数据科学','信息工程学院'),
('2024009','小明','男','智能1班','人工智能','信息工程学院'),
('2024010','小红','女','智能1班','人工智能','信息工程学院');
GO

INSERT INTO stu2025 (stu_id, stu_name, gender, class_name, major, college)
VALUES
('2025001','陈浩','男','计算机1班','计算机科学与技术','信息工程学院'),
('2025002','刘琳','女','计算机1班','计算机科学与技术','信息工程学院'),
('2025003','杨阳','男','软件1班','软件工程','信息工程学院'),
('2025004','黄琪','女','软件1班','软件工程','信息工程学院'),
('2025005','罗凯','男','网络1班','网络工程','信息工程学院'),
('2025006','郭萌','女','网络1班','网络工程','信息工程学院'),
('2025007','邓辉','男','数据1班','数据科学','信息工程学院'),
('2025008','宋雪','女','数据1班','数据科学','信息工程学院'),
('2025009','付杰','男','智能1班','人工智能','信息工程学院'),
('2025010','董丽','女','智能1班','人工智能','信息工程学院');
GO
select *
from stu2024
where gender='女'
create table r(--SQL serve应当使用圆括号而不是花括号。
学生  varchar(10),
课程 varchar(10)
);
create table s(
课程 varchar(10)
);
insert into r values
('王五','语文'),
('张三','数学'),
('离散','语文');
insert into s values
('语文'),
('数学');
select distinct 学生
from R as r
where not exists(
select * from S as s
where not exists(
select *from R as r2
where r2.学生=r.学生 and r2.课程=s.课程
)
);--执行除操作