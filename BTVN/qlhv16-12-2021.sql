create database QLHV;
use qlhv;
create table test(
	testID int primary key,
    Name varchar(50)
);
create table student(
	RN int primary key,
    Name varchar(50),
    age int,
    status bit
);
create table studenttest(
	RN int,
	testID int,
    date datetime,
    mark int,
    primary key(RN, testID),
	Foreign key (RN) references student(RN),
	Foreign key (testID) references test(testID)
);
insert into student(RN, Name, age)
values (1, 'Nguyen Hong Ha' , 20),
	   (2, 'Truong Ngoc Anh', 30),
       (3, 'Tuan Minh'      , 25),
       (4, 'Dan Truong'     , 22);
insert into test(testID, Name)
values (1, 'EPC'),
	   (2, 'DWMX'),
	   (3, 'SQL1'),
	   (4, 'SQL2');
       
insert into studenttest
values (1 ,1 ,7/17/2006 ,8),
       (1 ,2 ,7/18/2006 ,5),
       (1 ,3 ,7/19/2006 ,7),
       (2 ,1 ,7/17/2006 ,7),
       (2 ,2 ,7/18/2006 ,4),
       (2 ,3 ,7/19/2006 ,2),
       (3 ,1 ,7/17/2006 ,10),
       (3 ,3 ,7/18/2006 ,1);  
       
-- 2.Hiển thị danh sách các học viên đã tham gia thi, 
-- các môn thi được thi bởi các học viên đó, điểm thi và ngày thi giống như hình V
select s.name as 'Student Name', t.name as 'Test Name', st.mark as 'Mark', st.date as 'Date'
from studenttest st  join test t on st.testID = t.testID
					join student s on st.RN = s.RN;
                    
-- 3.Hiển thị danh sách các bạn học viên chưa thi môn nào X
select s.RN, s.Name, s.age
from student s join studenttest st on s.RN = st.RN
			   join test t on st.testID = t.testID
where t.Name = 'null';

-- 4.Hiển thị danh sách học viên phải thi lại, tên môn học phải thi lại và điểm thi X
-- (điểm phải thi lại là điểm nhỏ hơn 5) V
select s.Name, t.Name, st.mark, st.date
from studenttest st join student s on st.RN = s.RN
					join test t on st.testID = t.testID
where st.mark < 5;   

-- 5.Hiển thị danh sách học viên và điểm trung bình(Average) của các môn đã thi. 
-- Danh sách phải sắp xếp theo thứ tự điểm trung bình giảm dần V
select student.name, avg(mark) as avgt
from studenttest join student on studenttest.RN = student.RN
group by student.name
order by avgt desc;

-- 6.Hiển thị tên và điểm trung bình của học viên có điểm trung bình lớn nhất X
create view avgMax
as
select student.name, avg(mark) as avgt
from studenttest join student on studenttest.RN = student.RN
group by student.name;
select student.name, avg(mark) as avgt
from studenttest join student on studenttest.RN = student.RN
group by student.name
having avgt = (select max(avgt)
			   from avg);
               
-- 7.Hiển thị điểm thi cao nhất của từng môn học. Danh sách phải được sắp xếp theo tên môn học V
select test.name as 'Test Name', max(mark) as 'Max Mark'
from studenttest join test on studenttest.testID = test.testID
group by test.name
order by test.name;

-- 8.Hiển thị danh sách tất cả các học viên và môn học mà các học viên đó đã thi 
-- nếu học viên chưa thi môn nào thì phần tên môn học để Null V
select s.Name as 'Student Name', t.Name as 'Test Name'
from studenttest st join test t on st.testID = t.testID
					right join student s on st.RN = s.RN;
                    
-- 9.Sửa (Update) tuổi của tất cả các học viên mỗi người lên một tuổi. V                   
update student
set age = age + 1 
where RN > 0;          

-- 10.Thêm trường tên là Status có kiểu Varchar(10) vào bảng Student. V?
alter table student
change status status varchar(10);

-- 11.Cập nhật(Update) trường Status sao cho những học viên nhỏ hơn 30 tuổi sẽ nhận giá trị ‘Young’, 
-- trường hợp còn lại nhận giá trị ‘Old’ sau đó hiển thị toàn bộ nội dung bảng Student V
update student
set status = (case when age > 30 then 'Old' else 'Young' end)
where RN > 0;       

-- 12.Tạo view tên là vwStudentTestList hiển thị danh sách học viên và điểm thi, 
-- danh sách phải sắp xếp tăng dần theo ngày thi X
create view vwStudentTestList
as
select s.Name as 'Student Name', t.Name as 'Test Name', mark, st.date as 'Date'
from studenttest st join student s on st.RN = s.RN
					join test t on st.testID = t.testID
order by date;
select *
from vwStudentTestList;

-- 13.Tạo một trigger tên là tgSetStatus sao cho khi sửa tuổi của học viên thì trigger này 
-- sẽ tự động cập nhật status theo quy tắc sau:
-- Nếu tuổi nhỏ hơn 30 thì Status=’Young’
-- Nếu tuổi lớn hơn hoặc bằng 30 thì Status=’Old’ 
DELIMITER $$
CREATE TRIGGER tgSetStatus 
 before UPDATE on student
 FOR EACH ROW
BEGIN
	if (new.age < 30)
    then
		set new.status = 'Young';
	else
		set new.status = 'old';
    end if;
END$$

-- 14.Tạo một stored procedure tên là spViewStatus, stored procedure này nhận vào 2 tham số:
-- Tham số thứ nhất là tên học viên					
-- Tham số thứ 2 là tên môn học
-- Nếu tên học viên hoặc tên môn học không tìm thây trong cơ sở dữ liệu thì hiện ra màn hình thông báo: ‘Khong tim thay’
-- Trường hợp còn lại thi hiển thị trạng thái của học viên đó với môn học đó theo quy tắc sau:
-- Hiển thị ‘Chua thi’ nếu học viên đó chưa thi môn đó
-- Hiển thị ‘Do’ nếu đã thi rồi và điểm lơn hơn hoặc bằng 5
-- Hiển thị ‘Trượt’ nếu đã thi rồi và điểm thi nhỏ hơn 5 X
DELIMITER $$
CREATE procedure spViewStatus(StudentName varchar(50),TestName varchar(50))
BEGIN
	select student.name, test.name, 
    (case when mark > 5 then 'qua môn' when mark < 5 then 'trượt' else 'chưa thi' end) as 'học lực'
    from studenttest join test on studenttest.testID = test.testID
				right join student on studenttest.RN = student.RN
	where (student.name = StudentName and test.name = TestName) or student.name = StudentName;
END$$
call spViewStatus('Toàn', 'Toán');
call spViewStatus('Lan', 'Toán');
call spViewStatus('Nam', 'Toán');

