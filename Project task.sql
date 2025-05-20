-- PROJECT TASK --

-- ### 1. CRUD Operations

-- Task 1. Create a New Book Record
-- "978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')"

INSERT INTO BOOKS (isbn,book_title,category,rental_price,status,author,publisher)
VALUES
('978-1-60129-456-2','To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.');
SELECT * FROM BOOKS;

-- Task 2: Update an Existing Member's Address

UPDATE memebers
SET member_address = 'changed location'
WHERE member_id = 'C101';

-- Task 3: Delete a Record from the Issued Status Table
-- Objective: Delete the record with issued_id = 'IS121' from the issued_status table.

DELETE FROM issue_status
WHERE issued_id = 'IS121';

-- Task 4: Retrieve All Books Issued by a Specific Employee
-- Objective: Select all books issued by the employee with emp_id = 'E101'.

SELECT * FROM issue_status
WHERE issued_emp_id = 'E101';

-- Task 5: List Members Who Have Issued More Than One Book
-- Objective: Use GROUP BY to find members who have issued more than one book.

SELECT 
     issued_emp_id
--	 COUNT(issued_id) as total_count
FROM issue_status
GROUP BY issued_emp_id
HAVING COUNT(issued_id) > 1;

-- ### 2. CTAS (Create Table As Select)

-- Task 6: Create Summary Tables**: Used CTAS to generate new tables based on query results - each book and total book_issued_cnt

CREATE TABLE book_counts
AS
SELECT 
      b.isbn,
	  b.book_title,
	  COUNT(issued_id) as no_issued
	  FROM books as b
JOIN
issue_status as ist
ON b.isbn = ist.issued_book_isbn
GROUP BY 1,2;

SELECT * FROM book_counts;

-- ### 3. Data Analysis & Findings

-- Task 7. **Retrieve All Books in a Specific Category:

SELECT * FROM books
WHERE category = 'Fiction';

-- Task 8: Find Total Rental Income by Category:

SELECT 
     category,
	 SUM(rental_price) as total_income,
	 COUNT(*)
FROM books
GROUP BY 1;

-- Task 9. List Members Who Registered in the Last 10 Days:

SELECT * FROM memebers
WHERE EXTRACT(DAY FROM reg_date)<10;

-- Task 10: List Employees with Their Branch Manager's Name and their branch details:

SELECT 
      e1.*,
	  b.manager_id,
	  e2.emp_name as manager
FROM employees as e1
JOIN 
branch as b
ON b.branch_id=e1.branch_id
JOIN 
employees as e2
ON b.manager_id = e2.emp_id;

-- Task 11. Create a Table of Books with Rental Price Above a Certain Threshold

CREATE TABLE book_price_above_7USD
AS
SELECT * FROM books
WHERE rental_price > 7;

-- Task 12: Retrieve the List of Books Not Yet Returned

SELECT
      DISTINCT ist.issued_book_name
FROM issue_status as ist
LEFT JOIN 
return_status as rs
ON ist.issued_id = rs.issued_id
WHERE rs.return_id IS NULL;

-- ADVANCE TASKS 

/* Task 13: Identify Members with Overdue Books
Write a query to identify members who have overdue books (assume a 60-day return period).
Display the member's_id, member's name, book title, issue date, and days overdue.
*/

SELECT 
      ist.issued_member_id,
	  m.member_name,
	  b.book_title,
	  ist.issued_date,
	 GREATEST(
         COALESCE(rs.return_date,CURRENT_DATE) - ist.issued_date
		  ) AS overdue_days
FROM issue_status as ist
JOIN
memebers as m
ON m.member_id = ist.issued_member_id
JOIN 
books as b
ON b.isbn = ist.issued_book_isbn
LEFT JOIN
return_status as rs
ON rs.issued_id = ist.issued_id
WHERE (GREATEST(
         COALESCE(rs.return_date,CURRENT_DATE) - ist.issued_date
		  ))> 60
ORDER BY 1;

