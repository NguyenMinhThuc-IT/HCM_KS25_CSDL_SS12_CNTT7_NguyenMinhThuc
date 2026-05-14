CREATE DATABASE StudentDB;
USE StudentDB;

-- 1. Bảng Khoa
CREATE TABLE Department (
    DeptID VARCHAR(5) PRIMARY KEY,
    DeptName VARCHAR(50) NOT NULL
);

-- 2. Bảng SinhVien
CREATE TABLE Student (
    StudentID VARCHAR(6) PRIMARY KEY,
    FullName VARCHAR(50),
    Gender VARCHAR(10),
    BirthDate DATE,
    DeptID VARCHAR(5),
    FOREIGN KEY (DeptID) REFERENCES Department(DeptID)
);

-- 3. Bảng MonHoc
CREATE TABLE Course (
    CourseID VARCHAR(6) PRIMARY KEY,
    CourseName VARCHAR(50),
    Credits INT
);

-- 4. Bảng DangKy
CREATE TABLE Enrollment (
    StudentID VARCHAR(6),
    CourseID VARCHAR(6),
    Score DECIMAL(4,2), 
    PRIMARY KEY (StudentID, CourseID),
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);

-- Chèn dữ liệu mẫu
INSERT INTO Department VALUES
('IT','Information Technology'),
('BA','Business Administration'),
('ACC','Accounting');

INSERT INTO Student VALUES
('S00001','Nguyen An','Male','2003-05-10','IT'),
('S00002','Tran Binh','Male','2003-06-15','IT'),
('S00003','Le Hoa','Female','2003-08-20','BA'),
('S00004','Pham Minh','Male','2002-12-12','ACC'),
('S00005','Vo Lan','Female','2003-03-01','IT');

-- Phần A 
-- tạo view cơ bản 
drop view ViewStudentBasic;
create view ViewStudentBasic AS
select s.StudentID, s.FullName, d.DeptName from Student s
join Department d
on s.DeptID = d.DeptID;

select * FROM ViewStudentBasic;

-- Tạo một Regular Index tên là idxFullName cho cột FullName của bảng Student.
create index idxFullName On Student(FullName);

-- Câu 3: Viết Stored Procedure GetStudentsIT (không có tham số).

DELIMITER $$

create Procedure GetStudentsIT ()

begin 
	select s.StudentID, s.FullName , s.Gender , s.BirthDate From Student s
    join Department d 
    on s.DeptID = d.DeptID
    where d.DeptID = 'IT';
	
end$$ 

DELIMITER ;

 call GetStudentsIT ();
 
 -- Tạo View ViewStudentCountByDept hiển thị: DeptName, TotalStudents (số lượng sinh viên của mỗi khoa).


create view ViewStudentCountByDept AS
	select d.DeptName, count(s.DeptID) TotalStudents from Department d
    join Student s 
    on d.DeptID = s.DeptID 
    group by d.DeptName;
    
    
select * from ViewStudentCountByDept;

select * from ViewStudentCountByDept
group by TotalStudents DESC;



