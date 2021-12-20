use quanlysinhvien;
-- Hiển thị danh sách tất cả các học viên
SELECT *
FROM Student;

-- Hiển thị danh sách các học viên đang theo học.
select student
from student
where student.Status = 1;

-- Hiển thị danh sách các môn học có thời gian học nhỏ hơn 10 giờ.
select StartDate
from class
where (datediff(now(),class.StartDate)) * 24 < 10;

-- Hiển thị danh sách học viên lớp A1
SELECT *
from student join class  on student.ClassId = class.ClassID
where class.ClassName = 'a1';
select s.StudentName as 'Tên Học Viên', c.ClassName as 'Lớp', s.Status, c.StartDate as 'Ngày mở lớp'
from student s join class c on s.ClassId = c.ClassID
where c.ClassName = 'a1';

-- Hiển thị điểm môn CF của các học viên.
SELECT S.StudentId, S.StudentName, Sub.SubName, M.Mark
FROM Student S join Mark M on S.StudentId = M.StudentId join Subject Sub on M.SubId = Sub.SubId
WHERE Sub.SubName = 'CF';
