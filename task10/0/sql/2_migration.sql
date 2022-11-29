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