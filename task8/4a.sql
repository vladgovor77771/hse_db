CREATE OR REPLACE FUNCTION get_years_service(
    emp_id IN employees.employee_id % TYPE
)
RETURNS INTEGER LANGUAGE plpgsql AS
$$
    DECLARE
        start_year INTEGER;
        years_count INTEGER;
    BEGIN
        SELECT date_part('year', start_date) INTO start_year FROM job_history
        WHERE employee_id = emp_id
        ORDER BY start_date
        LIMIT 1;

        SELECT date_part('year', NOW()) - start_year INTO years_count;
        RETURN years_count;
    EXCEPTION
        WHEN NO_DATA_FOUND
            THEN RAISE NOTICE 'Employee % does not exist', emp_id;
    END;
$$