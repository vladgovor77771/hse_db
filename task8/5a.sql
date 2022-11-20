CREATE OR REPLACE FUNCTION get_job_count(
    emp_id IN employees.employee_id % TYPE
)
RETURNS INTEGER LANGUAGE plpgsql AS
$$
    DECLARE
        job_count INTEGER := 0;
    BEGIN
        SELECT COUNT(*) INTO job_count FROM job_history
        WHERE employee_id = emp_id;

        IF (SELECT COUNT(*) FROM employees WHERE employee_id = emp_id) > 0 THEN
            job_count = job_count + 1
        END IF;
        RETURN job_count;
    EXCEPTION
        WHEN NO_DATA_FOUND
            THEN RAISE NOTICE 'Employee % does not exist', emp_id;
    END;
$$