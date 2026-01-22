---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------

--creating database

---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------

create database EmployeeManagement;

use EmployeeManagement;

---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------

--creating tables

---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------

create table Departments (
id int primary key identity(201, 1),
name varchar(30) not null,
location varchar(30) not null
);

EXEC sp_rename 'Departments.dept_name', 'name', 'COLUMN';
--select * from Departments;

create table Employees (
id int primary key identity(101, 1),
first_name varchar(20) not null,
middle_name varchar(20) not null,
last_name varchar(20) not null,
hire_date date not null,
departmentID int foreign key references Departments(id)
);
alter table Employees
add salary decimal(10, 2);

--select * from Employees;
create table Projects	(
id int primary key identity(301, 1),
name varchar(30) not null,
start_date date not null,
end_date date,
dept_id int foreign key references Departments(id)
);



EXEC sp_rename 'Projects.dept_id', 'departmentID', 'COLUMN';
--select * from Projects;
create table EmployeeProjects	(
employee_id int foreign key references Employees(id),
project_id int foreign key references Projects(id),
role varchar(30) not null,
primary key(employee_id, project_id)
);


---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------

--inserting records

---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------


-- Departments
INSERT INTO Departments (name, location) VALUES
('HR', 'Mumbai'),
('IT', 'Bengaluru'),
('Finance', 'Delhi'),
('Marketing', 'Pune'),
('Operations', 'Hyderabad'),
('Sales', 'Chennai'),
('R&D', 'Bengaluru'),
('Customer Support', 'Kolkata');

-- Employees
INSERT INTO Employees (first_name, middle_name, last_name, hire_date, departmentID, salary) VALUES
('Rahul', 'Hemant', 'Patil', '2022-05-01', 202, 55000),
('Ananya', 'Vikram', 'Sharma', '2021-03-15', 203, 72000),
('Vikram', 'Rajesh', 'Rao', '2020-07-20', 201, 68000),
('Sneha', 'Arun', 'Joshi', '2021-11-10', 204, 50000),
('Karan', 'Prakash', 'Mehta', '2020-02-18', 205, 60000),
('Priya', 'Suresh', 'Nair', '2022-09-25', 206, 58000),
('Rohit', 'Anil', 'Kapoor', '2019-12-05', 207, 75000),
('Meena', 'Rajiv', 'Desai', '2023-03-14', 208, 52000),
('Arjun', 'Mahesh', 'Iyer', '2021-07-22', 205, 64000),
('Neha', 'Vikas', 'Kulkarni', '2020-08-30', 203, 67000),
('Siddharth', 'Ramesh', 'Menon', '2022-01-19', 201, 56000),
('Pooja', 'Vivek', 'Chopra', '2023-04-11', 204, 61000),
('Amit', 'Sunil', 'Verma', '2020-06-17', 205, 59000),
('Divya', 'Ashok', 'Pillai', '2021-09-09', 206, 63000),
('Nikhil', 'Ravi', 'Bhat', '2019-10-28', 207, 70000),
('Shreya', 'Deepak', 'Reddy', '2022-12-01', 208, 54000),
('Manish', 'Gopal', 'Shah', '2023-05-20', 202, 72000),
('Ritika', 'Ajay', 'Gupta', '2020-03-07', 203, 56000),
('Varun', 'Sanjay', 'Malhotra', '2021-08-15', 201, 65000),
('Anjali', 'Kiran', 'Singh', '2022-02-02', 204, 53000),
('Suresh', 'Harish', 'Patel', '2023-07-12', 205, 60000),
('Komal', 'Vinod', 'Jain', '2020-11-23', 206, 58000),
('Rajesh', 'Mohan', 'Chatterjee', '2021-01-30', 207, 69000);
-- Projects
select * from Employees;
INSERT INTO Projects (name, start_date, departmentID) VALUES
('Payroll Automation', '2023-01-01', 203),
('Recruitment Portal', '2023-06-01', 201),
('Cloud Migration', '2024-02-01', 202),
('Marketing Campaign 2024', '2024-03-01', 204),
('Supply Chain Optimization', '2023-09-15', 205),
('Sales Dashboard', '2024-01-10', 206),
('Product Innovation Lab', '2023-05-05', 207),
('Customer Feedback System', '2024-04-20', 208),
('Employee Wellness Program', '2023-07-01', 202),
('Cybersecurity Upgrade', '2024-02-15', 203),
('Data Warehouse Migration', '2023-11-11', 201),
('Mobile App Development', '2024-05-01', 204),
('AI Chatbot Integration', '2024-06-12', 205);


-- EmployeeProjects
INSERT INTO EmployeeProjects VALUES
(101, 301, 'Developer'),
(102, 302, 'Analyst'),
(103, 303, 'Manager'),
(104, 304, 'Coordinator'),
(105, 305, 'Analyst'),
(106, 306, 'Sales Executive'),
(107, 307, 'Researcher'),
(108, 308, 'Support Agent'),
(109, 309, 'HR Specialist'),
(110, 310, 'Security Engineer'),
(111, 311, 'Data Analyst'),
(112, 312, 'Developer'),
(113, 313, 'Tester'),
(114, 304, 'Designer'),
(115, 305, 'Operations Manager'),
(116, 306, 'Sales Analyst'),
(117, 307, 'Product Manager'),
(118, 308, 'Customer Success'),
(119, 309, 'Wellness Coach'),
(120, 310, 'Cybersecurity Lead'),
(121, 311, 'Database Admin'),
(122, 312, 'Mobile Developer'),
(123, 313, 'AI Engineer');


