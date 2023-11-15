create database if not exists student_management;
use student_management;

CREATE TABLE Class (
    class_id INT PRIMARY KEY AUTO_INCREMENT,
    class_name VARCHAR(50)
);

insert into class (class_name)
values('C0823G1');

create table Teacher(
teacher_id int primary key auto_increment,
teacher_name varchar(50),
teacher_age int,
teacher_country varchar(50));

insert into teacher(teacher_name,teacher_age,teacher_country)
values('James', 40, 'Laos');

SELECT 
    *
FROM
    class