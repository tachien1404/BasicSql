/* I. CREATE TABLES */

-- faculty (Khoa trong trường)
create table faculty (
	id number primary key,
	name nvarchar2(30) not null
);

-- subject (Môn học)
create table subject(
	id number primary key,
	name nvarchar2(100) not null,
	lesson_quantity number(2,0) not null -- tổng số tiết học
);

-- student (Sinh viên)
create table student (
	id number primary key,
	name nvarchar2(30) not null,
	gender nvarchar2(10) not null, -- giới tính
	birthday date not null,
	hometown nvarchar2(100) not null, -- quê quán
	scholarship number, -- học bổng
	faculty_id number not null constraint faculty_id references faculty(id) -- mã khoa
);

-- exam management (Bảng điểm)
create table exam_management(
	id number primary key,
	student_id number not null constraint student_id references student(id),
	subject_id number not null constraint subject_id references subject(id),
	number_of_exam_taking number not null, -- số lần thi (thi trên 1 lần được gọi là thi lại) 
	mark number(4,2) not null -- điểm
);



/*================================================*/

/* II. INSERT SAMPLE DATA */

-- subject
insert into subject (id, name, lesson_quantity) values (1, n'Cơ sở dữ liệu', 45);
insert into subject values (2, n'Trí tuệ nhân tạo', 45);
insert into subject values (3, n'Truyền tin', 45);
insert into subject values (4, n'Đồ họa', 60);
insert into subject values (5, n'Văn phạm', 45);


-- faculty
insert into faculty values (1, n'Anh - Văn');
insert into faculty values (2, n'Tin học');
insert into faculty values (3, n'Triết học');
insert into faculty values (4, n'Vật lý');


-- student
insert into student values (1, n'Nguyễn Thị Hải', n'Nữ', to_date('19900223', 'YYYYMMDD'), 'Hà Nội', 130000, 2);
insert into student values (2, n'Trần Văn Chính', n'Nam', to_date('19921224', 'YYYYMMDD'), 'Bình Định', 150000, 4);
insert into student values (3, n'Lê Thu Yến', n'Nữ', to_date('19900221', 'YYYYMMDD'), 'TP HCM', 150000, 2);
insert into student values (4, n'Lê Hải Yến', n'Nữ', to_date('19900221', 'YYYYMMDD'), 'TP HCM', 170000, 2);
insert into student values (5, n'Trần Anh Tuấn', n'Nam', to_date('19901220', 'YYYYMMDD'), 'Hà Nội', 180000, 1);
insert into student values (6, n'Trần Thanh Mai', n'Nữ', to_date('19910812', 'YYYYMMDD'), 'Hải Phòng', null, 3);
insert into student values (7, n'Trần Thị Thu Thủy', n'Nữ', to_date('19910102', 'YYYYMMDD'), 'Hải Phòng', 10000, 1);


-- exam_management
insert into exam_management values (1, 1, 1, 1, 3);
insert into exam_management values (2, 1, 1, 2, 6);
insert into exam_management values (3, 1, 2, 2, 6);
insert into exam_management values (4, 1, 3, 1, 5);
insert into exam_management values (5, 2, 1, 1, 4.5);
insert into exam_management values (6, 2, 1, 2, 7);
insert into exam_management values (7, 2, 3, 1, 10);
insert into exam_management values (8, 2, 5, 1, 9);
insert into exam_management values (9, 3, 1, 1, 2);
insert into exam_management values (10, 3, 1, 2, 5);
insert into exam_management values (11, 3, 3, 1, 2.5);
insert into exam_management values (12, 3, 3, 2, 4);
insert into exam_management values (13, 4, 5, 2, 10);
insert into exam_management values (14, 5, 1, 1, 7);
insert into exam_management values (15, 5, 3, 1, 2.5);
insert into exam_management values (16, 5, 3, 2, 5);
insert into exam_management values (17, 6, 2, 1, 6);
insert into exam_management values (18, 6, 4, 1, 10);



/*================================================*/

/* III. QUERY */


 /********* A. BASIC QUERY *********/

-- 1. Liệt kê danh sách sinh viên sắp xếp theo thứ tự:
--      a. id tăng dần
select * from student
order by id

--      b. giới tính
select * from student
order by gender

--      c. ngày sinh TĂNG DẦN và học bổng GIẢM DẦN
select * from student
order by birthday asc, scholarship desc

-- 2. Môn học có tên bắt đầu bằng chữ 'T'
select * from subject
where name like 'T%'

-- 3. Sinh viên có chữ cái cuối cùng trong tên là 'i'
select * from student
where name like '%i'

-- 4. Những khoa có ký tự thứ hai của tên khoa có chứa chữ 'n'
select * from faculty
where name like '_n%'

