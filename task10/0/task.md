1. Execute script students/lesson2/0_create_base.sql to create base table and populate it.
2. Select from t_books data about book with title &#39;Oracle Core&#39; and get expected execution plan for
this query (in Oracle: SET AUTOTRACE ON – SET AUTOTRACE OFF; in postgresql: EXPLAIN). Please,
explain the result.
3. Create B*Tree index with name t_books_title_idx on title column of t_books table, create B*Tree
index (t_books_active_idx) on is_active column of t_books.
4. Select index_name, index_type, table_name, uniqueness from pg_indexes view. What is the
result? Why?
5. Gather statistics for t_books table: EXEC DBMS_STATS.GATHER_TABLE_STATS(USER, &#39;t_books&#39;,
CASCADE =&gt; TRUE);
6. Select from t_books data about book with title &#39;Oracle Core&#39; and get expected execution plan for
this query. Please, explain the result.
7. Select from t_books data about book with book_id = 18 and get expected execution plan for this
query. Please, explain the result.
8. Select from t_books data about active books and get expected execution plan for this query. Please,
explain the result.
9. Select number of row in table t_books, distinct values on column title, distinct values in column
category, distinct values in column author.
10. Drop indexes on title and is_active columns from t_books table.
11. Based on previous counts try to create an index that satisfies the following predicates and explain
your solution, please:
a. b.title = :v1 and b.category = :v2
b. b.title = :v1
c. b.category = :v1 and b.author = :v2
d. b.author = :v1 and b.book_id = :v2
12. Test your solution. Please, explain the results.
13. Select from t_books data about book with title starting with &#39;Relational&#39; (case-insensitive) and get
expected execution plan for this query. Please, explain the result.
14. Create B*Tree index (t_books_up_title_idx) on UPPER(title) expression of t_books table.
15. Run the query from step 15 with expected execution plan. Please, explain the result.
16. Select from t_books data about book with substring &#39;Core&#39; (case-insensitive) in title (in any position
in title) and get expected execution plan for this query. Please, explain the result.
17. Try to drop all indexes in your schema. Please, explain the result.
18. Create reverse B*Tree index (t_books_rev_title_idx) on title column of t_books table.

a. Analyze index (EXPLAIN ANALYZE index_name), select height, lf_blks, br_blks,
btree_space, opt_cmpr_count, opt_cmpr_pctsave from index_stats view. Explain the
result.
b. Compress t_books_rev_title_idx on opt_cmpr_count and analyze index again. Explain the
result.

19. Select from t_books data about book with title &#39;Oracle Core&#39; and get expected execution plan for
this query. Please, explain the result.
20. Select from t_books data about book with title starting with &#39;Relational&#39; (case-insensitive) and get
expected execution plan for this query. Please, explain the result.
21. Create your own example of descending B*Tree index.