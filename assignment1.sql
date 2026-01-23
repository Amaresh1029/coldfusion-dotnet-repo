
--Creating Database

create database LibraryDB;

use LibraryDB;






--Creating Tables



create table Books	(
id int primary key identity(101, 1),
name varchar(50) not null,
genre varchar(50) not null,
total_quantity int not null
);



create table Members	(
id int primary key identity(201,1),
first_name varchar(20) not null,
middle_name varchar(20),
last_name varchar (20),
date_joined date not null
);

create table BorrowingRecords	(
id int primary key identity(301, 1),
book_id int foreign key references Books(id),
member_id int foreign key references Members(id),
date_borrowed date not null,
date_returned date
);



--Inserting Records



insert into Books values
( 'A Brief History Of Time', 'Science', 3),
( 'A Brief History Of Time', 'Science', 3),
( 'A Brief history Of Time', 'Science', 3),
( 'Brief Answers To Big Questions', 'Science', 4),
( 'Brief Answers To Big Questions', 'Science', 4),
( 'Brief Answers To Big Questions', 'Science', 4),
( 'Brief Answers To Big Questions', 'Science', 4),
( 'Atomic Habits', 'Self-Improvement',2),
( 'Atomic Habits', 'Self-Improvement', 2),
( 'Ikigai', 'Self-Improvement', 3),
( 'Ikigai', 'Self-Improvement', 3),
( 'Ikigai', 'Self-Improvement', 3),
( 'Sherlock Holms', 'Story', 3),
( 'Sherlock Holms', 'Story', 3),
( 'Sherlock Holms', 'Story', 3),
( 'The Alchemist', 'Story', 3),
( 'The Alchemist', 'Story', 3),
( 'Bhagavad Gita', 'Devotional', 2),
( 'Bhagavad Gita', 'Devotional', 2);

--Date: YYYY-MM-DD
Insert Into Members Values 
('Rahul', 'Ganesh', 'Vasavade', '2020-04-22'),
('Anand', 'Sri', 'Apate', '2024-03-18'),
('Hemant', 'Datta', 'Potdar', '2023-04-17'),
('Tripti', 'Shubham', 'Mane', '2021-02-10'),
('Anushka', 'Virat', 'Lokapure', '2026-01-01'),
('Vedika', 'Vishal', 'Sathe', '2025-03-09'),
('Amey', 'Mohan', 'Kittur', '2026-01-09'),
('Uday', 'Hritik', 'Roshan', '2026-01-08'),
('Manika', 'Dipendar', 'Singh', '2025-01-09'),
('Rahul', 'Shivam', 'Patil', '2026-01-08'),
('Vikrant', 'Gajendra', 'Mane', '2024-09-08'),
('Parvati', 'Shivam', 'Kulkarni', '2026-01-01');




--book_id, member_id, date_borrowed, date_returned
Insert into BorrowingRecords values
(101, 201, '2025-11-09', '2025-12-11'),
(103, 204, '2025-12-08', '2025-12-14'),
(107, 211, '2025-10-28', '2025-12-31'),
(119, 206, '2025-03-09', '2025-04-13'),
(110, 207, '2026-01-09', '2026-01-12'),
(102, 211, '2026-01-01', NULL),
(105, 206, '2026-01-08', NULL),
(106, 204, '2025-12-31', NULL),
(108, 205, '2026-01-01', NULL),
(109,206, '2026-01-08', NULL),
(111, 210, '2026-01-08', NULL),
(112, 209, '2025-10-11', NULL),
(115, 212, '2026-01-01', NULL),
(118, 212, '2026-01-01', NULL);






--fetch books by genre


select * from Books
where genre = 'Science';




--list members who recently joined (Assumption: recently joined means from current date 30 days back)


select * from Members
where DATEDIFF(day,date_joined, GETDATE()) <= 30;


--check book availability


--1.check Available

select * from Books
where id  not in (
	select book_id from BorrowingRecords
	where date_returned is null
);

--2. Not availailable

select * from Books
where id in (
	select book_id from BorrowingRecords
	where date_returned is null
);


--generate reports on borrowed books using JOIN.
--Assumption report: Retrieve book name, member full name who used the book more than 10 days and never returned
-- sort the result by book genre

with CTE_Never_Returned as (
select book_id, member_id from BorrowingRecords
where date_returned is null
and DATEDIFF(day, date_borrowed, GETDATE()) > 10
)

select b.name as book_name, m.first_name || ' ' || m.middle_name || ' ' || m.last_name as member_name
from Books b
inner join CTE_Never_Returned cnr
on b.id = cnr.book_id
inner join Members m
on m.id = cnr.member_id
order by b.genre;



--count total borrowed books



--With CTE
with CTE_Total_Borrowed_Books as	(
select member_id, count(*) as number_of_books from BorrowingRecords
where date_returned is null
group by member_id
)

select m.id, m.first_name, m.last_name, 
case 
	when ctb.number_of_books is null then 0
	else	ctb.number_of_books
end as number_of_books_taken
from Members m
left join CTE_Total_Borrowed_Books ctb
on m.id = ctb.member_id;


--identify overdue returns
--Assumption Book Overdue will be Rs. 10 per day after 30 days of Book taken.




--Using CTE
with CTE_Overdue as (
select member_id, 
	sum(
		case 
			when date_returned is null
				and DATEDIFF(day, date_borrowed, GETDATE()) > 30
				then (DATEDIFF(day, date_borrowed, GETDATE()) - 30) * 10  
			when date_returned is not null 
				and DATEDIFF(day, date_borrowed, date_returned) > 30
				then (DATEDIFF(day, date_borrowed, date_returned) - 30) * 10 
			else 0
		end
		) as overdue
from 
BorrowingRecords 
group by member_id
)

select m.id, m.first_name, m.last_name, 
case 
	when co.overdue is NULL then 0
	else co.overdue 
end as overdue
from Members m
left join CTE_Overdue co
on m.id = co.member_id;



--using subqueries
select m.id, m.first_name, m.last_name,
case
	when o.overdue is null then 0
	else o.overdue
end as overdue
from Members m
left join (
	select member_id,
		sum(
		case 
			when date_returned is null
				and DATEDIFF(day, date_borrowed, GETDATE()) > 30
				then (DATEDIFF(day, date_borrowed, GETDATE()) - 30) * 10  
			when date_returned is not null 
				and DATEDIFF(day, date_borrowed, date_returned) > 30
				then (DATEDIFF(day, date_borrowed, date_returned) - 30) * 10 
			else 0
		end
		) as overdue
	from 
	BorrowingRecords 
	group by member_id
) o
on o.member_id = m.id;