-- 5. Sinh viên trong tên có từ 'Thị'
select * from student
where name like '%Th?%'

-- 6. Sinh viên có ký tự đầu tiên của tên nằm trong khoảng từ 'a' đến 'm', sắp xếp theo họ tên sinh viên
select * from student
where name like '[a-m]%'
order by name

-- 7. Sinh viên có học bổng lớn hơn 100000, sắp xếp theo mã khoa giảm dần
select * from student
where scholarship >100000
order by faculty_id desc

-- 8. Sinh viên có học bổng từ 150000 trở lên và sinh ở Hà Nội
select * from student
where scholarship >100000 and hometown like 'Hà N?i'

-- 9. Những sinh viên có ngày sinh từ ngày 01/01/1991 đến ngày 05/06/1992
select * from student
where birthday between to_date('01/01/1991','dd/mm/yyyy') and to_date('05/06/1992','dd/mm/yyyy')

-- 10. Những sinh viên có học bổng từ 80000 đến 150000
select * from student
where scholarship between 80000 and 150000

-- 11. Những môn học có số tiết lớn hơn 30 và nhỏ hơn 45
select * from subject
where lesson_quantity > 30 and lesson_quantity <45

-------------------------------------------------------------------

/********* B. CALCULATION QUERY *********/

-- 1. Cho biết thông tin về mức học bổng của các sinh viên, gồm: Mã sinh viên, Giới tính, Mã 
		-- khoa, Mức học bổng. Trong đó, mức học bổng sẽ hiển thị là “Học bổng cao” nếu giá trị 
		-- của học bổng lớn hơn 500,000 và ngược lại hiển thị là “Mức trung bình”.
		select id "Mã sinh viên", gender "giới tính", faculty_id "mã khoa", scholarship "học bổng", case
                                            when scholarship > 500000 then 'Học bổng cao'
                                            else 'Mức trung bình'
                                            end as "Mức học bổng"
       from student
       

-- 2. Tính tổng số sinh viên của toàn trường
select count(id) "Tổng sinh viên"
from student

-- 3. Tính tổng số sinh viên nam và tổng số sinh viên nữ.
select gender "Giới tính", count(id) "Tổng sinh viên"
from student
group by gender

-- 4. Tính tổng số sinh viên từng khoa
select faculty_id "mã khoa", count(id) "Tổng sinh viên"
from student
group by faculty_id

-- 5. Tính tổng số sinh viên của từng môn học
select subject_id "mã môn học", count(student_id) "Tổng sinh viên"
from exam_management
group by subject_id

-- 6. Tính số lượng môn học mà sinh viên đã học
select student_id "mã sinh viên", count(*) "số lượng môn học"
from exam_management
group by student_id

-- 7. Tổng số học bổng của mỗi khoa	
select faculty_id  "mã khoa", count(*) "Tổng số học bổng"
from student
group by faculty_id

-- 8. Cho biết học bổng cao nhất của mỗi khoa
select faculty_id  "mã khoa", max(scholarship) "học bổng cao nhất"
from student
group by faculty_id

-- 9. Cho biết tổng số sinh viên nam và tổng số sinh viên nữ của mỗi khoa
select faculty_id  "mã khoa",gender "giới tính", count(id) "slsv"
from student
group by faculty_id,gender

-- 10. Cho biết số lượng sinh viên theo từng độ tuổi
select EXTRACT(YEAR from CURRENT_TIMESTAMP)-EXTRACT(YEAR from birthday) "độ tuổi",count(id) "mã sinh viên"
from student
group by EXTRACT(YEAR from CURRENT_TIMESTAMP)-EXTRACT(YEAR from birthday)
-- 11. Cho biết những nơi nào có ít nhất 2 sinh viên đang theo học tại trường
select hometown, count(id) "sl sv"
from student
group by hometown
having count(id) >=2
-- 12. Cho biết những sinh viên thi lại ít nhất 2 lần
select student_id "mã sinh viên",subject_id "mã môn học",count(number_of_exam_taking) "số lần thi lại"
from student s JOIN exam_management ex ON s.id = ex.student_id
group by student_id,subject_id
having count(number_of_exam_taking)>=2

-- 13. Cho biết những sinh viên nam có điểm trung bình lần 1 trên 7.0 
select name "họ tên sinh viên",gender "giới tính",number_of_exam_taking,avg(mark) "điểm trung bình"
from student s JOIN exam_management ex on s.id = ex.student_id
where number_of_exam_taking=1 and gender='Nam'
group by number_of_exam_taking,gender, name
having avg(mark)>7.0

