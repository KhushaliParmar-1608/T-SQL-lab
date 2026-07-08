--From the tables EMPLOYEE perform the following queries 
--Part – A: 

--1. Display the Highest, Lowest Salary and Label the columns Maximum, Minimum respectively. 
SELECT MAX(SALARY) AS MAXIMUM ,MIN(SALARY) AS MINIMUM
FROM EMPLOYEE

--2. Display Total, and Average salary of all employees. Label the columns Total_Sal and Average_Sal, 
--respectively. 
SELECT SUM(SALARY) AS TOTAL_SAL , AVG(SALARY) AS AVERAGE_SAL
FROM EMPLOYEE

--3. Find total number of employees of EMPLOYEE table. 
SELECT COUNT(EID) AS TOTAL
FROM EMPLOYEE

--4. Find highest salary from Rajkot city. 
SELECT MAX(SALARY)
FROM EMPLOYEE
WHERE CITY = 'RAJKOT'

--5. Give maximum salary from IT department. 
SELECT MAX(SALARY)
FROM EMPLOYEE
WHERE DEPARTMENT = 'IT'

--6. Count employee department is HR.
SELECT COUNT(EID)
FROM EMPLOYEE
WHERE DEPARTMENT = 'HR'

--7. Display average salary of Admin department.
SELECT AVG(SALARY)
FROM EMPLOYEE
WHERE DEPARTMENT = 'ADMIN'

--8. Display total salary of HR department. 
SELECT SUM(SALARY)
FROM EMPLOYEE
WHERE DEPARTMENT='HR'

--9. Count total number of cities of employee without duplication.
SELECT COUNT(DISTINCT CITY)
FROM EMPLOYEE

--10. Count unique departments. 
SELECT DEPARTMENT , COUNT(DEPARTMENT)
FROM EMPLOYEE
GROUP BY DEPARTMENT

--11. Display minimum salary of employee who belongs to Ahmedabad.
SELECT MIN(SALARY)
FROM EMPLOYEE
WHERE CITY = 'AHEMDABAD'

--12. Find city wise highest salary.
SELECT CITY , MAX(SALARY) AS HIGHEST_SALARY
FROM EMPLOYEE
GROUP BY CITY

--13. Find department wise lowest salary.
SELECT DEPARTMENT , MIN(SALARY) AS LOWEST_SALARY
FROM EMPLOYEE
GROUP BY DEPARTMENT

--14. Display minimum salary in each city. 
SELECT CITY , MIN(SALARY) AS HIGHEST_SALARY
FROM EMPLOYEE
GROUP BY CITY

--15. Display average salary of employees from Surat.
SELECT AVG(SALARY)
FROM EMPLOYEE
WHERE CITY ='SURAT'

--16. Display total salary of female employees. 
SELECT SUM(SALARY)
FROM EMPLOYEE
WHERE GENDER = 'FEMALE'

--17. Count number of male employees. 
SELECT COUNT(EID)
FROM EMPLOYEE
WHERE GENDER = 'MALE'

--18. Display city with the total number of employees belonging to each city.
SELECT CITY , COUNT(CITY) AS NUMBER_OF_EMPLOYEE
FROM EMPLOYEE
GROUP BY CITY

--19. Count number of employees in each city where gender is MALE.
SELECT CITY , COUNT(CITY) AS NUMBER_OF_EMPLOYEE
FROM EMPLOYEE
WHERE GENDER = 'MALE'
GROUP BY CITY

--20. Display maximum salary in each department where city is not Ahmedabad.
SELECT DEPARTMENT , MIN(SALARY) AS MINIMUM_SALARY
FROM EMPLOYEE
WHERE NOT CITY = 'AHEMDABAD'
GROUP BY DEPARTMENT

--Part – B: 
--21. Display minimum salary in each city where gender is FEMALE. 
SELECT CITY , MIN(SALARY) 
FROM EMPLOYEE
WHERE GENDER = 'FEMALE'
GROUP BY CITY

--22. Give total salary of each department of EMPLOYEE table. 
SELECT DEPARTMENT , SUM(SALARY) AS TOTAL_SALARY
FROM EMPLOYEE
GROUP BY DEPARTMENT

--23. Give average salary of each department of EMPLOYEE table without displaying the respective 
--department name. 
SELECT AVG(SALARY)
FROM EMPLOYEE
GROUP BY DEPARTMENT

