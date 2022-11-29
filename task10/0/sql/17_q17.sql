-- Try to drop all indexes in your schema. Please, explain the result.
-- My schema? public? okay

-- https://stackoverflow.com/questions/34010401/how-can-i-drop-all-indexes-of-a-table-in-postgres

CREATE OR REPLACE FUNCTION drop_all_indexes() RETURNS INTEGER AS $$
DECLARE
  i RECORD;
BEGIN
  FOR i IN (SELECT relname FROM pg_class WHERE relkind = 'i' AND relname NOT LIKE '%_pk%' AND relname NOT LIKE 'pg_%')
  LOOP
    -- RAISE INFO 'DROPING INDEX: %', i.relname;
    EXECUTE 'DROP INDEX ' || i.relname;
  END LOOP;
RETURN 1;
END;
$$ LANGUAGE plpgsql;

SELECT drop_all_indexes();

-- CREATE FUNCTION
--  drop_all_indexes 
-- ------------------
--                 1
