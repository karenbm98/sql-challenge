DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS dept_manager;
DROP TABLE IF EXISTS salaries;
DROP TABLE IF EXISTS titles;
DROP TABLE IF EXISTS dept_emp;

CREATE TABLE employees(
  emp_no INT PRIMARY KEY,
  title_id VARCHAR(50),
  birth_date DATE,
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  sex VARCHAR(10),
  hire_date DATE,
  FOREIGN KEY (title_id) REFERENCES titles(title_id)
);

CREATE TABLE dept_emp(
    emp_no INT NOT NULL,
    dept_no VARCHAR(30) NOT NULL,
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	PRIMARY KEY (emp_no, dept_no)
);

CREATE TABLE departments(
    dept_no VARCHAR(30) PRIMARY KEY NOT NULL,
    dept_name VARCHAR(30)
);

CREATE TABLE dept_manager(
  dept_no VARCHAR(30),
  emp_no INT,
  PRIMARY KEY (dept_no, emp_no),
  FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
  FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

CREATE TABLE salaries(
  emp_no INT PRIMARY KEY,
  salary INT
);

CREATE TABLE titles(
  title_Id VARCHAR(30) PRIMARY KEY,
  title VARCHAR(50)
);

-- List the employee number, last name, first name, sex, and salary of each employee.
SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM employees e
JOIN salaries s ON e.emp_no = s.emp_no;

-- List the first name, last name, and hire date for the employees who were hired in 1986.
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date >= '1986-01-01' AND hire_date <= '1986-12-31';

-- List the manager of each department along with their department number, department name, employee number, last name, and first name.
SELECT d.dept_no, d.dept_name, dm.emp_no, e.last_name, e.first_name
FROM departments d
JOIN dept_manager dm ON d.dept_no = dm.dept_no
JOIN employees e ON dm.emp_no = e.emp_no;

-- List the department number for each employee along with that employee’s employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_no, d.dept_name
FROM employees e
JOIN dept_emp de ON e.emp_no = de.emp_no
JOIN Departments d ON de.dept_no = d.dept_no;

-- List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
SELECT first_name, last_name, sex
FROM Employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

-- List each employee in the Sales department, including their employee number, last name, and first name.
SELECT e.emp_no, e.last_name, e.first_name
FROM Employees e
JOIN dept_emp de ON e.emp_no = de.emp_no
JOIN Departments d ON de.dept_no = d.dept_no
WHERE d.dept_name = 'Sales';

-- List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM Employees e
JOIN dept_emp de ON e.emp_no = de.emp_no
JOIN Departments d ON de.dept_no = d.dept_no
WHERE d.dept_name IN ('Sales', 'Development');

-- List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).
SELECT last_name, COUNT(*) AS frequency
FROM Employees
GROUP BY last_name
ORDER BY frequency DESC;