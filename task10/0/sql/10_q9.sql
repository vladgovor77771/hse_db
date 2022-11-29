-- Select number of row in table t_books, distinct 
-- values on column title, distinct values in column 
-- category, distinct values in column author.

SELECT DISTINCT ON (title, category, author) book_id, title, category, author FROM t_books LIMIT 1;

-- ...

EXPLAIN SELECT DISTINCT ON (title, category, author) book_id, title, category, author FROM t_books;

--                                  QUERY PLAN                                 
-- ----------------------------------------------------------------------------
--  Unique  (cost=24503.50..26179.48 rows=47010 width=60)
--    ->  Sort  (cost=24503.50..24922.49 rows=167598 width=60)
--          Sort Key: title, category, author
--          ->  Seq Scan on t_books  (cost=0.00..3656.98 rows=167598 width=60)