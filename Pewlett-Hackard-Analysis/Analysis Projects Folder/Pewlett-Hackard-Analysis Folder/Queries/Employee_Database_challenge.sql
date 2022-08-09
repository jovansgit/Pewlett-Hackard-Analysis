--Retrieve the emp_no, first_name, and last_name columns from the Employees table.
--Retrieve the title, from_date, and to_date columns from the Titles table.
--Create a new table using the INTO clause.
--Join both tables on the primary key.
--Filter the data on the birth_date column to retrieve the employees who were born between 1952 and 1955. Then, order by the employee number.
SELECT
   e.emp_no,
   e.first_name,
   e.last_name,
   t.title,
   t.from_date,
   t.to_date INTO retirement_titles 
FROM employees as e 
INNER JOIN titles AS t 
ON (e.emp_no = t.emp_no) 
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no;


SELECT * FROM retirement_titles;


-- Retrieve the employee number, first and last name, and title columns from the Retirement Titles table
-- Use Dictinct with Orderby to remove duplicate rows
-- Exclude those employees that have already left the company by filtering on to_date to keep only those dates that are equal to '9999-01-01'

SELECT DISTINCT ON (rt.emp_no) 
	rt.emp_no,
	rt.first_name,
	rt.last_name,
	rt.title
INTO unique_titles
FROM retirement_titles as rt
where rt.to_date = '9999-01-01'
ORDER BY rt.emp_no ASC, rt.to_date DESC;

SELECT * FROM unique_titles;

-- Write another query to retrieve the number of employees by their most recent job title who are about to retire.
-- First, retrieve the number of titles from the Unique Titles table.
-- Then, create a Retiring Titles table to hold the required information.
-- Group the table by title, then sort the count column in descending order.

SELECT COUNT(ut.emp_no), ut.title 
INTO retiring_titles 
FROM unique_titles as ut 
GROUP BY title 
ORDER BY COUNT(title) DESC;

select * from  retiring_titles


-- Retrieve the emp_no, first_name, last_name, and birth_date columns from the Employees table.
-- Retrieve the from_date and to_date columns from the Department Employee table.
-- Retrieve the title column from the Titles table.
-- Join the Employees and the Department Employee tables on the primary key.
-- Join the Employees and the Titles tables on the primary key.
-- Filter the data on the to_date column to all the current employees, then filter the data on the birth_date columns to get all the employees whose birth dates are between January 1, 1965 and December 31, 1965.
SELECT DISTINCT
   ON(e.emp_no)e.emp_no,
   e.first_name,
   e.last_name,
   e.birth_date,
   de.from_date,
   de.to_date,
   t.title
INTO mentor_eligibility 
FROM employees AS e 
   INNER JOIN
      dept_emp AS de 
      ON (e.emp_no = de.emp_no) 
   INNER JOIN
      titles AS t 
      ON (e.emp_no = t.emp_no) 
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND (de.to_date = '9999-01-01')
ORDER BY emp_no;

select * from mentor_eligibility


--Unique Titles Salaries

SELECT DISTINCT ON (rt.emp_no) 
	rt.emp_no,
	rt.first_name,
	rt.last_name,
	rt.title,
	s.salary
INTO unique_salaries
FROM retirement_titles as rt
   INNER JOIN
      salaries AS s 
      ON (rt.emp_no = s.emp_no) 
where rt.to_date = '9999-01-01'
ORDER BY rt.emp_no ASC, rt.to_date DESC;


select * from unique_salaries

-- Salaries Group By

SELECT sum(us.salary),us.title
INTO retiring_salaries
FROM unique_salaries as us
GROUP BY title 
ORDER BY COUNT(title) DESC;

select * from  retiring_salaries
