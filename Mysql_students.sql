show databases;
use anildb;

CREATE TABLE if not exists students (
STUDENT_ID int,
first_nm varchar(100),
last_nm varchar(100),
gpa decimal(3,2),
enroll_dt datetime,
major varchar(100));

TRUNCATE TABLE students;
INSERT INTO students (STUDENT_ID, first_nm, last_nm, gpa, enroll_dt, major)
VALUES
(201, 'Shivansh', 'Mahajan', 8.79, '2021-09-01 09:30:00', 'Computer Science'),
(202, 'Umesh', 'Sharma', 8.44, '2021-09-01 08:30:00', 'Mathematics'),
(203, 'Rakesh', 'Kumar', 5.60, '2021-09-01 10:00:00', 'Biology'),
(204, 'Radha', 'Sharma', 9.20, '2021-09-01 12:45:00', 'Chemistry'),
(205, 'Kush', 'Kumar', 7.85, '2021-09-01 08:30:00', 'Physics'),
(206, 'Prem', 'Chopra', 9.56, '2021-09-01 09:24:00', 'History'),
(207, 'Pankaj', 'Vats', 9.78, '2021-09-01 02:30:00', 'English'),
(208, 'Navleen', 'Kaur', 7.00, '2021-09-01 06:30:00', 'Mathematics');

select * from students;

CREATE TABLE student_programs (
    STUDENT_REF_ID INT ,
    PROGRAM_NAME VARCHAR(50),
    PROGRAM_START_DATE DATE
);

INSERT INTO student_programs (STUDENT_REF_ID, PROGRAM_NAME, PROGRAM_START_DATE)
VALUES 
    (201, 'Computer Science', '2021-09-01'),
    (202, 'Mathematics', '2021-09-01'),
    (208, 'Mathematics', '2021-09-01'),
    (205, 'Physics', '2021-09-01'),
    (204, 'Chemistry', '2021-09-01'),
    (207, 'Psychology', '2021-09-01'),
    (206, 'History', '2021-09-01'),
    (203, 'Biology', '2021-09-01');
    
    
select * from student_programs;

CREATE TABLE student_scholarships (
    STUDENT_REF_ID INT,
    SCHOLARSHIP_AMOUNT DECIMAL(10, 2),
    SCHOLARSHIP_DATE DATE
);

INSERT INTO student_scholarships (STUDENT_REF_ID, SCHOLARSHIP_AMOUNT, SCHOLARSHIP_DATE)
VALUES 
    (201, 5000, '2021-10-15'),
    (202, 4500, '2022-08-18'),
    (203, 3000, '2022-01-25'),
    (201, 4000, '2021-10-15');
    
select * from student_scholarships;

### Q1 :Write a SQL query to fetch “FIRST_NAME” from the Student table in upper case and use ALIAS name as STUDENT_NAME.

SELECT UPPER(first_nm) as STUDENT_NAME from students;

### Q2:  Write a SQL query to fetch unique values of MAJOR Subjects from Student table.

SELECT DISTINCT major FROM students;

#### Q3: Write a SQL query to print the first 3 characters of FIRST_NAME from Student table.

SELECT first_nm from students limit 3;

#### Q4: Write a SQL query to find the position of alphabet (‘a’) int the first name column ‘Shivansh’ from Student table.

SELECT first_nm,position('a' in first_nm) from students;

### Q5:  Write a SQL query that fetches the unique values of MAJOR Subjects from Student table and print its length.

SELECT major,length(major) from students group by major;

### Q6: Write a SQL query to print FIRST_NAME from the Student table after replacing ‘a’ with ‘A’.

SELECT first_nm,replace(first_nm, 'a', 'A') from students;

###  Q7:Write a SQL query to print the FIRST_NAME and LAST_NAME from Student table into single column,

SELECT first_nm,last_nm,CONCAT(first_nm, ' ', last_nm) as full_nm from students;

### Q8: Write a SQL query to print all Student details from Student table order by FIRST_NAME Ascending and MAJOR Subject descending .

select * from students order by first_nm asc, major desc;

### Q9. Write a SQL query to print details of the Students with the FIRST_NAME as ‘Prem’ and ‘Shivansh’ from Student table.

SELECT * from students where lower(first_nm) in ('prem','shivansh');

### 10. Write a SQL query to print details of the Students excluding FIRST_NAME as ‘Prem’ and ‘Shivansh’ from Student table.

SELECT * from students where lower(first_nm) not in ('prem','shivansh');

###  11. Write a SQL query to print details of the Students whose FIRST_NAME ends with ‘a’.

SELECT * from students where first_nm like '%a';

#### 12. Write an SQL query to print details of the Students whose FIRST_NAME ends with ‘a’ and contains six alphabets

SELECT * from students where first_nm like '____a';

###  13. Write an SQL query to print details of the Students whose GPA lies between 9.00 and 9.99.

SELECT * from students WHERE gpa BETWEEN 9.00 and 9.99;

### 14. Write an SQL query to fetch the count of Students having Major Subject ‘Computer Science’.
SELECT  major,COUNT(*) from students WHERE major='Computer Science';

