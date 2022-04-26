use JewishLuachDB
go

drop function if exists dbo.ConvertToGregorianDate
go
-- This function converts fron a jewish date to Gregorian date
create function dbo.ConvertToGregorianDate(@JewishYear nvarchar(6), @JewishMonth nvarchar(10), @JewishDay nvarchar(4))
returns date
as
begin
    declare 
        @GregorianDate date,
        @LengthOfYear int = len(@JewishYear),
        @LettersFromYear nchar(1) = substring(@JewishYear,1,1),
        @Counter int = 0,
        @YearNum int = 0
    
    while @Counter < @LengthOfYear
    begin
        set @Counter += 1
        set @LettersFromYear = substring(@JewishYear,@Counter,1)
        set @YearNum += (select n.Nums from NumAndLetter n where n.Letters = @LettersFromYear)
    end
    set @YearNum += 5000

    set @GregorianDate = (select fyd.DayDate from dbo.FullYearDate(@YearNum) fyd where fyd.MonthHebrew = @JewishMonth and fyd.DayHebrew = @JewishDay)

    return @GregorianDate
end
go

select dbo.ConvertToGregorianDate(N'תתקצט',N'כסלו',N'כא')