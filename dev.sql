-- define a select statement to get all students enrolled in a course
SELECT s.first_name, s.last_name, s.email, s.phone, s.city, s.state, s.zip_code
FROM courses.students s
JOIN courses.registrations r ON s.student_id = r.student_id  -- Fixed duplicate condition
JOIN courses.locations l ON r.location_id = l.location_id
WHERE r.registration_status = 2 
  AND r.registration_date = '2020-01-01'
ORDER BY r.registration_date;

-- write an index to improve performance of the query
CREATE INDEX idx_reg_status_date_covering ON courses.registrations 
(registration_status, registration_date, student_id, location_id);

-- define a table for student attendance to capture attendance by class
create table courses.attendance (
  attendance_id INT IDENTITY (1, 1) PRIMARY KEY,
  registration_id INT NOT NULL,
  attendance_date DATE NOT NULL,
  attendance_status tinyint NOT NULL,
  -- Attendance status: 1 = Present; 2 = Absent; 3 = Excused; 4 = Late
  FOREIGN KEY (registration_id) REFERENCES courses.registrations (registration_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE PROCEDURE courses.get_enrollment_by_location
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT l.location_name, c.course_name, COUNT(r.registration_id) as enrollment_count
    FROM courses.locations l WITH (NOLOCK)
    JOIN courses.registrations r WITH (NOLOCK) ON l.location_id = r.location_id
    JOIN courses.courses c WITH (NOLOCK) ON r.course_id = c.course_id
    WHERE r.registration_status = 2
    GROUP BY l.location_name, c.course_name
    OPTION (RECOMPILE);
END;

CREATE PROCEDURE courses.get_instructor_details
    @instructor_id INT
AS
BEGIN
    SELECT 
        i.first_name,
        i.last_name,
        i.email,
        i.phone,
        l.location_name,
        l.address,
        l.city,
        l.state,
        l.zip_code,
        c.course_name,
        c.course_description
    FROM courses.instructors i
    JOIN courses.instructor_locations il ON i.instructor_id = il.instructor_id
    JOIN courses.locations l ON il.location_id = l.location_id
    JOIN courses.courses c ON il.course_id = c.course_id
    WHERE i.instructor_id = @instructor_id
    ORDER BY l.location_name, c.course_name;
END;

-- Add better indexing for the instructor details procedure
CREATE INDEX idx_instructor_locations 
ON courses.instructor_locations (instructor_id, location_id, course_id);

-- Rewrite the query using SARGable criteria
SELECT * 
FROM courses.registrations WITH (INDEX(idx_registration_date))
WHERE registration_date >= '2023-09-01' 
  AND registration_date < '2023-10-01';