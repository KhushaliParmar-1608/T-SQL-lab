--From the table PUBLISHER, AUTHOR and BOOK perform the following queries:
SELECT * FROM PUBLISHER
SELECT *FROM AUTHOR
SELECT* FROM BOOK
--Part – A: 

--1. List all books with their authors.
SELECT TITLE ,AUTHORNAME
FROM AUTHOR A
INNER JOIN BOOK B
ON A.AUTHORID = B.AUTHORID

--2. List all books with their publishers.
SELECT TITLE ,PUBLISHERNAME
FROM PUBLISHER P
INNER JOIN BOOK B
ON P.PUBLISHERID = B.PUBLISHERID

--3. List all books with their authors and publishers. 
SELECT TITLE ,AUTHORNAME,PUBLISHERNAME
FROM PUBLISHER P
INNER JOIN BOOK B
ON P.PUBLISHERID = B.PUBLISHERID
INNER JOIN AUTHOR A
ON B.AUTHORID = A.AUTHORID

--4. List all books published after 2010 with their authors and publisher and price. 
SELECT TITLE, AUTHORNAME, PUBLISHERNAME, PRICE
FROM BOOK B
INNER JOIN AUTHOR A
ON B.AUTHORID = A.AUTHORID
INNER JOIN PUBLISHER P
ON B.PUBLISHERID = P.PUBLISHERID
WHERE PUBLICATIONYEAR > 2010;


--5. List all authors and the number of books they have written.
SELECT AUTHORNAME , COUNT(BOOKID) AS [NUMBER OF BOOKS]
FROM AUTHOR A
INNER JOIN BOOK B
ON A.AUTHORID = B.AUTHORID
GROUP BY AUTHORNAME

--6. List all publishers and the total price of books they have published. 
SELECT PUBLISHERNAME , SUM(PRICE) AS [TOTAL PRICE]
FROM BOOK B
INNER JOIN PUBLISHER P
ON B.PUBLISHERID = P.PUBLISHERID
GROUP BY PUBLISHERNAME


--7. List authors who have not written any books. 
SELECT AUTHORNAME
FROM AUTHOR A
LEFT JOIN BOOK B
ON A.AUTHORID = B.AUTHORID
WHERE B.BOOKID IS NULL

--8. Display the total number of books written by each author along with the average price of their books. 
SELECT AUTHORNAME , COUNT(B.BOOKID) AS [NUMBER OF BOOKS] , AVG(B.PRICE) AS [AVG PRICE]
FROM AUTHOR A
LEFT JOIN BOOK B
ON A.AUTHORID = B.AUTHORID
GROUP BY AUTHORNAME

--9. lists each publisher along with the total number of books they have published, sorted from highest to 
--lowest. 
SELECT PUBLISHERNAME , COUNT(B.BOOKID) AS [TOTAL BOOKS]
FROM BOOK B
INNER JOIN PUBLISHER P
ON B.PUBLISHERID = P.PUBLISHERID
GROUP BY PUBLISHERNAME
ORDER BY [TOTAL BOOKS] DESC

--10. Display number of books published each year.
SELECT PUBLICATIONYEAR , COUNT(BOOKID) AS [TOTAL BOOKS]
FROM BOOK 
GROUP BY PUBLICATIONYEAR

--Part – B:  
--11. List the publishers whose total book prices exceed 500, ordered by the total price. 
SELECT PUBLISHERNAME , SUM(PRICE) AS [TOTAL PRICE]
FROM BOOK B
INNER JOIN PUBLISHER P
ON B.PUBLISHERID = P.PUBLISHERID
GROUP BY PUBLISHERNAME
HAVING SUM(PRICE) > 500
ORDER BY [TOTAL PRICE]

--12. List most expensive book for each author, sort it with the highest price.
SELECT AUTHORNAME , MAX(PRICE) AS [EXPENSIVE BOOK]
FROM AUTHOR A
INNER JOIN BOOK B
ON A.AUTHORID = B.AUTHORID
GROUP BY AUTHORNAME
ORDER BY [EXPENSIVE BOOK]

--13. Display publisher name and difference between maximum and minimum book price.
SELECT PUBLISHERNAME ,MAX(PRICE)-MIN(PRICE) AS [DIFFERENCE]
FROM BOOK B
INNER JOIN PUBLISHER P
ON B.PUBLISHERID = P.PUBLISHERID
GROUP BY PUBLISHERNAME

--14. List publisher name and total price of books published each year. 
SELECT PUBLISHERNAME ,PUBLICATIONYEAR, SUM(PRICE) AS [TOTAL PRICE]
FROM BOOK B
INNER JOIN PUBLISHER P
ON B.PUBLISHERID = P.PUBLISHERID
GROUP BY PUBLISHERNAME , PUBLICATIONYEAR

--15. Display author name and total price of books sorted by highest total price. 
SELECT AUTHORNAME , MAX(PRICE) AS [EXPENSIVE BOOK]
FROM AUTHOR A
INNER JOIN BOOK B
ON A.AUTHORID = B.AUTHORID
GROUP BY AUTHORNAME 
ORDER BY [EXPENSIVE BOOK] DESC

--From the above table EMPLOYEE_MASTER perform the following queries: 
CREATE TABLE EMPLOYEE_MASTER (
EmployeeNo VARCHAR(30),
[Name] VARCHAR(30),
ManagerNo VARCHAR(30)
);

INSERT INTO EMPLOYEE_MASTER
VALUES ('E01','Tarun',NULL),
('E02','Rohan','E02'),
('E03','Priya','E01'),
('E04','Milan','E03'),
('E05','Jay','E01'),
('E06','Anjana','E04');

SELECT * FROM EMPLOYEE_MASTER
--Part – C: 
--16. Retrieve the names of employee along with their manager’s name from the Employee table.
SELECT
E.Name AS Employee,
M.Name AS Manager
FROM EMPLOYEE_MASTER E
LEFT JOIN EMPLOYEE_MASTER M
ON E.ManagerNo = M.EmployeeNo;

--17. Display employees who are managers.
SELECT DISTINCT M.Name
FROM EMPLOYEE_MASTER E 
INNER JOIN EMPLOYEE_MASTER M
ON E.ManagerNo = M.EmployeeNo

--18. Display number of employees working under each manager.
SELECT
M.Name AS Manager,
COUNT(E.EmployeeNo) AS [Total Employees]
FROM EMPLOYEE_MASTER E
INNER JOIN EMPLOYEE_MASTER M
ON E.ManagerNo = M.EmployeeNo
GROUP BY M.Name;

--19. Display the employee’s name along with their manager’s name and senior manager name.
SELECT
E.Name AS Employee,
M.Name AS Manager,
SM.Name AS SeniorManager
FROM EMPLOYEE_MASTER E
LEFT JOIN EMPLOYEE_MASTER M
ON E.ManagerNo = M.EmployeeNo
LEFT JOIN EMPLOYEE_MASTER SM
ON M.ManagerNo = SM.EmployeeNo;

--20. Display managers and count of employees under them in descending order. 
SELECT
M.Name AS Manager,
COUNT(E.EmployeeNo) AS [Total Employees]
FROM EMPLOYEE_MASTER E
INNER JOIN EMPLOYEE_MASTER M
ON E.ManagerNo = M.EmployeeNo
GROUP BY M.Name
ORDER BY [Total Employees] DESC;