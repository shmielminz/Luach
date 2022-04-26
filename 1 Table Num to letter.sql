use JewishLuachDB
go
drop table if exists NumAndLetter
go
create table dbo.NumAndLetter(
    NumAndLetterId int not null identity primary key,
    Nums int not null,
    Letters nvarchar(2) not null
)
go
insert NumAndLetter(Nums, Letters)
select 1, N'א'
union select 2, N'ב'
union select 3, N'ג'
union select 4, N'ד'
union select 5, N'ה'
union select 6, N'ו'
union select 7, N'ז'
union select 8, N'ח'
union select 9, N'ט'
union select 10, N'י'
union select 20, N'כ'
union select 30, N'ל'
union select 40, N'מ'
union select 50, N'נ'
union select 60, N'ס'
union select 70, N'ע'
union select 80, N'פ'
union select 90, N'צ'
union select 100, N'ק'
union select 200, N'ר'
union select 300, N'ש'
union select 400, N'ת'
union select 1000, N'א'''
union select 2000, N'ב'''
union select 3000, N'ג'''
union select 4000, N'ד'''
union select 5000, N'ה'''
union select 6000, N'ו'''
go
select * from NumAndLetter