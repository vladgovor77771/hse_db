-- Based on previous counts try to create an index that satisfies 
-- the following predicates and explain your solution, please: 
-- a. b.title = :v1 and b.category = :v2 
-- b. b.title = :v1 
-- c. b.category = :v1 and b.author = :v2 
-- d. b.author = :v1 and b.book_id = :v2

CREATE INDEX t_books_title_category_idx ON t_books (title, category, author, book_id);

-- CREATE INDEX

EXPLAIN SELECT * FROM t_books WHERE title = 'Oracle Core' AND category = 'Oracle Database';
--  Index Scan using t_books_title_category_idx on t_books  (cost=0.42..8.44 rows=1 width=64)
--    Index Cond: (((title)::text = 'Oracle Core'::text) AND ((category)::text = 'Oracle Database'::text))

-- Используется индекс.

EXPLAIN SELECT * FROM t_books WHERE title = 'Oracle Core';
--  Bitmap Heap Scan on t_books  (cost=4.44..16.13 rows=3 width=64)
--    Recheck Cond: ((title)::text = 'Oracle Core'::text)
--    ->  Bitmap Index Scan on t_books_title_category_idx  (cost=0.00..4.44 rows=3 width=0)
--          Index Cond: ((title)::text = 'Oracle Core'::text)

-- Используется индекс.

EXPLAIN SELECT * FROM t_books WHERE category = 'Oracle Database' AND author = 'ALALA';
--  Seq Scan on t_books  (cost=0.00..4494.97 rows=1 width=64)
--    Filter: (((category)::text = 'Oracle Database'::text) AND ((author)::text = 'ALALA'::text))

-- Не используется индекс.

EXPLAIN SELECT * FROM t_books WHERE author = 'ALALA' AND book_id = 1;

--  Index Scan using t_books_id_pk on t_books  (cost=0.42..8.44 rows=1 width=64)
--    Index Cond: (book_id = 1)
--    Filter: ((author)::text = 'ALALA'::text)

-- Используется индекс по book_id (primary key index), по автору не используется индекс.

-- Используя один индекс нельзя поддерждать все виды запросов, нужны разные индексы.