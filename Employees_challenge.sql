DROP TABLE Departments, dept_emp, dept_manager, employees,
salaries, titles;

CREATE TABLE Departments (
    dept_no VARCHAR(50)   NOT NULL PRIMARY KEY,
    dept_name VARCHAR(50)   NOT NULL);

CREATE TABLE Dept_emp (
    emp_no INT   NOT NULL,
    dept_no VARCHAR(50)   NOT NULL);

CREATE TABLE dept_manager (
    dept_no VARCHAR(50)  NOT NULL,
    emp_no INT   NOT NULL);

CREATE TABLE employees (
	emp_no INT   NOT NULL PRIMARY KEY,
    emp_title VARCHAR(50)   NOT NULL,
    birth_date DATE   NOT NULL,
    first_name VARCHAR(50)   NOT NULL,
    last_name VARCHAR(50)   NOT NULL,
    sex VARCHAR(50)   NOT NULL,
    hire_date DATE   NOT NULL
);

CREATE TABLE salaries (
	emp_no INT   NOT NULL,
    salary INT   NOT NULL
);

CREATE TABLE titles (
    title_id VARCHAR(50)   NOT NULL PRIMARY KEY,
    title VARCHAR(50)   NOT NULL);

--1)List the employee number, last name, first name, sex, and salary 
--of each employee.
SELECT 
	employees.emp_no,
	employees.last_name,
	employees.first_name,
	employees.sex,
	salaries.salary
FROM employees LEFT JOIN salaries ON 
	employees.emp_no = salaries.emp_no;
	
--2)List the first name, last name, and hire date 
--for the employees who were hired in 1986	

SELECT
	employees.first_name,
	employees.last_name,
	employees.hire_date
FROM employees WHERE EXTRACT(YEAR FROM hire_date)= 1986;

--3)List the manager of each department along with their 
--department number, department name, employee number, 
--last name, and first name.
SELECT
    dept_manager.dept_no,
    departments.dept_name,
    dept_manager.emp_no,
    employees.last_name,
    employees.first_name
FROM
    dept_manager 
INNER JOIN
    employees ON dept_manager.emp_no = employees.emp_no
INNER JOIN
    Departments ON dept_manager.dept_no = departments.dept_no;

--4)List the department number for each employee along with 
---that employee’s employee number, last name, first name, 
---and department name.

SELECT
	departments.dept_no,
	dept_manager.emp_no,
	employees.last_name,
	employees.first_name,
	departments.dept_name
FROM departments
INNER JOIN dept_manager ON departments.dept_no = dept_manager.dept_no
INNER JOIN employees ON dept_manager.emp_no = employees.emp_no;
	
---5)List first name, last name, and sex of each employee whose 
---first name is Hercules and whose last name begins with the letter B.	

SELECT 
	employees.first_name,
	employees.last_name,
	employees.sex
FROM  employees
WHERE employees.first_name = 'Hercules' AND
	  employees.last_name LIKE 'B%';
	  
---6)List each employee in the Sales 
--department, including their employee number,
--last name, and first name.	

SELECT 
	departments.dept_name,
	dept_manager.emp_no,
	employees.last_name,
	employees.first_name
FROM departments
INNER JOIN dept_manager ON departments.dept_no = dept_manager.dept_no
INNER JOIN employees ON dept_manager.emp_no = employees.emp_no
WHERE departments.dept_name = 'Sales';
	  
---7)List each employee in the Sales and Development departments, 
---including their employee number, last name, first name, and 
---department name.
SELECT 
	departments.dept_name,
	dept_manager.emp_no,
	employees.last_name,
	employees.first_name
FROM departments
INNER JOIN dept_manager ON departments.dept_no = dept_manager.dept_no
INNER JOIN employees ON dept_manager.emp_no = employees.emp_no
WHERE departments.dept_name = 'Sales' OR 
	  departments.dept_name= 'Development';
	  
---8)List the frequency counts, in descending order, of all the employee
---last names (that is, how many employees share each last name).	 

SELECT
    last_name,
    COUNT(*) AS frequency
FROM
    employees
GROUP BY
    last_name
ORDER BY
    frequency DESC;