#### 15. Write an SQL query to fetch Students full names with GPA >= 8.5 and <= 9.5.
SELECT concat(first_nm,' ',last_nm) as full_nm from students where gpa >=8.5 and gpa <=9.5;

####16. Write an SQL query to fetch the no. of Students for each MAJOR subject in the descending order.
SELECT major,count(*) as no_of_students from students group by 1 order by 2 desc;

#### 17. Display the details of students who have received scholarships, including their names, scholarship amounts, and scholarship dates.
SELECT student_id,first_nm,last_nm,scholarship_amount,scholarship_date from students as a join student_scholarships as b on a.student_id=b.STUDENT_REF_ID;

#### 18. Write an SQL query to show only odd rows from Student table.
with cte as (SELECT *,row_number() over() as rn from students)
select * from cte where rn%2 != 0;

#### 19. Write an SQL query to show only even rows from Student table.
with cte as (SELECT *,row_number() over() as rn from students)
select * from cte where rn%2 = 0;

### 20. List all students and their scholarship amounts if they have received any. If a student has not received a scholarship, display NULL for the scholarship details.
SELECT * from students as a left join student_scholarships as b on a.student_id=b.STUDENT_REF_ID;

### 21. Write an SQL query to show the top n (say 5) records of Student table order by descending GPA.
select * from students order by gpa desc limit 5;

#### 22. Write an SQL query to determine the nth (say n=5) highest GPA from a table.
select * from students order by gpa desc limit 4,1;

##### 23. Write an SQL query to determine the 5th highest GPA without using LIMIT keyword.
with cte as(select *,row_number() over() as rn from students order by gpa desc)
select * from cte where rn=5;

### 24. Write an SQL query to fetch the list of Students with the same GPA.
select s1.* from students s1,students s2 where s1.gpa=s2.gpa and s1.student_id <> s2.student_id;

#### 25. Write an SQL query to show the second highest GPA from a Student table using sub-query.
select * from students where gpa < (select max(gpa) from students) limit 1;

### 26. Write an SQL query to show one row twice in results from a table.
select * from students union all select * from students order by 1 ;

#### 27. Write an SQL query to list STUDENT_ID who does not get Scholarship.
SELECT a.* from students as a left join student_scholarships as b on a.student_id=b.STUDENT_REF_ID where b.SCHOLARSHIP_AMOUNT is null;

#### 28. Write an SQL query to fetch the first 50% records from a table.
with cte as (select *,row_number() over() as rn from students)
select * from cte where rn <= (select count(*)/2 from students);

#### 29. Write an SQL query to fetch the MAJOR subject that have less than 4 people in it.
select major,count(*) from students group by 1 having count(*) < 4;

#### 30. Write an SQL query to show all MAJOR subject along with the number of people in there.
select major,count(*) from students group by 1;

#### 31. Write an SQL query to show the last record from a table.
select * from students order by student_id desc limit 1;

#### 32. Write an SQL query to fetch the first row of a table.
select * from students order by student_id  limit 1;

#### 33. Write an SQL query to fetch the last five records from a table.
select * from (select * from students order by student_id desc limit 5) as a order by 1 ;

#### 34. Write an SQL query to fetch three max GPA from a table using co-related subquery.
select gpa from students where gpa <= (select max(gpa) from students) order by gpa desc limit 3;

#### 35. Write an SQL query to fetch three min GPA from a table using co-related subquery.
select gpa from students where gpa >= (select min(gpa) from students) order by gpa  limit 3;

#### 36. Write an SQL query to fetch nth max GPA from a table.
with cte as (select gpa,dense_rank() over(order by gpa desc) as drnk from students)
select * from cte where  drnk= 5;

#### 37. Write an SQL query to fetch MAJOR subjects along with the max GPA in each of these MAJOR subjects
select major,max(gpa) from students group by major order by 1;

#### 38. Write an SQL query to fetch the names of Students who has highest GPA.
select * from students where gpa = (select max(gpa) from students);

#### 39. Write an SQL query to show the current date and time.
select current_date(),current_time();
select current_timestamp();
select now();

#### 40. Write a query to create a new table which consists of data and structure copied from the other table (say Student) or clone the table named Student.
create table students_bkp as (select * from students);

#### 41. Write an SQL query to update the GPA of all the students in ‘Computer Science’ MAJOR subject to 7.5.
update students set gpa = 7.5 where major ='Computer Science';

#### 42. Write an SQL query to find the average GPA for each major.
select major, round(avg(gpa),2) from students group by 1;

#### 43. Write an SQL query to show the top 3 students with the highest GPA.
select student_id from students order by gpa desc limit 3;

#### 44. Write an SQL query to find the number of students in each major who have a GPA greater than 7.5.
select distinct major,count(gpa) from students where gpa > 7.5 group by 1;

#### 45. Write an SQL query to find the students who have the same GPA as ‘Shivansh Mahajan’.
select * from students where gpa = ( select gpa from students where first_nm ='Shivansh') and first_nm <>'Shivansh';










