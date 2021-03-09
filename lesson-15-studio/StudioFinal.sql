 CREATE TABLE book (
   book_id INT AUTO_INCREMENT PRIMARY KEY,
   author_id INT,
   title VARCHAR(255),
   isbn INT,
   available BOOL,
   genre_id INT
);

CREATE TABLE author (
   author_id INT AUTO_INCREMENT PRIMARY KEY,
   first_name VARCHAR(255),
   last_name VARCHAR(255),
   birthday DATE,
   deathday DATE
);

CREATE TABLE patron (
   patron_id INT AUTO_INCREMENT PRIMARY KEY,
   first_name VARCHAR(255),
   last_name VARCHAR(255),
   loan_id INT
);

CREATE TABLE reference_books (
   reference_id INT AUTO_INCREMENT PRIMARY KEY,
   edition INT,
   book_id INT,
   FOREIGN KEY (book_id)
      REFERENCES book(book_id)
      ON UPDATE SET NULL
      ON DELETE SET NULL
);

INSERT INTO reference_books(edition, book_id)
VALUE (5,32);

CREATE TABLE genre (
   genre_id INT PRIMARY KEY,
   genres VARCHAR(100)
);

CREATE TABLE loan (
   loan_id INT AUTO_INCREMENT PRIMARY KEY,
   patron_id INT,
   date_out DATE,
   date_in DATE,
   book_id INT,
   FOREIGN KEY (book_id)
      REFERENCES book(book_id)
      ON UPDATE SET NULL
      ON DELETE SET NULL
);

SELECT title, isbn FROM book
WHERE genre_id = (SELECT genre_id FROM genre WHERE genres = "Mystery");

SELECT title, author.first_name, author.last_name FROM book
INNER JOIN author ON book.author_id = author.author_id WHERE author.deathday IS null;

-- Check out
UPDATE book SET book.available = FALSE 
WHERE book.book_id =3;

INSERT INTO loan (patron_id, book_id, date_out)
VALUES (37, 3, curdate());

UPDATE patron SET loan_id = (SELECT loan_id FROM loan WHERE patron_id = 37 AND book_id = 3 AND date_in IS null) 
WHERE patron.patron_id=37;

-- Check in 
UPDATE book SET book.available = TRUE
WHERE book.book_id = 3;

UPDATE loan SET date_in = curdate()
WHERE loan_id=(SELECT loan_id FROM patron WHERE patron_id = 37);

UPDATE patron SET loan_id = null
WHERE patron_id = 37;

 -- have 5 people checkout 5 books 
 -- person 1
 UPDATE book SET book.available = FALSE 
WHERE book.book_id =18;

INSERT INTO loan (patron_id, book_id, date_out)
VALUES (26, 18, curdate());

UPDATE patron SET loan_id = (SELECT loan_id FROM loan WHERE patron_id = 26 AND book_id = 18 AND date_in IS null) 
WHERE patron.patron_id=26;

-- person 2
UPDATE book SET book.available = FALSE 
WHERE book.book_id =35;

INSERT INTO loan (patron_id, book_id, date_out)
VALUES (28, 35, curdate());

UPDATE patron SET loan_id = (SELECT loan_id FROM loan WHERE patron_id = 28 AND book_id = 35 AND date_in IS null) 
WHERE patron.patron_id=28;

-- person 3
UPDATE book SET book.available = FALSE 
WHERE book.book_id =32;

INSERT INTO loan (patron_id, book_id, date_out)
VALUES (6, 32, curdate());

UPDATE patron SET loan_id = (SELECT loan_id FROM loan WHERE patron_id = 6 AND book_id = 32 AND date_in IS null) 
WHERE patron.patron_id=6;

-- person 4
UPDATE book SET book.available = FALSE 
WHERE book.book_id =17;

INSERT INTO loan (patron_id, book_id, date_out)
VALUES (11, 17, curdate());

UPDATE patron SET loan_id = (SELECT loan_id FROM loan WHERE patron_id = 11 AND book_id = 17 AND date_in IS null) 
WHERE patron.patron_id=11;

-- person 5
UPDATE book SET book.available = FALSE 
WHERE book.book_id =3;

INSERT INTO loan (patron_id, book_id, date_out)
VALUES (15, 3, curdate());

UPDATE patron SET loan_id = (SELECT loan_id FROM loan WHERE patron_id = 15 AND book_id = 3 AND date_in IS null) 
WHERE patron.patron_id=15;

-- Wrap-up Query
-- SELECT title, isbn FROM book
-- WHERE genre_id = (SELECT genre_id FROM genre WHERE genres = "Mystery");

-- SELECT title, author.first_name, author.last_name FROM book
-- INNER JOIN author ON book.author_id = author.author_id WHERE author.deathday IS null;

SELECT patron.first_name, patron.last_name , genre.genres FROM patron 
INNER JOIN loan ON patron.patron_id=loan.patron_id
INNER JOIN book ON loan.book_id = book.book_id
INNER JOIN genre ON book.genre_id = genre.genre_id
WHERE patron.loan_id IS NOT Null;

 



