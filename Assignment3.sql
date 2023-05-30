
/*Ivan Prikhodko 309261209*/

/*1. a.) Create table using the following description.*/
CREATE TABLE employees (
  EMPLOYEE_ID NUMBER(6) NOT NULL,
  FIRST_NAME VARCHAR2(20),
  LAST_NAME VARCHAR2(25) NOT NULL,
  EMAIL VARCHAR2(25) NOT NULL,
  PHONE_NUMBER VARCHAR2(20),
  HIRE_DATE DATE NOT NULL,
  JOB_ID VARCHAR2(10) NOT NULL,
  SALARY NUMBER(8,2),
  COMMISSION_PCT NUMBER(2,2),
  MANAGER_ID NUMBER(6),
  DEPARTMENT_ID NUMBER(4)
);

CREATE TABLE job_history (
  EMPLOYEE_ID NUMBER(6) NOT NULL,
  START_DATE DATE NOT NULL,
  END_DATE DATE NOT NULL,
  JOB_ID VARCHAR2(10) NOT NULL,
  DEPARTMENT_ID NUMBER(4)
);

/*b.) Insert the records into each of the tables as shown below.*/
INSERT INTO employees (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID) VALUES
(176, 'John', 'Taylor', 'Taylor@gmail.com', '412-312-1123', TO_DATE('24-MAR-06', 'DD-MON-YY'), 'SA_REP', 111111.11, 0, 1, 80),
(200, 'Tom', 'Whalen', 'Whalen@gmail.com', '647-399-1111', TO_DATE('24-MAR-00', 'DD-MON-YY'), 'AD_ASST', 999999.99, 0, 1, 10);

INSERT INTO job_history (EMPLOYEE_ID, START_DATE, END_DATE, JOB_ID, DEPARTMENT_ID) VALUES
(176, TO_DATE('24-MAR-06', 'DD-MON-YY'), TO_DATE('31-DEC-06', 'DD-MON-YY'), 'SA_REP', 80),
(200, TO_DATE('24-MAR-00', 'DD-MON-YY'), TO_DATE('17-JUN-01', 'DD-MON-YY'), 'AD_ASST', 10);

/*2. a.) Use Natural join and produce the following output*/
SELECT e.LAST_NAME, j.DEPARTMENT_ID, j.END_DATE, j.JOB_ID, j.EMPLOYEE_ID
FROM employees e
NATURAL JOIN job_history j;

/*b.) Add the following columns to the job_history table: previous_job varchar2(10) current_job varchar2(10)*/
ALTER TABLE job_history
ADD previous_job VARCHAR2(10),
ADD current_job VARCHAR2(10);

/*c.) Insert the records into each of the tables as shown below. */
INSERT INTO employees (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID)
VALUES (102, 'Bobby', 'De Haan', 'DeHaan@gmail.com', '289-400-2121', TO_DATE('13-JAN-01', 'DD-MON-YY'), 'AD_VP', 222222.22, 0.2, 2, 30);

INSERT INTO employees (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID)
VALUES (201, 'Jimmy', 'Hartstein', 'Hartstein@gmail.com', '905-500-3000', TO_DATE('17-FEB-04', 'DD-MON-YY'), 'MK_MAN', 44444444.44, 0.3, NULL, 40);

INSERT INTO job_history (EMPLOYEE_ID, START_DATE, END_DATE, JOB_ID, DEPARTMENT_ID, PREVIOUS_JOB, CURRENT_JOB)
VALUES (176, TO_DATE('24-MAR-06', 'DD-MON-YY'), TO_DATE('31-DEC-06', 'DD-MON-YY'), 'SA_REP', 80, NULL, NULL);

INSERT INTO job_history (EMPLOYEE_ID, START_DATE, END_DATE, JOB_ID, DEPARTMENT_ID, PREVIOUS_JOB, CURRENT_JOB)
VALUES (200, TO_DATE('24-MAR-00', 'DD-MON-YY'), TO_DATE('17-JUN-01', 'DD-MON-YY'), 'AD_ASST', 10, NULL, NULL);

/*3. a.) Update the job_history table so that the previous_job and current_job columns have the data as shown below: */
UPDATE job_history
SET previous_job = (SELECT JOB_ID 
                    FROM job_history AS jh2
                    WHERE jh2.END_DATE < job_history.START_DATE AND
                          jh2.EMPLOYEE_ID = job_history.EMPLOYEE_ID
                    ORDER BY jh2.END_DATE DESC
                    FETCH FIRST ROW ONLY),
    current_job = JOB_ID
WHERE previous_job IS NULL OR current_job IS NULL;

/*b.) Write a query to perform Inner join using the JOIN…ON clause and produce the following output */
SELECT e.employee_id, e.last_name, jh.start_date, e.hire_date, jh.end_date, jh.previous_job, jh.current_job
FROM employees e
JOIN job_history jh ON e.employee_id = jh.employee_id
WHERE e.employee_id IN (102, 176, 201)
ORDER BY e.employee_id, jh.start_date;






