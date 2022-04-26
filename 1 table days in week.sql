use JewishLuachDB
go
drop table if exists DayWeek
go
create table dbo.DayWeek(
    DayWeekId int not null identity primary key,
    DayNum int not null,
    DayNameHeb nvarchar(10) not null
)
go
insert DayWeek(DayNum,DayNameHeb)
select 1, N'זינטאג'
union select 2, N'מאנטאג'
union select 3, N'דינסטאג'
union select 4, N'מיטוואך'
union select 5, N'דאנערשטאג'
union select 6, N'פרייטאג'
union select 7, N'שבת'