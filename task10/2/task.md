1. Connect to Oracle instance database under &lt;username&gt; (for example, in sqlplus).
2. Execute script students/lesson3/0_create_base.sql to create base table and populate it.
3. Gather statistics for t_books and t_books_part tables.
4. Select from t_books_part data about book with book_id = 18 and get expected execution plan for
this query. Please, explain the result.
5. Select from t_books_part data about book with title &#39;Expert Oracle Database Architecture&#39; and get
expected execution plan for this query. Please, explain the result.
6. Create local partitioned B*Tree index (t_books_part_local_idx) on title column of t_books_part
table.
7. Run the query from step 5 with expected execution plan. Please, explain the result.
8. Drop index t_books_part_local_idx.
9. Create global partitioned B*Tree index (t_books_part_global_idx) on title column of t_books_part
table. Partitioning scheme - by range with three partitions: first with values less than &#39;F&#39;, second
with values less than &#39;T&#39;, third – remaining values.
10. Run the query from step 5 with expected execution plan. Please, explain the result.
11. Drop index t_books_part_global_idx.
12. Create non-partitioned B*Tree index (t_books_part_idx) on book_id column of t_books_part table.
13. Select from t_books_part data about book with book_id = 11011 and get expected execution plan
for this query. Please, explain the result.
14. Create B*Tree index (t_books_active_idx) on is_active column of t_books table.
15. Select from t_books data about active books and get expected execution plan for this query. Use
hint: /*+ INDEX(table_name_or_alias t_books_active_idx) */. Please, explain the result.
16. Create B*Tree index (t_books_author_title_index) on (author, title) columns of t_books table.
17. Select max title for every author from t_books table and get expected execution plan for this query.
Please, explain the result.
18. Select first 10 authors (unique names) in ascending order from t_books table and get expected
execution plan for this query. Please, explain the result.
19. Select author and title from t_books where author starts with &#39;T&#39; table. Sort results by author and
title. Also get expected execution plan for this query. Please, explain the result.
20. Insert new book into t_books table with book_id = 150001, title &#39;Cookbook&#39;, author - &#39;Mr. Hide&#39;, null
category (this book must be active). Commit changes.
21. Create B*Tree index (t_books_cat_idx) on category column of t_books table.
22. Select author and title from t_books table where category is null. Also get expected execution plan
for this query. Please, explain the result.

23. Drop t_books_cat_idx index. Create B*Tree index (t_books_cat_null_idx) on category column of
t_books table, this index must hold null values.
24. Run the query from step 22 with expected execution plan. Please, explain the result.
25. Create your own tables and corresponding indexes to show classic “partial” index in Oracle
Database and “Selective Uniqueness” cases.