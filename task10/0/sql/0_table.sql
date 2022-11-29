-- Create base table

-- BOOKS table
--	 	book_id	  - ID of book (primary key)
--		title 	  - title of book
--		category  - book's category
--		author	  - book's author
CREATE TABLE t_books (
    book_id 		INT 			NOT NULL,
    title 			VARCHAR(100) 	NOT NULL,
    category		VARCHAR(30),
    author 			VARCHAR(100)    NOT NULL,
    is_active       VARCHAR(1)      NOT NULL,
    CONSTRAINT t_books_id_pk PRIMARY KEY (book_id)
);
