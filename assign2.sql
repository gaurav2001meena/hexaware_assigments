CREATE database SISDB;
use SISDB;

CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    date_of_birth DATE,
    email VARCHAR(255),
    phone_number VARCHAR(20)
);

CREATE TABLE Teacher (
    teacher_id INT PRIMARY KEY,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    email VARCHAR(255)
);

CREATE TABLE Courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(255),
    credits INT,
    teacher_id INT,
    FOREIGN KEY (teacher_id) REFERENCES Teacher(teacher_id)
);

CREATE TABLE Enrollments (
    enrollment_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    enrollment_date DATE,
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);
CREATE TABLE Payments (
    payment_id INT PRIMARY KEY,
    student_id INT,
    amount DECIMAL(10, 2),
    payment_date DATE,
    FOREIGN KEY (student_id) REFERENCES Students(student_id)
);

INSERT INTO Students VALUES
    (1, 'Gaurav', 'Meena', '2001-09-01', 'gaurav.meena@example.com', '8306618299'),
    (2, 'Jane', 'Smith', '1992-08-21', 'jane.smith@example.com', '9876543210'),
	(3, 'Alice', 'Johnson', '1991-11-10', 'alice.johnson@example.com', '5551237890'),
    (4, 'Bob', 'Williams', '1993-04-25', 'bob.williams@example.com', '1112223333'),
    (5, 'Eva', 'Brown', '1994-09-15', 'eva.brown@example.com', '4445556666'),
    (6, 'Michael', 'Taylor', '1990-07-03', 'michael.taylor@example.com', '7778889999'),
    (7, 'Sophia', 'Anderson', '1992-12-18', 'sophia.anderson@example.com', '3336669999'),
    (8, 'Matthew', 'Miller', '1995-02-28', 'matthew.miller@example.com', '1237894567'),
    (9, 'Olivia', 'Clark', '1993-06-08', 'olivia.clark@example.com', '9876543210'),
    (10, 'Daniel', 'White', '1991-03-20', 'daniel.white@example.com', '5557778888');

INSERT INTO Teacher (teacher_id, first_name, last_name, email)
VALUES
    (1, 'Professor', 'Johnson', 'prof.johnson@example.com'),
    (2, 'Dr.', 'Smith', 'dr.smith@example.com'),
	(3, 'Dr.', 'Brown', 'dr.brown@example.com'),
    (4, 'Professor', 'Davis', 'prof.davis@example.com'),
    (5, 'Dr.', 'Wilson', 'dr.wilson@example.com'),
    (6, 'Professor', 'Jones', 'prof.jones@example.com'),
    (7, 'Dr.', 'Moore', 'dr.moore@example.com'),
    (8, 'Professor', 'Lee', 'prof.lee@example.com'),
    (9, 'Dr.', 'Smithson', 'dr.smithson@example.com'),
    (10, 'Professor', 'Johnson', 'prof.johnson@example.com');


INSERT INTO Courses (course_id, course_name, credits, teacher_id)
VALUES
    (101, 'Mathematics', 3, 1),
    (102, 'History', 4, 2),
	(103, 'Physics', 3, 3),
    (104, 'Computer Science', 4, 4),
    (105, 'English Literature', 3, 1),
    (106, 'Chemistry', 4, 2),
    (107, 'Art History', 3, 3),
    (108, 'Political Science', 4, 4),
    (109, 'Economics', 3, 1),
    (110, 'Biology', 4, 2);


INSERT INTO Payments (payment_id, student_id, amount, payment_date)
VALUES
    (1, 1, 500.00, '2023-03-01'),
    (2, 2, 750.50, '2023-03-05'),
	(3, 3, 600.75, '2023-04-01'),
    (4, 4, 450.50, '2023-05-05'),
    (5, 5, 700.00, '2023-06-10'),
    (6, 6, 550.25, '2023-07-15'),
    (7, 7, 800.50, '2023-08-20'),
    (8, 8, 950.75, '2023-09-25'),
    (9, 9, 500.00, '2023-10-30'),
    (10, 10, 750.25, '2023-11-01');

INSERT INTO Students values
(11, 'John', 'Doe', '1995-08-15', 'john.doe@example.com', '1234567890');

INSERT INTO Enrollments (enrollment_id, student_id, course_id, enrollment_date)
VALUES (11, 1, 101, '2023-12-07');

UPDATE Teacher
SET email = 'new.email@example.com'
WHERE teacher_id = 3;

DELETE FROM Enrollments
WHERE student_id = 1 AND course_id = 101;

UPDATE Courses
SET teacher_id = 4
WHERE course_id = 104;

DELETE FROM Payments WHERE student_id = 1;

DELETE FROM Enrollments
WHERE student_id = 1;

DELETE FROM Students
WHERE student_id = 1;

UPDATE Payments
SET amount = 1200.00  
WHERE payment_id = 2;

SELECT
    s.student_id,
    s.first_name,
    s.last_name,
    SUM(p.amount) AS total_payments
FROM
    Students s
JOIN
    Payments p ON s.student_id = p.student_id
WHERE
    s.student_id = 2
