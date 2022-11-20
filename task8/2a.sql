CREATE OR REPLACE PROCEDURE add_job_hist(
    emp_id IN job_history.employee_id % TYPE,
    new_job_id IN job_history.job_id % TYPE
)
LANGUAGE plpgsql AS
$$
    BEGIN
        INSERT INTO job_history
        SELECT employee_id, hire_date, NOW(), job_id, department_id
        FROM employees
        WHERE employee_id = emp_id;
        UPDATE employees
        SET 
            hire_date = now(),
            job_id = new_job_id,
            salary = (SELECT min_salary + 500 FROM jobs WHERE jobs.job_id = new_job_id)
        WHERE employee_id = emp_id;
    EXCEPTION
        WHEN NO_DATA_FOUND
            THEN RAISE NOTICE 'Employee % does not exist', emp_id;
    END
$$