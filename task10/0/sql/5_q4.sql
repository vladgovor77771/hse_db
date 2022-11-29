-- Select index_name, index_type, table_name, uniqueness 
-- from pg_indexes view. What is the result? Why?

SELECT * FROM pg_indexes;

-- schemaname  |        tablename        |                   indexname                   | tablespace |                                                                  indexdef                                                        
-- ------------+-------------------------+-----------------------------------------------+------------+----------------------------------------------------------------------------------------------------------------------------------
--  public     | t_books                 | t_books_id_pk                                 |            | CREATE UNIQUE INDEX t_books_id_pk ON public.t_books USING btree (book_id)
--  pg_catalog | pg_proc                 | pg_proc_proname_args_nsp_index                |            | CREATE UNIQUE INDEX pg_proc_proname_args_nsp_index ON pg_catalog.pg_proc USING btree (proname, proargtypes, pronamespace)
--  pg_catalog | pg_type                 | pg_type_typname_nsp_index                     |            | CREATE UNIQUE INDEX pg_type_typname_nsp_index ON pg_catalog.pg_type USING btree (typname, typnamespace)
--  pg_catalog | pg_attribute            | pg_attribute_relid_attnam_index               |            | CREATE UNIQUE INDEX pg_attribute_relid_attnam_index ON pg_catalog.pg_attribute USING btree (attrelid, attname)
--  public     | t_books                 | t_books_title_idx                             |            | CREATE INDEX t_books_title_idx ON public.t_books USING btree (title)
--  pg_catalog | pg_class                | pg_class_relname_nsp_index                    |            | CREATE UNIQUE INDEX pg_class_relname_nsp_index ON pg_catalog.pg_class USING btree (relname, relnamespace)
--  pg_catalog | pg_class                | pg_class_tblspc_relfilenode_index             |            | CREATE INDEX pg_class_tblspc_relfilenode_index ON pg_catalog.pg_class USING btree (reltablespace, relfilenode)
--  pg_catalog | pg_attrdef              | pg_attrdef_adrelid_adnum_index                |            | CREATE UNIQUE INDEX pg_attrdef_adrelid_adnum_index ON pg_catalog.pg_attrdef USING btree (adrelid, adnum)
--  pg_catalog | pg_type                 | pg_type_oid_index                             |            | CREATE UNIQUE INDEX pg_type_oid_index ON pg_catalog.pg_type USING btree (oid)
--  pg_catalog | pg_attribute            | pg_attribute_relid_attnum_index               |            | CREATE UNIQUE INDEX pg_attribute_relid_attnum_index ON pg_catalog.pg_attribute USING btree (attrelid, attnum)
--  pg_catalog | pg_attrdef              | pg_attrdef_oid_index                          |            | CREATE UNIQUE INDEX pg_attrdef_oid_index ON pg_catalog.pg_attrdef USING btree (oid)
--  pg_catalog | pg_constraint           | pg_constraint_conname_nsp_index               |            | CREATE INDEX pg_constraint_conname_nsp_index ON pg_catalog.pg_constraint USING btree (conname, connamespace)
--  pg_catalog | pg_constraint           | pg_constraint_conrelid_contypid_conname_index |            | CREATE UNIQUE INDEX pg_constraint_conrelid_contypid_conname_index ON pg_catalog.pg_constraint USING btree (conrelid, contypid, co
-- nname)
--  pg_catalog | pg_constraint           | pg_constraint_contypid_index                  |            | CREATE INDEX pg_constraint_contypid_index ON pg_catalog.pg_constraint USING btree (contypid)