-- Select number of row in table t_books, distinct 
-- values on column title, distinct values in column 
-- category, distinct values in column author.

SELECT 
    count(*) AS total, 
    count(DISTINCT title) AS distinct_titles, 
    count(DISTINCT category) AS distinct_categories, 
    count(DISTINCT author) AS distinct_authors
FROM t_books;

--  total  | distinct_titles | distinct_categories | distinct_authors 
-- --------+-----------------+---------------------+------------------
--  167598 |           51196 |                  25 |            28063