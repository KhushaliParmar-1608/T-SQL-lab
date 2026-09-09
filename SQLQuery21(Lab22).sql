-- From the table CUSTOMER perform the following queries:


CREATE TABLE CUSTOMER_ALL
(
    ORDERID INT,
    CNAME VARCHAR(50),
    PRODUCT VARCHAR(50),
    CATEGORY VARCHAR(50),
    AMOUNT INT,
    ORDERYEAR INT,
    CITY VARCHAR(50)
);


INSERT INTO CUSTOMER_ALL
(ORDERID, CNAME, PRODUCT, CATEGORY, AMOUNT, ORDERYEAR, CITY)
VALUES
(101, 'RAHUL', 'LAPTOP', 'ELECTRONICS', 65000, 2024, 'RAJKOT'),
(102, 'PRIYA', 'MOBILE', 'ELECTRONICS', 25000, 2023, 'SURAT'),
(103, 'AMIT', 'TABLE', 'FURNITURE', 12000, 2022, 'AHMEDABAD'),
(104, 'NEHA', 'CHAIR', 'FURNITURE', 8000, 2024, 'BARODA'),
(105, 'VISHAL', 'TV', 'ELECTRONICS', 45000, 2025, 'MORBI'),
(106, 'RIYA', 'SOFA', 'FURNITURE', 30000, 2023, 'SURAT'),
(107, 'MEHUL', 'AC', 'ELECTRONICS', 40000, 2022, 'RAJKOT'),
(108, 'KRUNAL', 'BED', 'FURNITURE', 40000, 2025, 'JAMNAGAR');


SELECT * FROM CUSTOMER_ALL;


--Part – A:


--1. Display top 3 highest amount orders.

WITH TOP_3_HIGHAMOUNT AS
(
    SELECT TOP 3 *
    FROM CUSTOMER_ALL
    ORDER BY AMOUNT DESC
)
SELECT *
FROM TOP_3_HIGHAMOUNT;


--2. Display second highest order amount.

WITH SECOND_HIGHEST AS
(
    SELECT *,
           DENSE_RANK() OVER(ORDER BY AMOUNT DESC) AS AMOUNT_RANK
    FROM CUSTOMER_ALL
)
SELECT *
FROM SECOND_HIGHEST
WHERE AMOUNT_RANK = 2;


--3. Display customers whose order amount is greater than category average amount.

WITH CATEGORY_AVG AS
(
    SELECT CATEGORY,
           AVG(AMOUNT) AS AVG_AMT
    FROM CUSTOMER_ALL
    GROUP BY CATEGORY
)
SELECT C.*
FROM CUSTOMER_ALL C
WHERE AMOUNT >
(
    SELECT AVG_AMT
    FROM CATEGORY_AVG A
    WHERE A.CATEGORY = C.CATEGORY
);


--4. Display categories having average amount greater than 30000.

WITH AVG_AMOUNT AS
(
    SELECT CATEGORY,
           AVG(AMOUNT) AS AVERAGE_AMOUNT
    FROM CUSTOMER_ALL
    GROUP BY CATEGORY
)
SELECT *
FROM AVG_AMOUNT
WHERE AVERAGE_AMOUNT > 30000;


--5. Display highest amount order from each category.

WITH HIGHEST_ORDER AS
(
    SELECT *,
           RANK() OVER
           (
               PARTITION BY CATEGORY
               ORDER BY AMOUNT DESC
           ) AS AMOUNT_RANK
    FROM CUSTOMER_ALL
)
SELECT *
FROM HIGHEST_ORDER
WHERE AMOUNT_RANK = 1;


--6. Display lowest amount order from each category.

WITH LOWEST_ORDER AS
(
    SELECT *,
           RANK() OVER
           (
               PARTITION BY CATEGORY
               ORDER BY AMOUNT ASC
           ) AS AMOUNT_RANK
    FROM CUSTOMER_ALL
)
SELECT *
FROM LOWEST_ORDER
WHERE AMOUNT_RANK = 1;


--7. Display categories having more than 3 orders.

WITH CATEGORY_ORDERS AS
(
    SELECT CATEGORY,
           COUNT(*) AS TOTAL_ORDERS
    FROM CUSTOMER_ALL
    GROUP BY CATEGORY
)
SELECT *
FROM CATEGORY_ORDERS
WHERE TOTAL_ORDERS > 3;


--8. Display city-wise total order amount.

WITH CITY_TOTAL AS
(
    SELECT CITY,
           SUM(AMOUNT) AS TOTAL_AMOUNT
    FROM CUSTOMER_ALL
    GROUP BY CITY
)
SELECT *
FROM CITY_TOTAL;


--9. Display category having highest average order amount.

WITH CATEGORY_AVG AS
(
    SELECT CATEGORY,
           AVG(AMOUNT) AS AVG_AMOUNT
    FROM CUSTOMER_ALL
    GROUP BY CATEGORY
)
SELECT *
FROM CATEGORY_AVG
WHERE AVG_AMOUNT =
(
    SELECT MAX(AVG_AMOUNT)
    FROM CATEGORY_AVG
);


--10. Display cumulative order amount in ascending order of amount.

WITH CUMULATIVE_AMOUNT AS
(
    SELECT ORDERID,
           CNAME,
           PRODUCT,
           CATEGORY,
           AMOUNT,
           SUM(AMOUNT) OVER
           (
               ORDER BY AMOUNT ASC
               ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
           ) AS CUMULATIVE_AMOUNT
    FROM CUSTOMER_ALL
)
SELECT *
FROM CUMULATIVE_AMOUNT
ORDER BY AMOUNT ASC;



