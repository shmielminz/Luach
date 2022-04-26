use JewishLuachDB
go
drop function if exists dbo.SetYear
go
-- This function returns the Gregorian Date from the rosh hashona and erev rosh hashona following year (1st day and last day of the year), 
-- and what type of year it is (number of days in Chesvan and Kislev) where plus means that both have 30 days, minus both have 29, and normal Cheshvan is 29 and Kislav is 30.
create function dbo.SetYear(@JewishYear int)
returns @Year table(
    YearId int not null identity primary key,
    YearNum int,
    StartDay date,
    EndDay date,
    Months int,
    YearType varchar(10)
)
as
begin
    if @JewishYear < 3763 return
    declare @Month int,
        @LastYearMonth int,
        @StartYear date,
        @StartNextYear date,
        @StartMoiledHour int,
        @StartNextMoiledHour int,
        @YearType varchar(10),
        @StartMinute int,
        @StartChailek int
    set @Month = dbo.FindMonthInYear(@JewishYear)
    set @LastYearMonth = dbo.FindMonthInYear(@JewishYear - 1)
    (select top 1 @StartYear = GregorianDate, @StartMoiledHour = MoiledHour, @StartMinute = MoiledMinute, @StartChailek = MoiledChailek from dbo.NewMoiledTable(@JewishYear) where MonthNum = 1)
    (select top 1 @StartNextYear = GregorianDate, @StartNextMoiledHour = MoiledHour from dbo.NewMoiledTable(@JewishYear + 1) where MonthNum = 1)
    
    -- rosh hashona can't be on day of moiled if moiled after 12 or after specific time
    if 
        (@LastYearMonth = 12 and datepart(weekday,@StartYear) = 3 and @StartMoiledHour >= 3 and @StartMinute >= 11 and @StartChailek >= 6) 
        or (@LastYearMonth = 13 and datepart(weekday,@StartYear) = 2 and @StartMoiledHour >= 9 and @StartMinute >= 32 and @StartChailek >= 13)
        or (@StartMoiledHour >= 12)
    begin
        set @StartYear = dateadd(day,1,@StartYear)
    end
    if @StartNextMoiledHour >= 12
    begin
        set @StartNextYear = dateadd(day,1,@StartNextYear)
    end
    -- rosh hashona can't be sunday, wednesday, friday
    if datepart(weekday,@StartYear) in(1,4,6)
    begin
        set @StartYear = dateadd(day,1,@StartYear)
    end
    if datepart(weekday,@StartNextYear) in(1,4,6)
    begin
        set @StartNextYear = dateadd(day,1,@StartNextYear)
    end
    if datediff(day,@StartYear,@StartNextYear) in(354,384)
    begin
        set @YearType = 'Normal'
    end
    if datediff(day,@StartYear,@StartNextYear) in(353,383)
    begin
        set @YearType = 'Minus'
    end
    if datediff(day,@StartYear,@StartNextYear) in(355,385)
    begin
        set @YearType = 'Plus'
    end
    insert @Year(YearNum,StartDay,EndDay,Months,YearType)
    select @JewishYear,@StartYear,dateadd(day,-1,@StartNextYear),@Month,@YearType
    return
end
go
select * from dbo.SetYear(5782)