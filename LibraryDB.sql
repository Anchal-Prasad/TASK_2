CREATE DATABASE LibraryDB;
USE LibraryDB;

CREATE TABLE Category (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL
);

CREATE TABLE Author (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    author_name VARCHAR(150) NOT NULL
);

CREATE TABLE Book (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    isbn VARCHAR(20) UNIQUE,
    published_year YEAR,
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES Category(category_id)
);

CREATE TABLE BookAuthor (
    book_id INT,
    author_id INT,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES Book(book_id),
    FOREIGN KEY (author_id) REFERENCES Author(author_id)
);

CREATE TABLE Member (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    member_name VARCHAR(150) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),
    membership_date DATE DEFAULT (CURRENT_DATE)
);

CREATE TABLE Loan (
    loan_id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT,
    book_id INT,
    issue_date DATE,
    due_date DATE,
    return_date DATE,
    FOREIGN KEY (member_id) REFERENCES Member(member_id),
    FOREIGN KEY (book_id) REFERENCES Book(book_id)
);

-- INSERT CATEGORY
INSERT INTO Category (category_name)
VALUES
('Fiction'),
('Science'),
('History'),
('Technology'),
('Self-Help');

-- INSERT AUTHORS
INSERT INTO Author (author_name)
VALUES
('Chetan Bhagat'),
('Yuval Noah Harari'),
('Stephen Hawking'),
('James Clear'),
('Dan Brown');

-- INSERT BOOKS
INSERT INTO Book (title, isbn, published_year, category_id)
VALUES
('2 States', 'ISBN1001', 2009, 1),
('Sapiens: A Brief History of Humankind', 'ISBN2001', 2011, 3),
('A Brief History of Time', 'ISBN3001', 1988, 2),
('Atomic Habits', 'ISBN4001', 2018, 5),
('The Da Vinci Code', 'ISBN5001', 2003, 1);

-- BOOK - AUTHOR MAPPING
INSERT INTO BookAuthor (book_id, author_id)
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

-- INSERT MEMBERS
INSERT INTO Member (member_name, email, phone)
VALUES
('Aarav Sharma', 'aarav@example.com', '9876543210'),
('Priya Verma', 'priya@example.com', '9822334455'),
('Rahul Kumar', NULL, '9001122334'),
('Sneha Patel', 'sneha@example.com', NULL);

-- INSERT LOAN RECORDS
INSERT INTO Loan (member_id, book_id, issue_date, due_date, return_date)
VALUES
(1, 1, '2025-01-10', '2025-01-20', NULL),
(2, 4, '2025-01-12', '2025-01-22', '2025-01-20'),
(3, 3, '2025-01-14', '2025-01-24', NULL),
(4, 2, '2025-01-16', '2025-01-26', NULL);


SHOW DATABASES;

-- UPDATE STATEMENTS
UPDATE Member
SET email = 'rahulkumar@example.com'
WHERE member_id = 3;

UPDATE Book
SET category_id = 2
WHERE title = 'The Da Vinci Code';

UPDATE Loan
SET due_date = DATE_ADD(due_date, INTERVAL 5 DAY)
WHERE loan_id = 1;

UPDATE Member
SET phone = '0000000000'
WHERE phone IS NULL;

-- DELETE STATEMENTS
DELETE FROM Loan
WHERE return_date IS NOT NULL;

DELETE FROM Member
WHERE member_id = 4;

DELETE FROM Category
WHERE category_id NOT IN (SELECT DISTINCT category_id FROM Book);
