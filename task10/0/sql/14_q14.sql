-- Create B*Tree index (t_books_up_title_idx) on UPPER(title) expression of t_books table.

CREATE INDEX t_books_title_idx ON t_books USING btree (UPPER(title));

-- CREATE INDEX