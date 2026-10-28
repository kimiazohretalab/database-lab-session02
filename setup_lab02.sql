
USE master;
GO

CREATE DATABASE Lab02;
GO

USE Lab02;
GO

SELECT DB_NAME() AS current_database;
GO

CREATE TABLE dbo.majors (
    major_code  VARCHAR(10)   NOT NULL,
    major_title NVARCHAR(100) NOT NULL,
    faculty     NVARCHAR(100) NOT NULL,
    CONSTRAINT PK_majors PRIMARY KEY (major_code)
);
GO

CREATE TABLE dbo.students (
    student_id INT           NOT NULL,
    full_name  NVARCHAR(100) NOT NULL,
    major      VARCHAR(10)   NOT NULL,
    entry_year INT           NOT NULL,
    gpa        DECIMAL(4,2)  NULL,
    CONSTRAINT PK_students PRIMARY KEY (student_id),
    CONSTRAINT CK_students_gpa
        CHECK (gpa BETWEEN 0 AND 20),
    CONSTRAINT FK_students_majors
        FOREIGN KEY (major)
        REFERENCES dbo.majors (major_code)
);
GO

INSERT INTO dbo.majors (major_code, major_title, faculty)
VALUES
    ('CS', N'Computer Engineering',   N'Engineering'),
    ('EE', N'Electrical Engineering', N'Engineering'),
    ('ME', N'Mechanical Engineering', N'Engineering'),
    ('BI', N'Biology',                N'Science');
GO

INSERT INTO dbo.students (student_id, full_name, major, entry_year, gpa)
VALUES
    (1001, N'Ali Ahmadi',     'CS', 1403, 17.50),
    (1002, N'Sara Karimi',    'EE', 1402, 18.25),
    (1003, N'Reza Mohammadi', 'CS', 1403, 15.75),
    (1004, N'Mina Hosseini',  'ME', 1401, NULL),
    (1005, N'Nima Moradi',    'CS', 1402, 19.00);
GO

SELECT COUNT(*) AS major_count   FROM dbo.majors;
SELECT COUNT(*) AS student_count FROM dbo.students;
GO
