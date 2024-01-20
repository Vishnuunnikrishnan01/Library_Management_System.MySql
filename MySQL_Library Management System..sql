--- MySQL- project - Entri --- 

CREATE DATABASE library;
USE library;

CREATE TABLE Branch(
Branch_no VARCHAR(10) PRIMARY KEY,
Manager_id VARCHAR(10), 
Branch_address VARCHAR(30),
Contact_no VARCHAR (15));

CREATE TABLE Employee(
Emp_id VARCHAR(10) PRIMARY KEY,
Emp_name VARCHAR(30),
Position VARCHAR(30),
Salary INT,
Branch_no VARCHAR(10),
FOREIGN KEY (Branch_no) REFERENCES Branch(Branch_no));

CREATE TABLE Customer(
Customer_Id VARCHAR(10) PRIMARY KEY,
Customer_name VARCHAR(30),
Customer_address VARCHAR(30),
Reg_date DATE);

CREATE TABLE Books(
ISBN VARCHAR(25) PRIMARY KEY,
Book_title VARCHAR(50),
Category VARCHAR(30),
Rental_Price DECIMAL(10,2),
Status VARCHAR(3),
Author VARCHAR(30),
Publisher VARCHAR(30));

CREATE TABLE IssueStatus(
Issue_Id VARCHAR(10) PRIMARY KEY,
Issued_cust VARCHAR(30),
Issued_book_name VARCHAR(50),
Issue_date DATE,
Isbn_book VARCHAR(25),
FOREIGN KEY (Issued_cust) REFERENCES customer(Customer_id),
FOREIGN KEY (Isbn_book) REFERENCES books(ISBN));

CREATE TABLE ReturnStatus(
Return_id VARCHAR(10) PRIMARY KEY,
Return_cust VARCHAR(30),
Return_book_name VARCHAR(50),
Return_date DATE,
isbn_book2 VARCHAR(25),
FOREIGN KEY (isbn_book2) REFERENCES books(ISBN));

INSERT INTO Branch VALUES
('B1', 'M1', '123 ktym', '+919000000000'),
('B2', 'M2', '456 klm', '+9180000000000'),
('B3', 'M3', '789 mlp', '+9170000000000'),
('B4', 'M4', '567 wynd', '+9160000000000'),
('B5', 'M5', '890 tvm', '+9150000000000');
SELECT * FROM Branch;

INSERT INTO Employee VALUES 
('E11', 'Johna aju', 'Manager', 60000,'B1'),
('E12', 'Akhil suresh', 'Clerk', 45000,'B2'),
('E13', 'Meenakshi shijo', 'Librarian', 55000,'B1'),
('E14', 'Karthik shiva', 'Assistant', 40000,'B3'),
('E15', 'Vishnu unnikrishnan', 'Assistant', 42000,'B1'),
('E16', 'Kiran sunil', 'Assistant', 43000,'B5'),
('E17', 'Anil kumar', 'Manager', 62000,'B2'),
('E18', 'Neeraja kishor', 'Clerk', 46000,'B1'),
('E19', 'Nandhana k', 'Librarian', 57000,'B5'),
('E20', 'Arun vs', 'Assistant', 41000,'B1'),
('E21', 'Praveen v', 'Manager', 64000,'B1'),
('E22', 'Anagha kp', 'Assistant', 38000,'B1');
SELECT * FROM Employee;

INSERT INTO Customer VALUES 
('C1', 'Aleena', '12 ktym', '2021-12-01'),
('C2', 'Kiran', '44 klm', '2021-07-20'),
('C3', 'Shameer', '97 pk', '2022-09-10'),
('C4', 'Muhammed', '10 krn', '2021-06-05');
SELECT * FROM customer;

INSERT INTO books VALUES
('978-0-553-29698-1', 'Khasakkinte Ithihasam', 'Classic', 300, 'yes', 'O. V. Vijayan', 'DC Books'),
('978-0-14-118776-2', 'Aadujeevitham', 'Novel', 650, 'yes', 'Benyamin', 'Green Books'),
('978-0-525-47535-3', 'Sapiens', 'History', 800, 'yes', 'Yuval Noah Harari', 'Manjul Publishing House'),
('978-0-141-44171-4', 'QABAR', 'Crime Thriller', 400, 'no', 'K R Meera', 'DC Books'),
('978-0-330-25864-5', 'Premalekhanam', 'Classic', 550, 'yes', 'Vaikom Muhammad Basheer', 'DC Books');
SELECT * FROM books;

INSERT INTO IssueStatus VALUES
('IsID1', 'C1', 'Khasakkinte Ithihasam', '2022-03-01', '978-0-553-29698-1'),
('IsID2', 'C2', 'Aadujeevitham', '2022-04-02', '978-0-14-118776-2'),
('IsID3', 'C3', 'Sapiens', '2023-06-03', '978-0-525-47535-3'),
('IsID4', 'C3', 'Premalekhanam', '2023-07-04', '978-0-141-44171-4');
SELECT * FROM IssueStatus;

INSERT INTO ReturnStatus VALUES
('RID1', 'RC1', 'Khasakkinte Ithihasam', '2022-10-11', '978-0-553-29698-1'),
('RID2', 'RC2', 'Aadujeevitham', '2022-07-15', '978-0-14-118776-2'),
('RID3', 'RC3', 'Sapiens', '2023-07-11', '978-0-525-47535-3');
SELECT * FROM returnstatus;

-- Q/A

-- 1. Retrieve the book title, category, and rental price of all available books.

SELECT book_title, category, rental_price FROM Books 
WHERE  Status = 'Yes';

-- 2. List the employee names and their respective salaries in descending order of salary.

SELECT Emp_name, Salary FROM Employee 
ORDER BY Salary DESC;

-- 3. Retrieve the book titles and the corresponding customers who have issued those books.

SELECT Books.Book_title, Customer.Customer_name
FROM IssueStatus 
JOIN Books ON IssueStatus.Isbn_book=Books.ISBN
JOIN Customer ON IssueStatus.Issued_cust=Customer.Customer_Id;

-- 4. Display the total count of books in each category.

SELECT category, COUNT(Book_title) FROM Books 
GROUP BY category;

-- 5. Retrieve the employee names and their positions for the employees whose salaries are above Rs.50,000.

SELECT Emp_name, Position FROM Employee 
WHERE Salary > 50000;

-- 6. List the customer names who registered before 2022-01-01 and have not issued any books yet.

SELECT Customer_name FROM Customer 
WHERE Reg_date<'2022-01-01' AND Customer_Id NOT IN (SELECT Issued_cust FROM IssueStatus);

-- 7. Display the branch numbers and the total count of employees in each branch.

SELECT Branch_no, COUNT(Emp_Id) FROM Employee
GROUP BY Branch_no;


-- 8. Display the names of customers who have issued books in the month of June 2023.

SELECT customer.Customer_name FROM customer INNER JOIN issuestatus ON 
customer.Customer_Id = issuestatus.Issued_cust WHERE issuestatus.Issue_date >= '2023-06-01' AND 
issuestatus.Issue_date <= '2023-06-30';

-- 9. Retrieve book_title from book table containing 'history'.

SELECT book_title FROM Books 
WHERE Category = 'History';

-- 10.Retrieve the branch numbers along with the count of employees for branches having more than 5 employees.

SELECT Branch_no , COUNT(Emp_Id) AS Emp_count FROM Employee
GROUP BY  Branch_no  HAVING (Emp_count) > 5;
