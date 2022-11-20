CREATE OR REPLACE PROCEDURE upd_job_sal(
    upd_job_id IN jobs.job_id % TYPE,
    new_min_salary IN jobs.min_salary % TYPE,
    new_max_salary IN jobs.max_salary % TYPE
)
LANGUAGE plpgsql AS
$$
    BEGIN
        UPDATE jobs
        SET
            min_salary = new_min_salary,
            max_salary = new_max_salary
        WHERE job_id = upd_job_id;
    EXCEPTION
        WHEN new_max_salary < new_min_salary
            THEN RAISE NOTICE 'new_max_salary must be more than new_min_salary';
        WHEN NO_DATA_FOUND
            THEN RAISE NOTICE 'Employee % does not exist', emp_id;
    END
$$