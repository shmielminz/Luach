use JewishLuachDB
go
drop table if exists MonthDays
go
create table dbo.MonthDays(
    MonthDaysId int not null identity primary key,
    DayNum int not null,
    DayHebrew nvarchar(10) not null
)
go
insert MonthDays(DayNum, DayHebrew)
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
union select 11, N'יא'
union select 12, N'יב'
union select 13, N'יג'
union select 14, N'יד'
union select 15, N'טו'
union select 16, N'טז'
union select 17, N'יז'
union select 18, N'יח'
union select 19, N'יט'
union select 20, N'כ'
union select 21, N'כא'
union select 22, N'כב'
union select 23, N'כג'
union select 24, N'כד'
union select 25, N'כה'
union select 26, N'כו'
union select 27, N'כז'
union select 28, N'כח'
union select 29, N'כט'
union select 30, N'ל'
go
select * from MonthDays