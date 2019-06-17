
/* 1.) HOW MANY COPIES OF THE BOOK TITLED "The Lost Tribe" ARE OWNED BY THE 
LIBRARY BRANCH WHOSE NAME IS "SHARPSTOWN"? */
CREATE PROCEDURE QUERY1
AS
BEGIN
	SELECT c.copies_NumberofCopies AS 'Number of Copies:' FROM library_branch b
	inner join copies c ON c.copies_BranchID = b.library_BranchID
	inner join books bk ON bk.books_BookID = c.copies_BookID
	WHERE b.library_BranchName = 'Sharpstown' and bk.books_BookTitle = 'The Lost Tribe';
END

/* 2.) HOW MANY COPIES OF THE BOOK TITLED "The Lost Tribe" ARE OWNED BY
EACH LIBRARY BRANCH? */
CREATE PROCEDURE QUERY2
AS 
BEGIN
	SELECT c.copies_NumberofCopies as 'Number of Copies:', bk.books_BookTitle as 'Book Title:',
	b.library_BranchName as 'Branch Name' FROM library_branch b
	inner join copies c ON c.copies_BranchID = b.library_BranchID
	inner join books bk ON bk.books_BookID = c.copies_BookID
	WHERE bk.books_BookTitle = 'The Lost Tribe';
END

/* 3.) RETRIEVE THE NAMES OF ALL BORROWERS WHO DO NOT HAVE ANY BOOKS
CHECKED OUT */
CREATE PROCEDURE QUERY3
AS 
BEGIN
	SELECT b.borrower_Name as 'Borrower Name:' FROM borrower b
	LEFT JOIN loans l  ON l.loans_CardNo = b.borrower_CardNo
	WHERE l.loans_CardNo IS NULL;
END

/* 4.) FOR EACH BOOK THAT IS LOANED OUT FOM THE 'SHARPSTOWN' BRANCH AND WHOSE
DUEDATE IS TODAY, RETRIEVE THE BOOK TITLE, THE BORROWER'S NAME AND THE BORROWERS ADDRESS */
CREATE PROCEDURE QUERY4
AS
BEGIN
	SELECT books.books_BookTitle, bor.borrower_Name, bor.borrower_Address
	FROM books 
	INNER JOIN loans l ON books.books_BookID = l.loans_BookID
	INNER JOIN borrower bor ON bor.borrower_CardNo = l.loans_CardNo
	INNER JOIN library_branch lb ON lb.library_BranchID = l.loans_BranchID
	WHERE lb.library_BranchName = 'Sharpstown' AND l.loans_DateDue = CONVERT(date, GETDATE());
END

/* 5.) FOR EACH LIBRARY BRANCH, RETRIEVE THE BRANCH NAME AND THE TOTAL NUMBER OF 
BOOKS LOANED OUT FROM THAT BRANCH */
CREATE PROCEDURE QUERY5
AS 
BEGIN
	SELECT lb.library_BranchName AS 'Branch Name:', Count(l.loans_BookID) AS '# of Loans:'
	FROM library_branch lb
	INNER JOIN loans l ON l.loans_BranchID = lb.library_BranchID
	GROUP BY lb.library_BranchName;

END

/* 6.) RETRIEVE THE NAMES, ADDRESSES, AND THE NUMBER OF BOOKS CHECKED OUT FOR ALL
BORROWERS WHO HAVE MORE THAN FIVE BOOKS CHECKED OUT */
CREATE PROCEDURE QUERY6
AS 
BEGIN

	SELECT bo.borrower_Name, bo.borrower_Address, Count(l.loans_BookID)
	FROM borrower bo
	INNER JOIN loans l ON l.loans_CardNo = bo.borrower_CardNo
	GROUP BY bo.borrower_Name, bo.borrower_Address HAVING Count(l.loans_BookID) > 5;

END

/* 7.) FOR EACH BOOK AUTHORED BY 'STEPHEN KING', RETRIEVE THE TITLE AND THE 
NUMBER OF COPIES OWNED BY THE LIBRARY BRANCH WHOSE NAME IS 'CENTRAL' */
CREATE PROCEDURE QUERY7
AS 
BEGIN
	SELECT bk.books_BookTitle as 'Title:', c.copies_NumberofCopies as '# of Copies:'
	FROM copies c
	INNER JOIN author a ON a.author_BookID = c.copies_BookID
	INNER JOIN books bk ON bk.books_BookID = a.author_BookID
	INNER JOIN library_branch l ON l.library_BranchID = c.copies_BranchID
	WHERE a.author_Name = 'Stephen King' AND l.library_BranchName = 'Central';

END
