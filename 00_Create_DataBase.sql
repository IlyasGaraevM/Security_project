use Client

go
if OBJECT_ID(N'Salary', N'U') is not null
drop table Salary
go

go
if OBJECT_ID(N'Employee', N'U') is not null
drop table Employee
go

go
if OBJECT_ID(N'Department', N'U') is not null
drop table Department
go

create table Department(
	dept_id int NOT NULL,
	name varchar(max) NOT NULL
	primary key(dept_id)
)

create table Employee(
	id int NOT NULL,
	first_name varchar(max) NOT NULL,
	last_name  varchar(max) NOT NULL,
	dept_id int NOT NULL,
	mng_id int,
	primary key(id),
	foreign key(dept_id) references Department(dept_id),
	foreign key(mng_id) references Employee(id)
)

create table Salary(
	sal_id int NOT NULL,
	emp_id int NOT NULL,
	amount int NOT NULL,
	paydate date NOT NULL,
	primary key(sal_id),
	foreign key(emp_id) references employee(id) 
)

insert into Department values
(11, 'Департамент корпоративно-инвестиционного бизнеса'),
(12, 'Департамент рисков'),
(13, 'Департамент фронтальных систем')

insert into Employee values
(1,'Константин','Иванов', 11, NULL),
(2,'Петр','Петров', 11, 1),
(3,'Василий','Жлобов', 11, 1),
(4,'Никикта','Хрущев', 12, NULL),
(5,'Леонид','Баранов', 12, 4),
(6,'Рустам','Хамутдинов', 12, 4),
(7,'Артём','Васильев', 13, NULL),
(8,'Антон','Треккер', 13, 7),
(9,'Илья','Окошко', 13, 7),
(10,'Александр','Вжунвжун', 13, 7)

insert into Salary values
(21, 1, 1500, '15-06-2016'),
(22, 1, 8,  '15-06-2016'),
(23, 2, 1600, '15-06-2016'),
(24, 3, 1700, '15-06-2016'),
(25, 4, 1550, '16-06-2016'),
(26, 5, 1500, '16-06-2016'),
(27, 5, 200,  '16-06-2016'),
(28, 6, 1650, '16-06-2016'),
(29, 7, 1530, '17-06-2016'),
(30, 8, 1720, '17-06-2016'),
(31, 9, 1300, '17-06-2016'),
(32, 10, 1400,'17-06-2016')