delete from Employees;
delete from EmployeeProjects;
delete from Departments;
delete from Projects;

select * from Departments;
select * from Employees;
select * from EmployeeProjects;
select * from Projects;

---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------

--Update a specific record based on a condition (e.g., increase salary for employees in IT).

---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------

update Employees
set salary = salary + salary * 0.2
where id in (select e.id from Employees e
	inner join EmployeeProjects ep
	on e.id = ep.employee_id
	where ep.role = 'Developer'
	);

---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------

--Delete a record based on a specific condition.
--remove testers from record.

---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------

/*
create or alter trigger deleteEmployees
on EmployeeProjects
after delete
as
begin
	delete e from Employees e
	inner join deleted d
	on e.id = d.employee_id;
end
*/
update EmployeeProjects
set employee_id = null
where role = 'Tester';

DELETE 
FROM Employees 
where id not in (select employee_id from EmployeeProjects);
--or
delete from Employees 
where not exists (select 1 from EmployeeProjects ep where Employees.id = ep.employee_id);

---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------

--Implement a transaction (COMMIT, ROLLBACK) for safe modifications.

---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------

begin transaction t1

begin try
	select top 1 * from Employees
	order by id desc

	insert into Employees
	values
	('Rohan', 'Nayak', 'Phalake', '2022-05-01', 201, 55000);
	
	select top 1 * from Employees
	order by id desc
	commit;
	print('commited successfully');
end try

begin catch
	print('Rollback to t1: Please check the values inside insert command');
	rollback;
end catch

---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------

--Create a stored procedure. 
--Assumption: Update salary of the employee based on role. Show the projects availaible for a role

---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------

create or alter procedure P_ProjectsByRole
@role varchar(50),
@inc decimal(10, 5)
as
begin
	--before update
	select id, salary from Employees
	where id in (select employee_id from EmployeeProjects
	where role = @role
	);

	update Employees
	set salary = salary + salary * @inc
	where id in (select employee_id from EmployeeProjects
		where role = @role
	);

	--after update
	select id, salary from Employees
	where id in (select employee_id from EmployeeProjects
	where role = @role
	); 
	
	--showing projects
	select 
	ep.role, 
	p.name
	from EmployeeProjects ep
	inner join Projects p
	on ep.project_id = p.id
	where role = @role;

end

exec P_ProjectsByRole 'Developer', 0.10;

---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------

--create a view
--list the employees & their projects whose department is in Pune, Bangalore and Mumbai

---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------

create view V_EmployeesWithProjectID as
(
	select 
	e.id as employee_id, 
	e.first_name || ' ' || e.middle_name || ' ' || e.last_name as full_name,
	e.departmentID,
	ep.project_id
	from Employees e
	inner join EmployeeProjects ep
	on e.id = ep.employee_id
)


select 
ep.employee_id,
ep.full_name,
p.name
from V_EmployeesWithProjectID ep
inner join Projects p
on ep.project_id = p.id
where ep.departmentID in (select id from Departments
			where location in ('Pune', 'Mumbai', 'Bengaluru')
			);


---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------

--Create an AFTER INSERT trigger to log new employee entries into an AuditLog table.

---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------

create table EmployeeLogs	(
id int primary key,
full_name varchar(100),
logMessage varchar(100),
logDate date
);

create or alter trigger T_LogNewEmployees
on Employees
after insert
as
begin
	insert into EmployeeLogs (id, full_name, logMessage, logDate)
	select
	id,
	first_name || ' ' || middle_name || ' ' || last_name,
	'New Employee joined',
	getdate()
	from inserted
end

insert into Employees
values
('Trisha', 'Kuldeep', 'Patil', getdate(), 204, 60000);

select * from EmployeeLogs;

---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------

--Implement an INSTEAD OF DELETE trigger to prevent accidental deletion of records.

---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------

create or alter trigger T_Prevent_Deletion
on Employees
instead of Delete
as
begin
	print 'You do not have permission to delete'

end

delete Employees

select * from Employees;

---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------

--Write a cursor that loops through employee salaries and applies a bonus based on a certain condition.
--condition: raise salary of employees whose salary is less than 60000 and
--they have role in developer or any kind of Analyst

---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------

declare @id int,
		@salary int
declare cursor_update_salary cursor
for 
	select e.id, e.salary from Employees e
	inner join EmployeeProjects ep
	on e.id = ep.employee_id
	where ep.role = 'Developer' or
		ep.role like '%Analyst%';

open cursor_update_salary
print 'cursor opened'
fetch next from cursor_update_salary into @id, @salary

while @@fetch_status = 0
	begin
		
		if @salary < 70000
			begin
				update Employees
				set salary = salary + salary * 0.1
				where id = @id
			end
		fetch next from cursor_update_salary into @id, @salary
	end

close cursor_update_salary

deallocate cursor_update_salary;

---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------

--Optimizing performance by using set-based queries instead of cursors

---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------


update Employees
set salary = salary - salary * 0.1
where id in (
	select e.id from Employees e
	inner join EmployeeProjects ep
	on e.id = ep.employee_id
	where e.salary < 70000
	and (ep.role = 'Developer' or
			ep.role like '%Analyst%'
		)
	);




