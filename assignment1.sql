---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------

--Creating Database

---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------

create database LibraryDB;

use LibraryDB;





---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------

--Creating Tables

---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------


create table Books	(
id int primary key identity(101, 1),
is_available bit not null,
name varchar(50) not null,
genre varchar(50) not null,
total_quantity int not null
);

create table Members	(
id int primary key identity(201,1),
first_name varchar(20) not null,
middle_name varchar(20) not null,
last_name varchar (20) not null,
date_joined date not null
);

create table BorrowingRecords	(
id int primary key identity(301, 1),
book_id int foreign key references Books(id),
member_id int foreign key references Members(id),
date_borrowed date not null,
date_returned date
);


---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------

--Inserting Records

---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------


insert into Books values
(1, 'A Brief History Of Time', 'Science', 3),
(0, 'A Brief History Of Time', 'Science', 3),
(1, 'A Brief history Of Time', 'Science', 3),
(1, 'Brief Answers To Big Questions', 'Science', 4),
(0, 'Brief Answers To Big Questions', 'Science', 4),
(0, 'Brief Answers To Big Questions', 'Science', 4),
(1, 'Brief Answers To Big Questions', 'Science', 4),
(0, 'Atomic Habits', 'Self-Improvement',2),
(0, 'Atomic Habits', 'Self-Improvement', 2),
(1, 'Ikigai', 'Self-Improvement', 3),
(0, 'Ikigai', 'Self-Improvement', 3),
(0, 'Ikigai', 'Self-Improvement', 3),
(1, 'Sherlock Holms', 'Story', 3),
(1, 'Sherlock Holms', 'Story', 3),
(0, 'Sherlock Holms', 'Story', 3),
(1, 'The Alchemist', 'Story', 3),
(1, 'The Alchemist', 'Story', 3),
(0, 'Bhagavad Gita', 'Devotional', 2),
(1, 'Bhagavad Gita', 'Devotional', 2);
Insert Into Members Values 
('Hemant', 'Datta', 'Potdar', '2023-04-17')
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

select * from Members;



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



select * from BorrowingRecords;

drop table BorrowingRecords;


---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------

--fetch books by genre

---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------

select * from Books
where genre = 'Science';




---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------

--list members who recently joined (Assumption: recently joined means from current date 30 days back)

---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------

select * from Members
where DATEDIFF(day,date_joined, GETDATE()) <= 30;

---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------

--check book availability

---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------

--1.check Available
select * from Books
where is_available = 1;

--or
select * from Books
where id  not in (
	select book_id from BorrowingRecords
	where date_returned is null
);

--2. Not availailable
select * from Books
where is_available = 0;

--or
select * from Books
where id in (
	select book_id from BorrowingRecords
	where date_returned is null
);

---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------

--generate reports on borrowed books using JOIN.
--Assumption report: Retrieve book name, member full name who used the book more than 10 days and never returned
-- sort the result by book genre

---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------

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


---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------

--count total borrowed books

---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------

/*select m.id, count(*) as number_of_books_taken
from Members m
left join BorrowingRecords br
on m.id = br.member_id
where br.date_returned is NULL
and br.date_borrowed is not NULL
group by m.id;
*/

-------------------------------------------------------------------------------------------------
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

----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------

--identify overdue returns
--Assumption Book Overdue will be Rs. 10 per day after 30 days of Book taken.

---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------

/*select m.id as member_id, 
	sum(
		case 
			when br.date_returned is null
				and DATEDIFF(day, br.date_borrowed, GETDATE()) > 30
				then (DATEDIFF(day, br.date_borrowed, GETDATE()) - 30) * 10  
			when br.date_returned is not null 
				and DATEDIFF(day, br.date_borrowed, br.date_returned) > 30
				then (DATEDIFF(day, br.date_borrowed, br.date_returned) - 30) * 10 
			else 0
		end
		) as overdue
from 
Members m
left join
BorrowingRecords br
on m.id = br.member_id
group by m.id;
*/
--|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
----------------------------------------------------------------------------------
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
--|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
-------------------------------------------------------------------------------------------
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


---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------

-- retrieve details of members who haven't brought atleast one book

---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------

select * from members m
where not exists (select 1 from BorrowingRecords br
					where br.member_id = m.id);


