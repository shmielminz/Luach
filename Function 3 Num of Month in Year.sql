use JewishLuachDB
go
drop function if exists dbo.FindMonthInYear
go
-- This function just checks what year in machzar it is, using FindYearInMachzar function, and returns if it's a leap year (13 months) or not.
create function dbo.FindMonthInYear(@JewishYear int)
returns int
as
begin
    declare @YearInMachzar int = dbo.FindYearInMachzar(@JewishYear)
    declare @Month int
    if @YearInMachzar in(3,6,8,11,14,17,19)
        begin
            set @Month = 13
        end
    else
        begin
            set @Month = 12
        end
    return (@Month)
end
go
select dbo.FindMonthInYear(5782)