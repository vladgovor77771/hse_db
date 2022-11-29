-- drop t_books and indexes from previous lesson
DROP TABLE t_books PURGE;

-- Create base table

-- BOOKS table
--	 	book_id	  - ID of book (primary key)
--		title 	  - title of book
--		category  - book's category
--		author	  - book's author
CREATE TABLE t_books (
    book_id 		INT 			      NOT NULL,
    title 			VARCHAR2(100) 	NOT NULL,
    category		VARCHAR2(30),
    author 			VARCHAR2(100)   NOT NULL,
    is_active   VARCHAR2(1)     NOT NULL,
    CONSTRAINT t_books_id_pk PRIMARY KEY (book_id)
);

-- insert base data
INSERT INTO t_books
SELECT  ROWNUM, SUBSTR(o.object_name, 1, 100), SUBSTR(o.object_type, 1, 30), SUBSTR(o.owner, 1, 100),
        DECODE(MOD(ROWNUM, 2), 0, 'Y', 'N')
    FROM all_objects o
WHERE ROWNUM <= 150000;

UPDATE t_books
SET title = 'Oracle Core', category = 'Oracle Database', author = 'Jonathan Lewis', is_active = 'Y'
WHERE book_id = 3001;

UPDATE t_books
SET title = 'Expert Oracle Database Architecture', category = 'Oracle Database', author = 'Tom Kyte', is_active = 'Y'
WHERE book_id = 2025;

UPDATE t_books
SET title = 'SQL and Relational Theory', category = 'Relational Databases', author = 'C.J. Date', is_active = 'Y'
WHERE book_id = 190;

COMMIT;

-- Create partitioned table with the same data
-- (without primary key)
CREATE TABLE t_books_part (
    book_id 		INT 			      NOT NULL,
    title 			VARCHAR2(100) 	NOT NULL,
    category		VARCHAR2(30),
    author 			VARCHAR2(100)   NOT NULL,
    is_active   VARCHAR2(1)     NOT NULL
) PARTITION BY RANGE (book_id) (
    PARTITION t_books_local_part1 VALUES LESS THAN (10000),
    PARTITION t_books_local_part2 VALUES LESS THAN (20000),
    PARTITION t_books_local_part3 VALUES LESS THAN (MAXVALUE)
);

INSERT INTO t_books_part
SELECT book_id, title, category, author, is_active
    FROM t_books;

COMMIT;