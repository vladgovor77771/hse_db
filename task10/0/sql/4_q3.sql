-- Create BTree index with name t_books_title_idx on title 
-- column of t_books table, create BTree index (t_books_active_idx) 
-- on is_active column of t_books.

CREATE INDEX t_books_title_idx ON t_books USING btree (title);
CREATE INDEX t_books_active_idx ON t_books USING btree (is_active);

-- CREATE INDEX
-- CREATE INDEX