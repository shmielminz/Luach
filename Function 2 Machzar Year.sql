use JewishLuachDB
go
drop function if exists dbo.FindYearInMachzar
go
-- This function uses returns what year in the machzar it is using YearToMachzar function which returns the machzar (cycle) of the year passed into the function,
-- and then calculates what year in the machzar it is, to know if it's a leap year or not.
create function dbo.FindYearInMachzar(@JewishYear int)
returns int
as
begin
    declare @Machzar int = dbo.YearToMachzar(@JewishYear)
    declare @YearInMachzar int = 19
    declare @Answer int = 19
    -- Here the function loops while @YearInMachzar which starts at 19 * @Machzar which is the machzar number of the year returned > than the year,
    -- which means that if 19 * the machzar = year, then the year is the 19'th year in the machzar. So in the loop I'm incrumenting the year by 1 and decrumenting the answer by 1,
    -- so when the the loop runs again it checks if 19 * machzar is still > than year, if no, it returns answer which would be 18 (or any other number), so the year is the 18'th year in the machzar.
    while @YearInMachzar * @Machzar > @JewishYear
    begin
        set @JewishYear = @JewishYear + 1
        set @Answer = @Answer - 1
    end
    return (@Answer)
end
go
select dbo.FindYearInMachzar(5701)