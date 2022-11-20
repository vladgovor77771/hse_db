CREATE OR REPLACE PROCEDURE new_job(
    id IN jobs.job_id % TYPE,
    title IN jobs.job_title % TYPE,
    min_sal IN jobs.min_salary % TYPE
)
LANGUAGE plpgsql AS
$$
    DECLARE
        max_sal jobs.max_salary % TYPE = 2 * min_sal;
    BEGIN
        INSERT INTO jobs (job_id, job_title, min_salary, max_salary)
        VALUES (id, title, min_sal, max_sal);
    END
$$
