use JewishLuachDB
go
drop table if exists MonthName
go
create table dbo.MonthName(
    MonthNameId int not null identity primary key,
    MonthNumNormal int null,
    MonthNumLeep int null,
    MonthNameHebrew nvarchar(10) not null,
    MonthNameEnglish varchar(10) not null,
    DaysInMonthPlus int not null,
    DaysInMonthNormal int not null,
    DaysInMonthMinus int not null
)
go

insert MonthName(MonthNumNormal, MonthNumLeep, MonthNameHebrew, MonthNameEnglish, DaysInMonthPlus, DaysInMonthNormal, DaysInMonthMinus)
select 1, 1, N'תשרי', 'Tishrei', 30, 30, 30
union select 2, 2, N'חשון', 'Cheshvan', 30, 29, 29
union select 3, 3, N'כסלו', 'Kislev', 30, 30, 29
union select 4, 4, N'טבת', 'Teves', 29, 29, 29
union select 5, 5, N'שבט', 'Shevat', 30, 30, 30
union select 6, null, N'אדר', 'Adar', 29, 29, 29
union select null, 6, N'אדר א', 'Adar 1', 30, 30, 30
union select null, 7, N'אדר ב', 'Adar 2', 29, 29, 29
union select 7, 8, N'ניסן', 'Nisan', 30, 30, 30
union select  8, 9, N'אייר', 'Iyer', 29, 29, 29
union select  9, 10, N'סיון', 'Sivan', 30, 30, 30
union select  10, 11, N'תמוז', 'Tamuz', 29, 29, 29
union select  11, 12, N'אב', 'Av', 30, 30, 30
union select  12, 13, N'אלול', 'Elul', 29, 29, 29
go

select * from MonthName