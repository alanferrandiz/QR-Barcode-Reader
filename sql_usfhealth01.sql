if object_id('tb_players') is not null
	drop table tb_players
go
create table tb_players
(
		ply_id				int,
		ply_first_name		varchar(400),
		ply_last_name		varchar(400),
		ply_email			varchar(400),
		ply_birthdate		date,
		ply_picture			varchar(max),
		ply_height			varchar(400)
)
go

if object_id('tb_access_audit') is not null
	drop table tb_access_audit
go
create table tb_access_audit
(
		aa_id				int identity,
		usr_id				int,
		ply_id				int,
		aa_date				date,
		aa_time				time
)
go

if object_id('tb_users') is not null
	drop table tb_users
go
create table tb_users
(
		usr_id				int,
		usr_first_name		varchar(400),
		usr_last_name		varchar(400)
)
go

if object_id('usp_players_select_by_id') is not null
	drop procedure usp_players_select_by_id
go
create procedure usp_players_select_by_id(@ply_id int = 1)
as
select * from tb_players where ply_id = @ply_id
go

insert into tb_players (ply_id, ply_first_name, ply_last_name, ply_email, ply_birthdate, ply_picture, ply_height)
values (1, 'Alan', 'Ferrandiz', 'aferrandiz@usf.edu', '1982-02-04', 'ply_1.jpg', '5''6"')
insert into tb_players (ply_id, ply_first_name, ply_last_name, ply_email, ply_birthdate, ply_picture, ply_height)
values (2, 'Walter', 'Silva','wsilva@usf.edu', '1974-09-18', 'ply_2.jpg', '5''8"')
insert into tb_players (ply_id, ply_first_name, ply_last_name, ply_email, ply_birthdate, ply_picture, ply_height)
values (3, 'Diego', 'Guillen', 'dguillen@usf.edu', '1988-03-13', 'ply_3.jpg', '5''10"')
insert into tb_players (ply_id, ply_first_name, ply_last_name, ply_email, ply_birthdate, ply_picture, ply_height)
values (4, 'Weimar', 'Ardila', 'wardila@usf.edu', '1989-10-02', 'ply_4.jpg', '5''9"')
insert into tb_players (ply_id, ply_first_name, ply_last_name, ply_email, ply_birthdate, ply_picture, ply_height)
values (5, 'Ana', 'Jones', 'ajones@usf.edu', '1984-01-19', 'ply_5.jpg', '5''3"')
insert into tb_players (ply_id, ply_first_name, ply_last_name, ply_email, ply_birthdate, ply_picture, ply_height)
values (6, 'Joe', 'Smith', 'jsmith@usf.edu', '1978-09-29', 'ply_6.jpg', '6''1"')
insert into tb_players (ply_id, ply_first_name, ply_last_name, ply_email, ply_birthdate, ply_picture, ply_height)
values (7, 'Brian', 'Wayne', 'bwayne@usf.edu', '1996-01-08', 'ply_7.jpg', '6''2"')
insert into tb_players (ply_id, ply_first_name, ply_last_name, ply_email, ply_birthdate, ply_picture, ply_height)
values (8, 'Anne', 'Li', 'ali@usf.edu', '1992-05-01', 'ply_8.jpg', '5''3"')
insert into tb_players (ply_id, ply_first_name, ply_last_name, ply_email, ply_birthdate, ply_picture, ply_height)
values (9, 'Tamara', 'Cox', 'tcox@usf.edu', '1993-09-18', 'ply_9.jpg', '5''5"')
insert into tb_players (ply_id, ply_first_name, ply_last_name, ply_email, ply_birthdate, ply_picture, ply_height)
values (10, 'Jennifer', 'Tyler', 'jtyler@usf.edu', '1990-12-14', 'ply_10.jpg', '5''4"')
go

--select * from tb_players

exec usp_players_select_by_id 3;
go

if object_id('usp_players_insert') is not null
	drop procedure usp_players_insert
go
create procedure usp_players_insert(		@ply_first_name		varchar(400),
											@ply_last_name		varchar(400),
											@ply_email			varchar(400),
											@ply_birthdate		date,
											@ply_picture		varchar(max),
											@ply_height			varchar(400)
											)
as
declare @ply_id_new int
set @ply_id_new = (select max(ply_id) from tb_players) + 1
insert into tb_players (ply_id, ply_first_name, ply_last_name, ply_email, ply_birthdate, ply_picture, ply_height)
values (@ply_id_new, @ply_first_name, @ply_last_name, @ply_email, @ply_birthdate, @ply_picture, @ply_height)
return @ply_id_new
go

