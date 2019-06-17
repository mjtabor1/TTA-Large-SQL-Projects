
CREATE TABLE library_branch (
	library_BranchID INT PRIMARY KEY NOT NULL IDENTITY (1,1),
	library_BranchName varchar(50) NOT NULL,
	library_BranchAddress varchar(50) NOT NULL
);

CREATE TABLE publisher (
	publisher_Name varchar(50) PRIMARY KEY NOT NULL,
	publisher_Address varchar(50) NOT NULL,
	publisher_Phone varchar(50) NOT NULL
);

CREATE TABLE books (
	books_BookID INT PRIMARY KEY NOT NULL IDENTITY (1,1),
	books_BookTitle varchar(50) NOT NULL,
	books_BookPublisher varchar(50) NOT NULL CONSTRAINT fk_books_publisher FOREIGN KEY REFERENCES publisher(publisher_Name) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE author (
	author_BookID INT NOT NULL CONSTRAINT fk_autho_BookID FOREIGN KEY REFERENCES books(books_BookID) ON UPDATE CASCADE ON DELETE CASCADE,
	author_Name varchar(50) NOT NULL
);

CREATE TABLE copies (
	copies_BookID INT NOT NULL CONSTRAINT fk_copies_BookID FOREIGN KEY REFERENCES books(books_BookID) ON UPDATE CASCADE ON DELETE CASCADE,
	copies_BranchID INT NOT NULL CONSTRAINT fk_copies_BranchID FOREIGN KEY REFERENCES library_branch(library_BranchID) ON UPDATE CASCADE ON DELETE CASCADE,
	copies_NumberofCopies INT NOT NULL
);

CREATE TABLE loans (
	loans_BookID INT NOT NULL CONSTRAINT fk_loans_BookID FOREIGN KEY REFERENCES books(books_BookID) ON UPDATE CASCADE ON DELETE CASCADE,
	loans_BranchID INT NOT NULL CONSTRAINT fk_loans_BranchID FOREIGN KEY REFERENCES library_branch(library_BranchID) ON UPDATE CASCADE ON DELETE CASCADE,
	loans_CardNo INT NOT NULL CONSTRAINT fk_loans_CardNo FOREIGN KEY REFERENCES borrower(borrower_CardNo) ON UPDATE CASCADE ON DELETE CASCADE,
	loans_DateOut DATE NOT NULL,
	loans_DateDue DATE NOT NULL
);

CREATE TABLE borrower (
	borrower_CardNo INT PRIMARY KEY NOT NULL IDENTITY (100,1),
	borrower_Name varchar(50) NOT NULL,
	borrower_Address varchar(50) NOT NULL,
	borrower_Phone varchar(50) NOT NULL
);

INSERT INTO library_branch (library_BranchName, library_BranchAddress)
VALUES ('Sharpstown', '123 Sharp Dr.'),
('Central', '123 Central St.'),
('Brighton', '456 Main St.'),
('Denver', '789 Denver Rd.')
;
SELECT * FROM library_branch;

INSERT INTO publisher (publisher_Name, publisher_Address, publisher_Phone)
VALUES ('Scholastic', '1 California', '303-124-4567'),
('Harper Collins', '2 Denver', '720-890-4567')
;
select * from publisher;

INSERT INTO books (books_BookTitle, books_BookPublisher)
VALUES ('The Shining','Scholastic'),
('Where the Crawdads Sing','Scholastic'),
('Educated', 'Scholastic'),
('Supermarket', 'Scholastic'),
('Brawl of the Wild', 'Harper Collins'), ('StrengthsFinder', 'Harper Collins'),
('To Kill a Mockingbird', 'Scholastic'), ('The Tattoist of Auschwitz', 'Scholastic'),
('Harry Potter', 'Harper Collins'), ('Eragon', 'Harper Collins'),
('Python Crash Course', 'Scholastic'), ('Game of Thrones', 'Scholastic'),
('A Storm of Swords', 'Harper Collins'), ('$100 Startup', 'Harper Collins'),
('Bad Blood', 'Scholastic'), ('A Feast of Crows', 'Scholastic'),
('The Great Gatsby', 'Harper Collins'), ('The Silent Patient', 'Harper Collins'),
('The Lost Tribe', 'Scholastic'), ('It', 'Scholastic')
;
select * from books;

INSERT INTO author (author_BookID, author_Name)
VALUES (1, 'Stephen King'),(2,'Delia Owens'), (3,'Tara Westover'), (4, 'Bobby Hall'),
(5,'Dav Pilkey'), (6, 'Tom Rath'), (7, 'Harper Lee'), (8, 'Heather Morris'),
(9, 'J.K. Rowling'), (10, 'Christopher Paolini'), (11, 'Eric Matthes'), (12, 'George R.R. Martin'),
(13, 'George R.R. Martin'), (14, 'Chris Guillebeau'), (15, 'John Carreyrou'), (16, 'George R.R. Martin'),
(17, 'F. Scott Fitzgerald'), (18, 'Alex Michaelides'), (19, 'Mark Lee'), (20, 'Stephen King')
;
select * from author;

INSERT INTO copies (copies_BookID, copies_BranchID, copies_NumberofCopies)
VALUES (1, 1, 2),(19, 1, 3),(2, 1, 2), (3, 1, 5), (4, 1, 2), (15, 1, 2), (7, 1, 2), (10, 1, 5), (12, 1, 2), (5, 1, 3),
(14, 2, 2), (20, 2, 5), (1, 2, 5), (6, 2, 2), (8, 2, 2), (9, 2, 3), (11, 2, 4), (13, 2, 2), (2, 2, 2), (18, 2, 4),
(20, 3, 2), (19, 3, 2), (18, 3, 2), (17, 3, 2), (16, 3, 2), (15, 3, 2), (14, 3, 2), (13, 3, 2), (12, 3, 2), (11, 3, 2),
(10, 4, 2), (9, 4, 2), (8, 4, 2), (7, 4, 2), (6, 4, 2), (5, 4, 2), (4, 4, 2), (3, 4, 2), (2, 4, 2), (1, 4, 2)
;
SELECT * FROM copies;

INSERT INTO loans (loans_BookID, loans_BranchID, loans_CardNo, loans_DateOut, loans_DateDue)
VALUES (1, 1, 100, '2019-01-10', '2019-01-24'), (19,1,100, '2019-01-10', '2019-01-24'), (15,1,100, '2019-02-07', '2019-02-21'),
(7, 1, 100, '2019-02-07', '2019-02-21'), (4, 1, 100, '2019-04-01', '2019-04-15'), (10, 1, 100, '2019-04-01', '2019-04-15'),
(14, 2, 101, '2019-01-10', '2019-01-24'), (20,2,101, '2019-01-10', '2019-01-24'), (1,2,101, '2019-02-07', '2019-02-21'),
(6, 2, 101, '2019-02-07', '2019-02-21'), (9, 2, 101, '2019-04-01', '2019-04-15'), (18, 2, 101, '2019-04-01', '2019-04-15'),
(20, 3, 102, '2019-02-07', '2019-02-21'), (19, 3, 102, '2019-04-01', '2019-04-15'), (17, 3, 102, '2019-04-01', '2019-04-15'),
(16, 3, 104, '2019-02-07', '2019-02-21'), (15, 3, 104, '2019-04-01', '2019-04-15'), (14, 3, 104, '2019-04-01', '2019-04-15'),
(10, 4, 103, '2019-02-07', '2019-02-21'), (9, 4, 103, '2019-04-01', '2019-04-15'), (8, 4, 103, '2019-04-01', '2019-04-15'),
(7, 4, 105, '2019-06-07', '2019-06-21'), (6, 4, 105, '2019-06-07', '2019-06-21'), (5, 4, 105, '2019-05-10', '2019-05-24'),
(10, 4, 106, '2019-06-07', '2019-06-21'), (6, 4, 106, '2019-06-07', '2019-06-21'), (2, 4, 106, '2019-05-10', '2019-05-24'),
(1, 1, 107, '2019-01-10', '2019-01-24'), (19,1,107, '2019-01-10', '2019-01-24'), (15,1,107, '2019-02-07', '2019-02-21'),
(14, 2, 107, '2019-01-07', '2019-01-21'), (6, 2, 107, '2019-01-10', '2019-01-24'), (11, 2, 107, '2019-02-07', '2019-02-21'),
(3, 1, 100, '2019-02-07', '2019-02-21'), (2, 1, 100, '2019-06-14', '2019-06-28'), (12, 1, 100, '2019-06-14', '2019-06-28'),
(14, 2, 101, '2019-04-10', '2019-04-24'), (20,2,101, '2019-04-10', '2019-04-24'), (1,2,101, '2019-05-07', '2019-05-21'),
(6, 2, 101, '2019-03-10', '2019-03-24'), (8,2,101, '2019-06-10', '2019-06-24'), (11,2,101, '2019-06-07', '2019-06-21'),
(7, 4, 103, '2019-03-07', '2019-03-21'), (6, 4, 103, '2019-05-01', '2019-05-15'), (5, 4, 103, '2019-04-01', '2019-04-15'),
(4, 4, 105, '2019-06-07', '2019-06-21'), (3, 4, 105, '2019-06-07', '2019-06-21'), (2, 4, 105, '2019-05-10', '2019-05-24'),
(14, 2, 106, '2019-06-07', '2019-06-21'), (13, 2, 106, '2019-06-07', '2019-06-21')
;




INSERT INTO borrower (borrower_Name, borrower_Address, borrower_Phone)
VALUES ('Michael Tabor', 'Denver', '303-880-4204'),
('Nicole Ramirez', 'Denver', '719-123-4567'),
('Collin Tabor', 'Brighton', '303-880-4523'),
('Dom Matthews', 'Thornton', '303-123-4567'),
('Gavin McLean', 'Brighton', '303-987-6543'),
('Ronnie McNitt', 'Country', '303-234-9876'),
('Christine Tabor', 'Durango', '303-579-9377'),
('Rico Suave', 'LA', '719-822-4537')
;