--24. Count the number of employees for each department in every city.
SELECT CITY ,DEPARTMENT,COUNT(EID) AS NUMBER_OF_DEPARTMENT
FROM EMPLOYEE
GROUP BY DEPARTMENT,CITY

--25. Calculate the total salary distributed to male and female employees.
SELECT GENDER ,SUM(SALARY) AS TOTAL_SALARY
FROM EMPLOYEE
GROUP BY GENDER
 
--Part – C: 
--26. Give city wise maximum and minimum salary of female employees.
SELECT CITY , MIN(SALARY) AS MIN_SALARY, MAX(SALARY) AS MAX_SALARY
FROM EMPLOYEE
WHERE GENDER = 'FEMALE'
GROUP BY CITY

--27. Calculate department, city, and gender wise average salary. 
SELECT DEPARTMENT , CITY , GENDER , AVG(SALARY)
FROM EMPLOYEE
GROUP BY DEPARTMENT , CITY , GENDER 

--28. Display the difference between the highest and lowest salaries. Label the column DIFFERENCE. 
SELECT MAX(SALARY) - MIN(SALARY) AS DEFFERENCE
FROM EMPLOYEE

--29. Display sum of salaries of department wise where department name consist 5 letter.
SELECT DEPARTMENT ,SUM(SALARY) AS TOTAL_SALARY
FROM EMPLOYEE
WHERE DEPARTMENT LIKE '_____'
GROUP BY DEPARTMENT
 
--30. Find the Maximum salary department & city wise in which city name starts with ‘R’.
SELECT DEPARTMENT , CITY , MAX(SALARY)
FROM EMPLOYEE
WHERE CITY LIKE 'R%'
GROUP BY DEPARTMENT , CITY

--‘AGGREGATE FUNCTIONS’ Extra Questions 
--SCHEMA: 
CREATE TABLE LibraryBorrowing ( 
BorrowID INT PRIMARY KEY, 
MemberName VARCHAR (50), 
BookGenre VARCHAR (30), 
DaysBorrowed INT, 
FineAmount DECIMAL (8,2) 
); 

INSERT INTO LibraryBorrowing VALUES 
(1, 'Amit', 'Fiction', 12, 60.00), 
(2, 'Neha', 'Science', 8, 20.00), 
(3, 'Rahul', 'History', 15, 75.00), 
(4, 'Priya', 'Fiction', 5, 0.00), 
(5, 'Karan', 'Science', 10, 35.00), 
(6, 'Sneha', 'Technology', 20, 120.00), 
(7, 'Amit', 'History', 7, 15.00), 
(8, 'Neha', 'Technology', 18, 95.00), 
(9, 'Rahul', 'Fiction', 9, 30.00), 
(10, 'Priya', 'Science', 11, 45.00);

SELECT * FROM LibraryBorrowing

--QUESTIONS: 

--I. Display the total fine amount collected for each book genre.
SELECT SUM(FineAmount)
FROM LibraryBorrowing
GROUP BY BookGenre

--II. Find the average number of days borrowed for each book genre.
SELECT AVG (DaysBorrowed)
FROM LibraryBorrowing
GROUP BY BookGenre

--III. Display the number of borrowing records for each member.
SELECT COUNT(BorrowID)
FROM LibraryBorrowing
GROUP BY MemberName

--IV. Find the maximum fine amount paid in each book genre.
SELECT MAX (FineAmount)
FROM LibraryBorrowing
GROUP BY BookGenre

--V. Display the minimum days borrowed for each book genre. 
SELECT MIN (FineAmount)
FROM LibraryBorrowing
GROUP BY BookGenre

--VI. Find the total number of days books were borrowed by each member.
SELECT SUM(DaysBorrowed)
FROM LibraryBorrowing

--VII. Display the average fine amount paid by each member.
SELECT SUM(FineAmount)
FROM LibraryBorrowing

--VIII. Find the highest number of days borrowed by each member.
SELECT MAX(DaysBorrowed)
FROM LibraryBorrowing

--IX. Find the difference between the highest and lowest fine for each genre.
SELECT MAX(FineAmount) - MIN(FineAmount)
FROM LibraryBorrowing

--X. Find how many times has each member borrowed a book.
SELECT COUNT(BorrowID)
FROM LibraryBorrowing
GROUP BY MemberName
