USE Lab02;
GO

SELECT DB_NAME() AS current_database;
GO

CREATE TABLE dbo.courses (
    course_id    INT           NOT NULL,
    course_title NVARCHAR(100) NOT NULL,
    credits      INT           NOT NULL,
    CONSTRAINT PK_courses PRIMARY KEY (course_id),
    CONSTRAINT CK_courses_credits
        CHECK (credits BETWEEN 1 AND 4)
);
GO

INSERT INTO dbo.courses (course_id, course_title, credits)
VALUES
    (101, N'Database Systems',  3),
    (102, N'Data Structures',   3),
    (103, N'Operating Systems', 3);
GO

CREATE TABLE dbo.enrollments (
    student_id INT NOT NULL,
    course_id  INT NOT NULL,
    CONSTRAINT PK_enrollments
        PRIMARY KEY (student_id, course_id),
    CONSTRAINT FK_enrollments_students
        FOREIGN KEY (student_id)
        REFERENCES dbo.students (student_id),
    CONSTRAINT FK_enrollments_courses
        FOREIGN KEY (course_id)
        REFERENCES dbo.courses (course_id)
);
GO

INSERT INTO dbo.enrollments (student_id, course_id)
VALUES
    (1001, 101),
    (1001, 102),
    (1002, 101),
    (1003, 102),
    (1005, 101);
GO

SELECT COUNT(*) AS course_count FROM dbo.courses;
SELECT COUNT(*) AS enrollment_count FROM dbo.enrollments;
GO

SELECT s.student_id, s.full_name, c.course_title
FROM dbo.students AS s
INNER JOIN dbo.enrollments AS e
    ON e.student_id = s.student_id
INNER JOIN dbo.courses AS c
    ON c.course_id = e.course_id
ORDER BY s.student_id, c.course_id;
GO

SELECT c.course_id,
       c.course_title,
       COUNT(e.student_id) AS enrollment_count
FROM dbo.courses AS c
LEFT JOIN dbo.enrollments AS e
    ON e.course_id = c.course_id
GROUP BY c.course_id, c.course_title
ORDER BY c.course_id;
GO

SELECT c.course_id,
       c.course_title,
       COUNT(e.student_id) AS enrollment_count
FROM dbo.courses AS c
LEFT JOIN dbo.enrollments AS e
    ON e.course_id = c.course_id
GROUP BY c.course_id, c.course_title
HAVING COUNT(e.student_id) >= 2
ORDER BY c.course_id;
GO

SELECT @@TRANCOUNT AS open_transactions;
GO