---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------

--retrieve books genre and it's count of how many times they are taken in descending order limit the result by 3

---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------

select top 3 b.genre, count(*) as number_of_times_borrowed from Books b
inner join BorrowingRecords br
on b.id = br.book_id
group by b.genre
order by count(*) desc;

---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------

--view

---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
drop view V_Overdue;
create view V_Overdue as	
select member_id, 
	sum(case 
			when date_returned is null 
					and	datediff(day, date_borrowed, GETDATE()) > 30
				then (datediff(day, date_borrowed, getdate()) - 30) * 10
			when date_returned is not null
				and datediff(day, date_borrowed, date_returned) > 30
				then (datediff(day, date_borrowed, date_returned) - 30) * 10
			else 0
		end 
		) as overdue
	from BorrowingRecords
group by member_id;


select 
m.first_name || ' ' || m.last_name as full_name,
case 
	when vo.overdue is null then 0
	else vo.overdue
end as overdue
from Members m
left join V_Overdue vo
on m.id = vo.member_id;


---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------

--- Create a stored procedure that, given a member_id, returns all books currently borrowed by that member.


---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------

create or alter procedure P_Books_Borrowed
@member_id int
as
begin
	
	select br.member_id, b.name as book_name from Books b
	inner join BorrowingRecords br
	on b.id = br.book_id
	where br.member_id = @member_id
	
end;

declare @start int = 201, @end int = 212;
while @start <= @end
begin
	--print 'id: ' + cast(@start as varchar(100));
	exec P_Books_Borrowed @start;
	set @start += 1;
end

---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------

--- Write a query to update is_available to 0 when a book is borrowed and back to 1 when returned.

---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------

create or alter procedure P_Update_is_available
@book_id int, @member_id int, @date_borrowed date, @date_returned date = null
as
begin
	if @date_returned is null
	begin
		insert into BorrowingRecords(book_id, member_id, date_borrowed)
		values
		(@book_id, @member_id, @date_borrowed);
	

		update Books
		set is_available = 0
		where id = @book_id;
	end

	else
	begin
		update BorrowingRecords
		set date_borrowed = @date_borrowed
		where book_id = @book_id
		and member_id = @member_id;
	

		update Books
		set is_available = 1
		where id = @book_id;
	end
	select * from Books
	where id = @book_id;

end
-----------------------------------------------


exec P_Update_is_available 101, 202, '2026-01-16';


---------------------------------------------


DECLARE @today DATE = CAST(GETDATE() AS DATE);

EXEC P_Update_is_available  
    @book_id = 101,  
    @member_id = 202,  
    @date_borrowed = @today,
	@date_returned = @today;


select top 3 * from BorrowingRecords
order by id desc;


create or alter procedure P_recursion
@num int
as
begin
	if @num <= 0 return;


	print(cast(@num as varchar) + ' ');
	
	set @num -= 1;
	exec P_recursion @num
end

exec P_recursion 10;


---------------------------------------------------------------------
drop view V_table;
create view V_table as
(
select * from Members
);

select * from V_table;

-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------

--Triggers

-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------

use LibraryDB;

CREATE TABLE BooksLogs (
    logID INT IDENTITY(1,1) PRIMARY KEY,   -- auto-generated log entry ID
    bookID INT NOT NULL,                   -- references Books.id
    logMessage VARCHAR(255) NOT NULL,      -- message text
    logDate DATETIME NOT NULL              -- timestamp
);

create or alter trigger T_InsertBook
on Books
after insert
as
begin
	insert into BooksLogs (bookID, logMessage, logDate)
	select
	id, 
	'New Book Added: ' + cast(id as varchar),
	GETDATE()
	from inserted;
end;

insert into Books
values
(1, '40 Laws of Power', 'Battle Strategies', 1);

select * from BooksLogs;
select * from Books;

create table deletedBooks (
id int primary key,
logMessage varchar(50) not null,
logDate date not null
);

create or alter trigger T_DeletedRecords
on Books
after delete
as
begin
	insert into deletedBooks (id, logMessage, logDate)
	select
	id,
	'Deleted book ID: ' + cast(id as varchar),
	getdate()
	from deleted
end

delete from Books
where name = '40 Laws of Power';
select * from deletedBooks;

