USE quan_ly_sinh_vien;

 -- Hiển thị tất cả các thông tin môn học (bảng subject) có credit lớn nhất.
 SELECT 
    *
FROM
    subject
WHERE
    credit IN (SELECT 
            MAX(credit)
        FROM
            subject);
 
 -- Hiển thị các thông tin môn học có điểm thi lớn nhất.
SELECT 
    subject.sub_id, sub_name, credit, status
FROM
    subject
        JOIN
    mark ON subject.sub_id = mark.sub_id
WHERE
    mark IN (SELECT 
            MAX(mark)
        FROM
            mark);
            
	-- Hiển thị các thông tin sinh viên và điểm trung bình của mỗi sinh viên, xếp hạng theo thứ tự điểm giảm dần
    SELECT 
    s.student_id, s.student_name, AVG(mark) AS trung_binh
FROM
    student s
        LEFT JOIN
    mark m ON s.student_id = m.student_id
GROUP BY s.student_id , s.student_name
ORDER BY trung_binh DESC;






