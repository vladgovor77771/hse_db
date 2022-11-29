-- Select from t_books data about book with book_id = 18 and 
-- get expected execution plan for this query. Please, explain the result.

EXPLAIN SELECT * FROM t_books WHERE book_id = 18;

--                                   QUERY PLAN                                  
-- ------------------------------------------------------------------------------
--  Index Scan using t_books_id_pk on t_books  (cost=0.42..8.44 rows=1 width=62)
--    Index Cond: (book_id = 18)

-- Здесь наблюдаем Index Scan. Скорее всего это бинарный поиск с разными оптимизациями.