--Part – B:


--11. Display category-wise top 2 highest amount orders.

WITH TOP_2_CATEGORY AS
(
    SELECT *,
           ROW_NUMBER() OVER
           (
               PARTITION BY CATEGORY
               ORDER BY AMOUNT DESC
           ) AS AMOUNT_RANK
    FROM CUSTOMER_ALL
)
SELECT *
FROM TOP_2_CATEGORY
WHERE AMOUNT_RANK <= 2;


--12. Display customers whose amount is closest to category average amount.

WITH CATEGORY_AVG AS
(
    SELECT CATEGORY,
           AVG(AMOUNT) AS AVG_AMOUNT
    FROM CUSTOMER_ALL
    GROUP BY CATEGORY
),
CLOSEST_AMOUNT AS
(
    SELECT C.*,
           A.AVG_AMOUNT,
           ABS(C.AMOUNT - A.AVG_AMOUNT) AS DIFFERENCE,
           RANK() OVER
           (
               PARTITION BY C.CATEGORY
               ORDER BY ABS(C.AMOUNT - A.AVG_AMOUNT)
           ) AS AMOUNT_RANK
    FROM CUSTOMER_ALL C
    JOIN CATEGORY_AVG A
        ON C.CATEGORY = A.CATEGORY
)
SELECT *
FROM CLOSEST_AMOUNT
WHERE AMOUNT_RANK = 1;


--13. Display previous, current and next order amount together.

WITH PREV_NEXT_AMOUNT AS
(
    SELECT ORDERID,
           CNAME,
           AMOUNT,
           LAG(AMOUNT) OVER(ORDER BY ORDERID) AS PREVIOUS_AMOUNT,
           LEAD(AMOUNT) OVER(ORDER BY ORDERID) AS NEXT_AMOUNT
    FROM CUSTOMER_ALL
)
SELECT *
FROM PREV_NEXT_AMOUNT;


--14. Display customers whose amount is greater than previous customer's amount.

WITH PREVIOUS_AMOUNT AS
(
    SELECT *,
           LAG(AMOUNT) OVER(ORDER BY ORDERID) AS PREVIOUS_AMOUNT
    FROM CUSTOMER_ALL
)
SELECT *
FROM PREVIOUS_AMOUNT
WHERE AMOUNT > PREVIOUS_AMOUNT;


--15. Display customers whose rank and dense rank are different.

WITH RANK_DATA AS
(
    SELECT *,
           RANK() OVER(ORDER BY AMOUNT DESC) AS AMOUNT_RANK,
           DENSE_RANK() OVER(ORDER BY AMOUNT DESC) AS AMOUNT_DENSE_RANK
    FROM CUSTOMER_ALL
)
SELECT *
FROM RANK_DATA
WHERE AMOUNT_RANK <> AMOUNT_DENSE_RANK;



--Part – C:


--16. Display orders whose amount is neither highest nor lowest in their category.

WITH CATEGORY_RANK AS
(
    SELECT *,
           RANK() OVER
           (
               PARTITION BY CATEGORY
               ORDER BY AMOUNT DESC
           ) AS HIGH_RANK,
           RANK() OVER
           (
               PARTITION BY CATEGORY
               ORDER BY AMOUNT ASC
           ) AS LOW_RANK
    FROM CUSTOMER_ALL
)
SELECT *
FROM CATEGORY_RANK
WHERE HIGH_RANK <> 1
AND LOW_RANK <> 1;


--17. Display category-wise difference between highest and lowest amount.

WITH CATEGORY_AMOUNT AS
(
    SELECT CATEGORY,
           MAX(AMOUNT) AS HIGHEST_AMOUNT,
           MIN(AMOUNT) AS LOWEST_AMOUNT
    FROM CUSTOMER_ALL
    GROUP BY CATEGORY
)
SELECT CATEGORY,
       HIGHEST_AMOUNT,
       LOWEST_AMOUNT,
       HIGHEST_AMOUNT - LOWEST_AMOUNT AS DIFFERENCE
FROM CATEGORY_AMOUNT;


--18. Display customers whose amount is greater than all FURNITURE category orders.

SELECT *
FROM CUSTOMER_ALL
WHERE AMOUNT >
(
    SELECT MAX(AMOUNT)
    FROM CUSTOMER_ALL
    WHERE CATEGORY = 'FURNITURE'
);


--19. Display categories where all orders are above 10000.

SELECT CATEGORY
FROM CUSTOMER_ALL
GROUP BY CATEGORY
HAVING MIN(AMOUNT) > 10000;


--20. Display customers whose amount difference from category topper is minimum.

WITH CATEGORY_TOPPER AS
(
    SELECT CATEGORY,
           MAX(AMOUNT) AS TOP_AMOUNT
    FROM CUSTOMER_ALL
    GROUP BY CATEGORY
),
AMOUNT_DIFFERENCE AS
(
    SELECT C.*,
           T.TOP_AMOUNT,
           T.TOP_AMOUNT - C.AMOUNT AS DIFFERENCE,
           RANK() OVER
           (
               PARTITION BY C.CATEGORY
               ORDER BY T.TOP_AMOUNT - C.AMOUNT
           ) AS DIFFERENCE_RANK
    FROM CUSTOMER_ALL C
    JOIN CATEGORY_TOPPER T
        ON C.CATEGORY = T.CATEGORY
)
SELECT *
FROM AMOUNT_DIFFERENCE
WHERE DIFFERENCE_RANK = 1;