create table memberUpdateLogs	(
id int primary key identity(101, 1),
member_id int not null,
logMessage varchar(50) not null,
logDate date not null
);

create or alter trigger T_UpdateMember
on Members
after update
as
begin
	insert into memberUpdateLogs(member_id, logMessage, logDate)
	select
	id,
	'Updated member id: ' + cast(id as varchar),
	GETDATE()
	from inserted;
end

update Members
set first_name = 'Shantanu'
where first_name = 'Vikrant';

select * from memberUpdateLogs;te

create or alter trigger InseadOf
on Members
instead of delete
as
begin
	print 'you don''t have permission to delete';
end

delete from Members
where id not in (select member_id from BorrowingRecords);
select * from Members;



-----------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------

--cursors

-----------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------

--forward_only static cursors
--default it is forward_only dynamic
declare @var_name int

declare Cur cursor
forward_only static
for
	select id from Members;


open cur
print	'cursor is open'

fetch next from cur into @var_name

while @@FETCH_STATUS = 0
	begin
		print cast(@var_name as varchar);
		fetch next from cur into @var_name;
	end
close cur
deallocate cur

---for dynamic cursors, we can move forward, backward also
fetch last from cur into @var_name;
fetch prior from cur into @var_name;

fetch first from cur into @var_name;
fetch next from cur into @var_name;

update Books
set name = 'Power'
where name like '%Power%';

declare @id int
declare @isAvailable bit
declare @name varchar(50)
declare @genre varchar(50)
declare @quantity int

declare cur_dynamic cursor
dynamic for
	select id, is_available, name, genre, total_quantity from Books

open cur_dynamic
print 'cursor is open'
fetch first from cur_dynamic into @id, @isAvailable, @name, @genre, @quantity

while @@FETCH_STATUS = 0
	begin 
		waitfor delay '00:00:01'
		print 'Book name: ' + @name + ' Book Genre: ' + @genre
		fetch next from cur_dynamic into @id, @isAvailable, @name, @genre, @quantity	
	end

close cur_dynamic

deallocate cur_dynamic


--static cursor
declare @name varchar(50)
declare	@genre varchar(50)

declare cur_static cursor
static for
	select name, genre from Books

open cur_static
print 'cursor is open'

fetch last from cur_static into @name, @genre
while @@FETCH_STATUS = 0
	begin
		print 'Book name: ' + @name + ', Book Genre: ' + @genre
		fetch prior from cur_static into @name, @genre
	end

close cur_static

deallocate cur_static

--static cursor absolute(practise)

declare @name varchar(50),
		@genre varchar(50)
declare cur_static cursor
static for
	select name, genre from Books

open cur_static
print 'cursor is open'
fetch absolute 4 from cur_static into @name, @genre

while @@fetch_status = 0
	begin
	waitfor delay '00:00:05'
		print 'name: ' + @name + ', genre: ' + @genre
		fetch next from cur_static into @name, @genre
	end

close cur_static

deallocate cur_static


--keyset cursor
--if insering record, cursor will not have inserted record
--if updated non-key value, cursor will show updated result
--if updated key-value, it will return -2
--if deleted rows then it will return -2
--keyset cursors are scrollable
--if we aren't using any key-value then the keyset cursor will behave like static cursor
--by using 'where current of' we can update inside a cursor

declare @id int,
		@name varchar(50),
		@genre varchar(50)

declare cursor_keyset cursor
keyset for
select id, name, genre from Books1



open cursor_keyset
print 'cursor is open'
fetch first from cursor_keyset into @id, @name, @genre

while @@fetch_status = 0
	begin
		waitfor delay '00:00:01'
		print 'Book id: ' + cast(@id as varchar) + 'Book name: ' + @name + ', Book genre: ' + @genre
		fetch next from cursor_keyset into @id, @name, @genre
		print @@fetch_status
	end

close cursor_keyset

deallocate cursor_keyset
----------------------------------------
--parallely run below queries
update Books
set name = 'Power1234'
where name like '%Power%';



update Books1
set id = 121
where id = 124;

use LibraryDB

create table Books1	(
id int primary key,
is_available bit not null,
name varchar(50) not null,
genre varchar(50) not null,
total_quantity int not null
);

insert into Books1 
select * from Books;