select name, dept_name
from instructor


select name
from instructor
where salary>70000

SELECT name, tot_cred
FROM student
WHERE dept_name = "Comp. Sci.";

SELECT name, salary
from instructor
WHERE dept_name = 'Finance' AND salary>80000


SELECT name
from instructor
WHERE dept_name != 'Comp. Sci' 

SELECT instructor.name, instructor.dept_name, department.budget
FROM instructor, department
WHERE instructor.dept_name = department.dept_name;

select student.name,takes.course_id
from student
join takes
on student.ID=takes.ID

select i.name
from instructor as i
join teaches as t
on i.ID=t.ID
join section as s
on t.year=s.year
AND t.course_id = s.course_id
AND t.sec_id = s.sec_id
AND t.semester = s.semester
WHERE s.building='Taylor'

SELECT c.title, p.title
FROM prereq pr
JOIN course c ON c.course_id=pr.course_id
JOIN course p ON pr.prereq_id=p.course_id

select ProductName,Unit,Price
FROM product


SELECT CategoryID, CategoryName
FROM Category
WHERE Description LIKE '%Soft drinks%';

SELECT ProductName,Price
FROM product
WHERE SupplierID=1 AND Price>18



SELECT FirstName, LastName, City
FROM Employee
WHERE Title = 'Sales Rep';


SELECT CompanyName, Country
FROM Customer
WHERE Country <> 'UK';

SELECT CompanyName
from customer
where Country='Germany' OR Country='Mexico'



SELECT OrderID,CustomerID
from orders
WHERE OrderDate > '2025-07-05'


select p.ProductName,c.CategoryName
from product as p
join category as c
on p.CategoryID=c.CategoryID

select p.ProductName,s.City
from product as p
join supplier as s
on p.SupplierID=s.SupplierID

select o.OrderID,e.LastName
from orders as o 
join employee as e
on o.EmployeeID=e.EmployeeID


select p.ProductName,c.CategoryName
from product as p
join category as c
on p.CategoryID=c.CategoryID
WHERE c.CategoryName !='Seafood'


select name
from instructor
where name  LIKE '%an%'

select ID, course_id
from takes
where grade is null

SELECT dept_name, COUNT(*) 
FROM instructor
GROUP BY dept_name;


SELECT dept_name, AVG(salary) AS avg_salary
FROM instructor
GROUP BY dept_name;


select dept_name
from instructor
GROUP BY dept_name
HAVING  AVG(salary)>70000

SELECT course_id
FROM section
WHERE semester='Fall' AND year='2024'

INTERSECT

SELECT course_id
FROM section
WHERE semester='Spring' AND year='2025'

SELECT course_id
FROM section
WHERE semester='Fall' AND year='2024'

EXCEPT

SELECT course_id
FROM section
WHERE semester='Spring' AND year='2025'




SELECT name
FROM instructor

UNION

SELECT name
FROM student


SELECT name
FROM instructor
WHERE salary >(
    SELECT AVG(salary) as avg_salary
    FROM instructor
    )

SELECT name 
FROM instructor 
WHERE salary > ANY (
    SELECT salary 
    FROM instructor 
    WHERE dept_name = 'Biology'
);


SELECT name
FROM student
WHERE ID IN (
    SELECT ID
    FROM takes
    WHERE course_id = 'CS-101'
);


INSERT INTO department 
VALUES ('Music', 'Watson', 90000);

INSERT INTO instructor 
VALUES ('99989', 'Mozart', 'Music', 50000);


UPDATE instructor
SET salary = salary * 1.05
WHERE dept_name = 'Comp. Sci.';


DELETE FROM takes
WHERE ID IN (
    SELECT ID
    FROM student
    WHERE tot_cred < 40
);

DELETE FROM student
WHERE tot_cred < 40;

SELECT name
FROM student
WHERE ID NOT IN(
    SELECT ID
    FROM takes
    WHERE course is NULL)



SELECT SUM(credits) AS tot_cred
FROM course
WHERE dept_name='Comp. Sci'

UPDATE department
SET budget=budget-budget*0.05;



DELIMITER //

CREATE PROCEDURE get_dept_instructors(IN dept VARCHAR(20))
BEGIN
    SELECT ID, name
    FROM instructor
    WHERE dept_name = dept;
END //

DELIMITER ;

CALL get_dept_instructors('Comp. Sci.');

DELIMITER //

CREATE PROCEDURE register_student(
    IN student_id VARCHAR(5),
    IN c_id VARCHAR(8),
    IN s_id VARCHAR(8),
    IN sem VARCHAR(6),
    IN yr NUMERIC(4,0)
)
BEGIN
    INSERT INTO takes
    VALUES (student_id, c_id, s_id, sem, yr, NULL);
END //

DELIMITER ;

CALL register_student('00128', 'CS-101', '1', 'Fall', 2024);

-- Trigger 1: Salary Cap

DELIMITER //

CREATE TRIGGER check_salary
BEFORE INSERT ON instructor
FOR EACH ROW
BEGIN
    IF NEW.salary > 150000 THEN
        SET NEW.salary = 150000;
    END IF;
END //

DELIMITER ;



DELIMITER //

CREATE TRIGGER update_tot_cred
AFTER UPDATE ON takes
FOR EACH ROW
BEGIN
    IF OLD.grade IS NULL AND NEW.grade IN ('A','B','C') THEN
        
        UPDATE student
        SET tot_cred = tot_cred + (
            SELECT credits
            FROM course
            WHERE course.course_id = NEW.course_id
        )
        WHERE ID = NEW.ID;

    END IF;
END //

DELIMITER ;

