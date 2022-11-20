CREATE TABLE regions (
    region_id INTEGER PRIMARY KEY CONSTRAINT region_id_nn NOT NULL,
    region_name VARCHAR(25)
);

CREATE TABLE countries (
    country_id CHAR(2) PRIMARY KEY CONSTRAINT country_id_nn NOT NULL,
    country_name VARCHAR(40),
    region_id INTEGER
);

ALTER TABLE
    countries
ADD
    CONSTRAINT countr_reg_fk FOREIGN KEY (region_id) REFERENCES regions(region_id);

CREATE TABLE locations (
    location_id INTEGER PRIMARY KEY,
    street_address VARCHAR(40),
    postal_code VARCHAR(12),
    city VARCHAR(30) CONSTRAINT loc_city_nn NOT NULL,
    state_province VARCHAR(25),
    country_id CHAR(2)
);

ALTER TABLE
    locations
ADD
    CONSTRAINT loc_c_id_fk FOREIGN KEY (country_id) REFERENCES countries(country_id);

CREATE SEQUENCE locations_seq START WITH 3300 INCREMENT BY 100 MAXVALUE 9900;

CREATE TABLE departments (
    department_id INTEGER PRIMARY KEY,
    department_name VARCHAR(30) CONSTRAINT dept_name_nn NOT NULL,
    manager_id INTEGER,
    location_id INTEGER REFERENCES locations (location_id)
);

CREATE SEQUENCE departments_seq START WITH 280 INCREMENT BY 10 MAXVALUE 9990;

CREATE TABLE jobs (
    job_id VARCHAR(10) PRIMARY KEY,
    job_title VARCHAR(35) CONSTRAINT job_title_nn NOT NULL,
    min_salary INTEGER,
    max_salary INTEGER
);

CREATE TABLE employees (
    employee_id INTEGER PRIMARY KEY,
    first_name VARCHAR(20),
    last_name VARCHAR(25) CONSTRAINT emp_last_name_nn NOT NULL,
    email VARCHAR(25) CONSTRAINT emp_email_nn NOT NULL,
    phone_INTEGER VARCHAR(20),
    hire_date DATE CONSTRAINT emp_hire_date_nn NOT NULL,
    job_id VARCHAR(10) REFERENCES jobs(job_id) CONSTRAINT emp_job_nn NOT NULL,
    salary NUMERIC(8, 2),
    commission_pct NUMERIC(2, 2),
    manager_id INTEGER,
    department_id INTEGER REFERENCES departments(department_id),
    CONSTRAINT emp_salary_min CHECK (salary > 0),
    CONSTRAINT emp_email_uk UNIQUE (email)
);

ALTER TABLE
    employees
ADD
    CONSTRAINT emp_manager_fk FOREIGN KEY (manager_id) REFERENCES employees;

ALTER TABLE
    departments
ADD
    CONSTRAINT dept_mgr_fk FOREIGN KEY (manager_id) REFERENCES employees (employee_id);

CREATE SEQUENCE employees_seq START WITH 207 INCREMENT BY 1;

CREATE TABLE job_history (
    employee_id INTEGER CONSTRAINT jhist_employee_nn NOT NULL,
    start_date DATE CONSTRAINT jhist_start_date_nn NOT NULL,
    end_date DATE CONSTRAINT jhist_end_date_nn NOT NULL,
    job_id VARCHAR(10) REFERENCES jobs(job_id) CONSTRAINT jhist_job_nn NOT NULL,
    department_id INTEGER REFERENCES departments(department_id),
    CONSTRAINT jhist_date_interval CHECK (end_date > start_date),
    PRIMARY KEY (employee_id, start_date)
);

CREATE
OR REPLACE VIEW emp_details_view (
    employee_id,
    job_id,
    manager_id,
    department_id,
    location_id,
    country_id,
    first_name,
    last_name,
    salary,
    commission_pct,
    department_name,
    job_title,
    city,
    state_province,
    country_name,
    region_name
) AS
SELECT
    e.employee_id,
    e.job_id,
    e.manager_id,
    e.department_id,
    d.location_id,
    l.country_id,
    e.first_name,
    e.last_name,
    e.salary,
    e.commission_pct,
    d.department_name,
    j.job_title,
    l.city,
    l.state_province,
    c.country_name,
    r.region_name
FROM
    employees e,
    departments d,
    jobs j,
    locations l,
    countries c,
    regions r
WHERE
    e.department_id = d.department_id
    AND d.location_id = l.location_id
    AND l.country_id = c.country_id
    AND c.region_id = r.region_id
    AND j.job_id = e.job_id;