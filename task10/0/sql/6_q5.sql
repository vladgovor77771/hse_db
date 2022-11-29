-- Gather statistics for t_books table: 
-- EXEC DBMS_STATS.GATHER_TABLE_STATS(USER, 't_books', CASCADE => TRUE);

ANALYZE VERBOSE t_books;

-- INFO:  analyzing "public.t_books"
-- INFO:  "t_books": scanned 1981 of 1981 pages, containing 167598 live rows and 3 dead rows; 30000 rows in sample, 167598 estimated total rows
-- ANALYZE