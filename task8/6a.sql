CREATE OR REPLACE FUNCTION validate_salaries(
    upd_job_id IN jobs.job_id % TYPE,
    new_min_salary IN jobs.min_salary % TYPE,
    new_max_salary IN jobs.max_salary % TYPE
)
RETURNS trigger AS
$$
    DECLARE
        more_than_max INTEGER := 0;
        less_than_min INTEGER := 0;
    BEGIN
        SELECT COUNT(*) INTO more_than_max FROM employees
        WHERE job_id = upd_job_id AND salary > new_max_salary;

        SELECT COUNT(*) INTO less_than_min FROM employees
        WHERE job_id = upd_job_id AND salary < new_min_salary;

        IF more_than_max > 0 OR less_than_min > 0 THEN
            RAISE EXCEPTION 'Validation error';
        END IF;
        RETURN NEW;
    END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER check_sal_range
    BEFORE UPDATE ON jobs
    FOR EACH ROW
    EXECUTE FUNCTION validate_salaries(NEW.job_id, NEW.min_salary, NEW.max_salary);