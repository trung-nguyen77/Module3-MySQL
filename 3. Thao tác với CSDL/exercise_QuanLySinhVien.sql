use quanlysinhvien;

-- Hiển thị tất cả các sinh viên có tên bắt đầu bảng ký tự ‘h’
select s.StudentId, s.StudentName, c.ClassName
from student s join class c on s.classid = c.classid
where s.StudentName like 'h%';

-- Hiển thị các thông tin lớp học có thời gian bắt đầu vào tháng 12.
select quanlysinhvien.c.ClassID, c.ClassName, c.StartDate
from class cstudent
where MONTH(c.StartDate) = 12;

-- Hiển thị tất cả các thông tin môn học có credit trong khoảng từ 3-5.
select *
from subject s
where s.credit between 3 and 5
GROUP BY SubName;

-- Thay đổi mã lớp(ClassID) của sinh viên có tên ‘Hung’ là 2.
update student s set s.classID = 2 Where s.studentID = 1;

-- Hiển thị các thông tin: StudentName, SubName, Mark. 
-- Dữ liệu sắp xếp theo điểm thi (mark) giảm dần. nếu trùng sắp theo tên tăng dần.
SELECT s.StudentName, subject.SubName, m.Mark
FROM mark m JOIN student s on s.StudentID = m.StudentID
			JOIN subject on subject.SubID = m.SubID
ORDER BY Mark DESC, StudentName ASC;