GROUP BY
    s.student_id, s.first_name, s.last_name;

SELECT
    c.course_name,
    COUNT(e.student_id) AS enrolled_students_count
FROM
    Courses c
LEFT JOIN
    Enrollments e ON c.course_id = e.course_id
GROUP BY
     c.course_name;

SELECT
    s.student_id,
    s.first_name,
    s.last_name
FROM
    Students s
LEFT JOIN
    Enrollments e ON s.student_id = e.student_id
WHERE
    e.student_id IS NULL;

SELECT
    s.first_name,
    s.last_name,
    c.course_name
FROM
    Students s
JOIN
    Enrollments e ON s.student_id = e.student_id
JOIN
    Courses c ON e.course_id = c.course_id;

SELECT
    t.first_name AS teacher_first_name,
    t.last_name AS teacher_last_name,
    c.course_name
FROM
    Teacher t
JOIN
    Courses c ON t.teacher_id = c.teacher_id;

SELECT
    s.first_name,
    s.last_name,
    e.enrollment_date
FROM
    Students s
JOIN
    Enrollments e ON s.student_id = e.student_id
JOIN
    Courses c ON e.course_id = c.course_id
WHERE
    c.course_name = 'History';

SELECT
    s.first_name,
    s.last_name
FROM
    Students s
LEFT JOIN
    Payments p ON s.student_id = p.student_id
WHERE
    p.student_id IS NULL;

SELECT
    c.course_id,
    c.course_name
FROM
    Courses c
LEFT JOIN
    Enrollments e ON c.course_id = e.course_id
WHERE
    e.course_id IS NULL;

SELECT
    e1.student_id,
    s.first_name,
    s.last_name,
    COUNT(e1.course_id) AS enrollments_count
FROM
    Enrollments e1
JOIN
    Students s ON e1.student_id = s.student_id
GROUP BY
    e1.student_id, s.first_name, s.last_name
HAVING
    COUNT(e1.course_id) > 1;

SELECT
    t.teacher_id,
    t.first_name,
    t.last_name
FROM
    Teacher t
LEFT JOIN
    Courses c ON t.teacher_id = c.teacher_id
WHERE
    c.course_id IS NULL;


SELECT
    AVG(enrollment_count) AS average_students_per_course
FROM (
    SELECT
        course_id,
        COUNT(student_id) AS enrollment_count
    FROM
        Enrollments
    GROUP BY
        course_id
) AS course_enrollment_counts;

SELECT
    s.student_id,
    s.first_name,
    s.last_name,
    p.amount AS highest_payment_amount
FROM Students s JOIN Payments p ON s.student_id = p.student_id
WHERE p.amount = (SELECT MAX(amount) FROM Payments);

SELECT
    t.teacher_id,
    t.first_name AS teacher_first_name,
    t.last_name AS teacher_last_name,
    SUM(p.amount) AS total_payments
FROM Teacher t
JOIN
    Courses c ON t.teacher_id = c.teacher_id
LEFT JOIN
    Enrollments e ON c.course_id = e.course_id
LEFT JOIN
    Payments p ON e.student_id = p.student_id
GROUP BY
    t.teacher_id, t.first_name, t.last_name;

SELECT
    student_id,
    first_name,
    last_name
FROM
    Students
WHERE
    (SELECT COUNT(DISTINCT course_id) FROM Courses) = 
    (SELECT COUNT(DISTINCT course_id) FROM Enrollments WHERE Students.student_id = Enrollments.student_id);


SELECT
    teacher_id,
    first_name,
    last_name
FROM
    Teacher
WHERE
    teacher_id NOT IN (SELECT DISTINCT teacher_id FROM Courses);

SELECT
    AVG(age) AS average_age
FROM (
    SELECT
        student_id,
        DATEDIFF(YEAR, date_of_birth, GETDATE()) AS age
    FROM
        Students
) AS student_age;

SELECT
    course_id,
    course_name
FROM
    Courses
WHERE
    course_id NOT IN (SELECT DISTINCT course_id FROM Enrollments);

SELECT e.student_id, s.first_name, s.last_name, e.course_id, c.course_name, SUM(p.amount) AS total_payments
FROM Enrollments e
JOIN Students s ON e.student_id = s.student_id
JOIN Courses c ON e.course_id = c.course_id
LEFT JOIN Payments p ON e.student_id = p.student_id
GROUP BY e.student_id, s.first_name, s.last_name, e.course_id, c.course_name;



SELECT
    p.student_id,
    s.first_name,
    s.last_name
FROM
    Payments p
JOIN
    Students s ON p.student_id = s.student_id
GROUP BY
    p.student_id, s.first_name, s.last_name
HAVING
    COUNT(p.payment_id) > 1;

SELECT
    s.student_id,
    s.first_name,
    s.last_name,
    SUM(p.amount) AS total_payments
FROM
    Students s
LEFT JOIN
    Payments p ON s.student_id = p.student_id
GROUP BY
    s.student_id, s.first_name, s.last_name;

SELECT
    AVG(p.amount) AS average_payment_amount
FROM
    Students s
JOIN
    Payments p ON s.student_id = p.student_id;



