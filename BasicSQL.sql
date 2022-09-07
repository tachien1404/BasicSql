/* I. CREATE TABLES */

-- faculty (Khoa trong tr??ng)
create table faculty (
	id number primary key,
	name nvarchar2(30) not null
);

-- subject (Môn h?c)
create table subject(
	id number primary key,
	name nvarchar2(100) not null,
	lesson_quantity number(2,0) not null -- t?ng s? ti?t h?c
);

-- student (Sinh viên)
create table student (
	id number primary key,
	name nvarchar2(30) not null,
	gender nvarchar2(10) not null, -- gi?i tính
	birthday date not null,
	hometown nvarchar2(100) not null, -- quê quán
	scholarship number, -- h?c b?ng
	faculty_id number not null constraint faculty_id references faculty(id) -- mã khoa
);

-- exam management (B?ng ?i?m)
create table exam_management(
	id number primary key,
	student_id number not null constraint student_id references student(id),
	subject_id number not null constraint subject_id references subject(id),
	number_of_exam_taking number not null, -- s? l?n thi (thi trên 1 l?n ???c g?i là thi l?i) 
	mark number(4,2) not null -- ?i?m
);



/*================================================*/

/* II. INSERT SAMPLE DATA */

-- subject
insert into subject (id, name, lesson_quantity) values (1, n'C? s? d? li?u', 45);
insert into subject values (2, n'Trí tu? nhân t?o', 45);
insert into subject values (3, n'Truy?n tin', 45);
insert into subject values (4, n'?? h?a', 60);
insert into subject values (5, n'V?n ph?m', 45);


-- faculty
insert into faculty values (1, n'Anh - V?n');
insert into faculty values (2, n'Tin h?c');
insert into faculty values (3, n'Tri?t h?c');
insert into faculty values (4, n'V?t lý');


-- student
insert into student values (1, n'Nguy?n Th? H?i', n'N?', to_date('19900223', 'YYYYMMDD'), 'Hà N?i', 130000, 2);
insert into student values (2, n'Tr?n V?n Chính', n'Nam', to_date('19921224', 'YYYYMMDD'), 'Bình ??nh', 150000, 4);
insert into student values (3, n'Lê Thu Y?n', n'N?', to_date('19900221', 'YYYYMMDD'), 'TP HCM', 150000, 2);
insert into student values (4, n'Lê H?i Y?n', n'N?', to_date('19900221', 'YYYYMMDD'), 'TP HCM', 170000, 2);
insert into student values (5, n'Tr?n Anh Tu?n', n'Nam', to_date('19901220', 'YYYYMMDD'), 'Hà N?i', 180000, 1);
insert into student values (6, n'Tr?n Thanh Mai', n'N?', to_date('19910812', 'YYYYMMDD'), 'H?i Phòng', null, 3);
insert into student values (7, n'Tr?n Th? Thu Th?y', n'N?', to_date('19910102', 'YYYYMMDD'), 'H?i Phòng', 10000, 1);


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

-- 1. Li?t kê danh sách sinh viên s?p x?p theo th? t?:
--      a. id t?ng d?n
select * from student
order by id

--      b. gi?i tính
select * from student
order by gender

--      c. ngày sinh T?NG D?N và h?c b?ng GI?M D?N
select * from student
order by birthday asc, scholarship desc

-- 2. Môn h?c có tên b?t ??u b?ng ch? 'T'
select * from subject
where name like 'T%'

-- 3. Sinh viên có ch? cái cu?i cùng trong tên là 'i'
select * from student
where name like '%i'

-- 4. Nh?ng khoa có ký t? th? hai c?a tên khoa có ch?a ch? 'n'
select * from faculty
where name like '_n%'

-- 5. Sinh viên trong tên có t? 'Th?'
select * from student
where name like '%Th?%'

-- 6. Sinh viên có ký t? ??u tiên c?a tên n?m trong kho?ng t? 'a' ??n 'm', s?p x?p theo h? tên sinh viên
select * from student
where name like '[a-m]%'
order by name

-- 7. Sinh viên có h?c b?ng l?n h?n 100000, s?p x?p theo mã khoa gi?m d?n
select * from student
where scholarship >100000
order by faculty_id desc

