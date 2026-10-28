USE Lab02;
GO

INSERT INTO dbo.enrollments (student_id, course_id)
VALUES (1001, 101);
GO

INSERT INTO dbo.enrollments (student_id, course_id)
VALUES (1002, 999);
GO

SELECT COUNT(*) AS enrollment_count FROM dbo.enrollments;
GO
