-- Select from t_books data about book with title starting with 
-- 'Relational' (case-insensitive) and get expected execution 
-- plan for this query. Please, explain the result.

EXPLAIN SELECT * FROM t_books WHERE lower(title) ^@ 'relational';

--  Seq Scan on t_books  (cost=0.00..4494.97 rows=838 width=64)
--    Filter: (lower((title)::text) ~~ 'relational%'::text)

-- Индекс не используется. Даже если сделать индекс только по title и сделать case-sensitive запрос.
-- https://www.cybertec-postgresql.com/en/postgresql-more-performance-for-like-and-ilike-statements/
-- тут пишут, что для LIKE запросов нужен индекс типа gist.