-- 8. Sinh viên có h?c b?ng t? 150000 tr? lên và sinh ? Hà N?i
select * from student
where scholarship >100000 and hometown like 'Hà N?i'

-- 9. Nh?ng sinh viên có ngày sinh t? ngày 01/01/1991 ??n ngày 05/06/1992
select * from student
where birthday between to_date('01/01/1991','dd/mm/yyyy') and to_date('05/06/1992','dd/mm/yyyy')

-- 10. Nh?ng sinh viên có h?c b?ng t? 80000 ??n 150000
select * from student
where scholarship between 80000 and 150000

-- 11. Nh?ng môn h?c có s? ti?t l?n h?n 30 và nh? h?n 45
select * from subject
where lesson_quantity > 30 and lesson_quantity <45

-------------------------------------------------------------------

/********* B. CALCULATION QUERY *********/

-- 1. Cho bi?t thông tin v? m?c h?c b?ng c?a các sinh viên, g?m: Mã sinh viên, Gi?i tính, Mã 
		-- khoa, M?c h?c b?ng. Trong ?ó, m?c h?c b?ng s? hi?n th? là “H?c b?ng cao” n?u giá tr? 
		-- c?a h?c b?ng l?n h?n 500,000 và ng??c l?i hi?n th? là “M?c trung bình”.
		select id "Mã sinh viên", gender "gi?i tính", faculty_id "mã khoa", scholarship "h?c b?ng", case
                                            when scholarship > 500000 then 'H?c b?ng cao'
                                            else 'M?c trung bình'
                                            end as "M?c h?c b?ng"
       from student
       

-- 2. Tính t?ng s? sinh viên c?a toàn tr??ng
select count(id) "T?ng sinh viên"
from student

-- 3. Tính t?ng s? sinh viên nam và t?ng s? sinh viên n?.
select gender "Gi?i tính", count(id) "T?ng sinh viên"
from student
group by gender

-- 4. Tính t?ng s? sinh viên t?ng khoa
select faculty_id "mã khoa", count(id) "T?ng sinh viên"
from student
group by faculty_id

-- 5. Tính t?ng s? sinh viên c?a t?ng môn h?c
select subject_id "mã môn h?c", count(student_id) "T?ng sinh viên"
from exam_management
group by subject_id

-- 6. Tính s? l??ng môn h?c mà sinh viên ?ã h?c
select student_id "mã sinh viên", count(*) "T?ng s? l??ng môn h?c"
from exam_management
group by student_id

-- 7. T?ng s? h?c b?ng c?a m?i khoa	
select faculty_id  "mã khoa", count(*) "T?ng s? h?c b?ng"
from student
group by faculty_id

-- 8. Cho bi?t h?c b?ng cao nh?t c?a m?i khoa
select faculty_id  "mã khoa", max(scholarship) "H?c b?ng cao nh?t"
from student
group by faculty_id

-- 9. Cho bi?t t?ng s? sinh viên nam và t?ng s? sinh viên n? c?a m?i khoa
select faculty_id  "mã khoa",gender "gi?i tính", count(id) "s? l??ng sv"
from student
group by faculty_id,gender

-- 10. Cho bi?t s? l??ng sinh viên theo t?ng ?? tu?i
select EXTRACT(YEAR from CURRENT_TIMESTAMP)-EXTRACT(YEAR from birthday) "?? tu?i",count(id) "mã sinh viên"
from student
group by EXTRACT(YEAR from CURRENT_TIMESTAMP)-EXTRACT(YEAR from birthday)
-- 11. Cho bi?t nh?ng n?i nào có ít nh?t 2 sinh viên ?ang theo h?c t?i tr??ng
select hometown, count(id) "sl sv"
from student
group by hometown
having count(id) >=2
-- 12. Cho bi?t nh?ng sinh viên thi l?i ít nh?t 2 l?n
select student_id "mã sinh viên",subject_id "mã môn h?c",count(number_of_exam_taking) "s? l?n thi l?i"
from student s JOIN exam_management ex ON s.id = ex.student_id
group by student_id,subject_id
having count(number_of_exam_taking)>=2