-- 14. Cho biết danh sách các sinh viên rớt ít nhất 2 môn ở lần thi 1 (rớt môn là điểm thi của môn không quá 4 điểm)
select student_id "Mã sinh viên",count(subject_id) "số lần rớt môn"
from exam_management
where number_of_exam_taking = 1 and mark < 4
group by student_id
having count(subject_id)>=2
-- 15. Cho biết danh sách những khoa có nhiều hơn 2 sinh viên nam
select f.id "mã khoa",f.name "tên khoa",count(s.id) "số sinh viên nam"
from student s join faculty f on s.faculty_id = f.id
where gender= 'Nam'
group by f.id,f.name
having count(s.id)>=2

-- 16. Cho biết những khoa có 2 sinh viên đạt học bổng từ 200000 đến 300000
select s.faculty_id "mã khoa",f.name "tên khoa",count(s.id) "số sinh viên "
from student s join faculty f on s.faculty_id = f.id
where s.scholarship >=100000 and s.scholarship <=300000
group by s.faculty_id,f.name
having count(s.id)>=2

-- 17. Cho biết sinh viên nào có học bổng cao nhất
select *
from student
where scholarship =(select max(scholarship) from student)

-------------------------------------------------------------------

/********* C. DATE/TIME QUERY *********/


-- 1. Sinh viên có nơi sinh ở Hà Nội và sinh vào tháng 02
select * 
from student
where hometown='Hà Nội' and EXTRACT(month FROM birthday)=2

-- 2. Sinh viên có tuổi lớn hơn 20
select * 
from student
where EXTRACT(YEAR from CURRENT_TIMESTAMP)-EXTRACT(YEAR from birthday)>20

-- 3. Sinh viên sinh vào mùa xuân năm 1990
SELECT * 
FROM student
where  EXTRACT(YEAR from birthday)=1990 and EXTRACT(month from birthday) between 1 and 3


-------------------------------------------------------------------


/********* D. JOIN QUERY *********/

-- 1. Danh sách các sinh viên của khoa ANH VĂN và khoa VẬT LÝ
select f.name,s.id "mã sinh viên", s.name
from faculty f join student s on f.id=s.faculty_id
where f.name like 'Anh - Văn' or f.name like 'Vật lí'

-- 2. Những sinh viên nam của khoa ANH VĂN và khoa TIN HỌC
select f.name, s.id "mã sinh viên", s.name, s.gender
from faculty f join student s on f.id= s.faculty_id
where ( f.name like 'Anh - Văn' or f.name like 'Vật lý' ) and s.gender = 'Nam';
   
-- 3. Cho biết sinh viên nào có điểm thi lần 1 môn cơ sở dữ liệu cao nhất
select s.id,s.name,exm.mark
from student s join exam_management exm on s.id = exm.student_id
join subject sb on sb.id = exm.student_id
where exm.number_of_exam_taking = 1 and exm.mark = (
                                        select max(mark)
                                        from exam_management ex
                                        join subject su on su.id = ex.subject_id
                                        where su.name like 'Cơ sở dữ liệu')
                                                
-- 4. Cho biết sinh viên khoa anh văn có tuổi lớn nhất.
select f.name "tên khoa", s.id "mã sv", s.name
from student s join faculty f on s.faculty_id = f.id
where f.name like 'Anh - Văn'
    and s.birthday in (
    select min(birthday)
    from student
);


-- 5. Cho biết khoa nào có đông sinh viên nhất
select f.name, count(s.id) "số lượng sv"
from student s join faculty f on s.faculty_id = f.id
group by f.name 
having count(f.name) >= all(
            select count(id)
            from student
            group by faculty_id)

-- 6. Cho biết khoa nào có đông nữ nhất
select f.name, count(s.id) "slg sv nữ"
from student s join faculty f on s.faculty_id = f.id
group by f.name 
having count(f.name) >= all(
            select count(id)
            from student
            where gender ='Nữ'
            group by faculty_id)
-- 7. Cho biết những sinh viên đạt điểm cao nhất trong từng môn
select student_id "mã sinh viên",exam_management.subject_id "mã môn học",mark "điểm"
from exam_management, (select subject_id, max(mark) as maxdiem
from exam_management
group by subject_id)a
where exam_management.subject_id=a.subject_id and mark=a.maxdiem
-- 8. Cho biết những khoa không có sinh viên học
select f.name, count(s.id)
from faculty f join student s on s.faculty_id = f.id
group by f.name
having count(s.id) = 0

-- 9. Cho biết sinh viên chưa thi môn cơ sở dữ liệu
select *
from student
where not exists
(select distinct*
from exam_management
where subject_id = '1' and student_id = student.id)
-- 10. Cho biết sinh viên nào không thi lần 1 mà có dự thi lần 2
select student_id "mã sinh viên nào không thi lần 1 mà có dự thi lần 2 "
from exam_management exm
where number_of_exam_taking=2 and not exists
(select*
from exam_management
where number_of_exam_taking=1 and student_id=exm.student_id)

