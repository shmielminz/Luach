use JewishLuachDB
go

drop function if exists dbo.ConvertToJewishDate
go
-- This function converts from Gregorian date to jewish date.
create function dbo.ConvertToJewishDate(@GregorianDate datetime2)
returns nvarchar(25)
as
begin
    declare
        @JewishYear int,
        @JewishDate nvarchar(25),
        @GregorianYear int = year(@GregorianDate),
        @GregorianMonth int = month(@GregorianDate),
        @GregorianDay int = day(@GregorianDate),
        @StartDate datetime2 = (select max(mfm.DateStart) from MoiledForMachzar mfm where mfm.DateStart <= @GregorianDate),
        @EndDate datetime2,
        @CountJewishYear int

    set @JewishYear = (select mfm.YearNum from MoiledForMachzar mfm where mfm.DateStart = @StartDate)

    if @StartDate < @GregorianDate
    begin
        (select @StartDate = min(fyd.DayDate), @EndDate = max(fyd.DayDate) from FullYearDate(@JewishYear) fyd)
        if @GregorianDate not between @StartDate and @EndDate
        begin
            set @JewishYear += 1
        end
        else
        begin
            set @StartDate = @GregorianDate
        end
    end

    set @JewishDate = (select concat(fyd.DayHebrew,' ',fyd.MonthHebrew,' ',fyd.YearHebrew) from FullYearDate(@JewishYear) fyd where fyd.DayDate = @StartDate)

    return @JewishDate
end
go

select dbo.ConvertToJewishDate('2022-10-23')