-- 13. Cho bi?t nh?ng sinh viên nam có ?i?m trung bình l?n 1 trên 7.0 
select name "h? tên sinh viên",gender "gi?i tính",number_of_exam_taking,avg(mark) "?i?m trung bình"
from student s JOIN exam_management ex ON s.id = ex.student_id
where number_of_exam_taking=1 and gender='Nam'
group by number_of_exam_taking,gender, name
having avg(mark)>7.0

-- 14. Cho bi?t danh sách các sinh viên r?t ít nh?t 2 môn ? l?n thi 1 (r?t môn là ?i?m thi c?a môn không quá 4 ?i?m)
select student_id "Mã sinh viên",count(subject_id) "s? l?n r?t môn"
from exam_management
where number_of_exam_taking = 1 and mark < 4
group by student_id
having count(subject_id)>=2
-- 15. Cho bi?t danh sách nh?ng khoa có nhi?u h?n 2 sinh viên nam
select f.id "mã khoa",f.name "tên khoa",count(s.id) "s? sinh viên nam"
from student s join faculty f on s.faculty_id = f.id
where gender= 'Nam'
group by f.id,f.name
having count(s.id)>=2

-- 16. Cho bi?t nh?ng khoa có 2 sinh viên ??t h?c b?ng t? 200000 ??n 300000
select s.faculty_id "mã khoa",f.name "tên khoa",count(s.id) "s? sinh viên "
from student s join faculty f on s.faculty_id = f.id
where s.scholarship >=100000 and s.scholarship <=300000
group by s.faculty_id,f.name
having count(s.id)>=2

-- 17. Cho bi?t sinh viên nào có h?c b?ng cao nh?t
select *
from student
where scholarship =(select max(scholarship) from student)

-------------------------------------------------------------------

/********* C. DATE/TIME QUERY *********/

-- 1. Sinh viên có n?i sinh ? Hà N?i và sinh vào tháng 02
select * 
from student
where hometown='Hà N?i' and EXTRACT(month FROM birthday)=2

-- 2. Sinh viên có tu?i l?n h?n 20
select * 
from student
where EXTRACT(YEAR from CURRENT_TIMESTAMP)-EXTRACT(YEAR from birthday)>20

-- 3. Sinh viên sinh vào mùa xuân n?m 1990
SELECT * 
FROM student
where  EXTRACT(YEAR from birthday)=1990 and EXTRACT(month from birthday) between 1 and 3


-------------------------------------------------------------------


/********* D. JOIN QUERY *********/

-- 1. Danh sách các sinh viên c?a khoa ANH V?N và khoa V?T LÝ
select f.name,s.id "mã sinh viên", s.name
from faculty f join student s on f.id=s.faculty_id
where f.name like 'Anh - V?n' or f.name like 'V?t lí'

-- 2. Nh?ng sinh viên nam c?a khoa ANH V?N và khoa TIN H?C
select f.name, s.id "mã sinh viên", s.name, s.gender
from faculty f join student s on f.id= s.faculty_id
where ( f.name like 'Anh - V?n' or f.name like 'V?t lý' ) and s.gender = 'Nam';
   
-- 3. Cho bi?t sinh viên nào có ?i?m thi l?n 1 môn c? s? d? li?u cao nh?t
select s.id,s.name,exm.mark
from student s join exam_management exm on s.id = exm.student_id
JOIN subject sb on sb.id = exm.student_id
where exm.number_of_exam_taking = 1 and exm.mark = (
                                        select max(mark)
                                        from exam_management ex
                                        join subject su on su.id = ex.subject_id
                                        where su.name like 'C? s? d? li?u')
                                                
-- 4. Cho bi?t sinh viên khoa anh v?n có tu?i l?n nh?t.
select f.name "tên khoa", s.id "mã sv", s.name
from student s join faculty f on s.faculty_id = f.id
where f.name like 'Anh - V?n'
    and s.birthday = (
    select min(birthday)
    from student
);


-- 5. Cho bi?t khoa nào có ?ông sinh viên nh?t

-- 6. Cho bi?t khoa nào có ?ông n? nh?t

-- 7. Cho bi?t nh?ng sinh viên ??t ?i?m cao nh?t trong t?ng môn

-- 8. Cho bi?t nh?ng khoa không có sinh viên h?c

-- 9. Cho bi?t sinh viên ch?a thi môn c? s? d? li?u

-- 10. Cho bi?t sinh viên nào không thi l?n 1 mà có d? thi l?n 2