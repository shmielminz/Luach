use JewishLuachDB
go
drop function if exists dbo.FullYearDate
go
-- This function returns a full luach of a year including dates and parshias
create function dbo.FullYearDate(@JewishYear int)
returns @YearDate table(
    YearDateId int not null identity primary key,
    YearNum int,
    YearHebrew nvarchar(10),
    DayDate date,
    DayHebrew nvarchar(10),
    MonthNum int,
    MonthHebrew nvarchar(10),
    MonthName varchar(10),
    Parshe nvarchar(20),
    DayNameHeb nvarchar(10)
)
as
begin
    declare @Month int,
        @Day int = 0,
        @DayInMonth int = 0,
        @MonthStart int = 1,
        @DateStart date,
        @DateEnd date,
        @YearType varchar(10),
        @DateDiff int,
        @DaysInMonth int,
        @MonthNameHeb nvarchar(10),
        @MonthNameEn varchar(10),
        @MonthNum int,
        @ParsheTable nvarchar(20),
        @ParsheType int,
        @WeekNum int = 0,
        @YearNameHeb nvarchar(10) = '',
        @YearCount int = 0,
        @EndYearCount int = @JewishYear
    select @Month = Months, @YearType = YearType, @DateStart = StartDay, @DateEnd = EndDay, @DateDiff = datediff(day,StartDay,EndDay) from dbo.SetYear(@JewishYear)
    while @EndYearCount > 0
    begin
        set @YearCount = (select max(nal.Nums) from NumAndLetter nal where nal.Nums <= @EndYearCount)
        set @YearNameHeb = concat(@YearNameHeb,(select nal.Letters from NumAndLetter nal where nal.Nums = @YearCount))
        set @EndYearCount -= @YearCount
    end
    while @Day <= @DateDiff
    begin
        set @DayInMonth = 1
        select 
            @DaysInMonth = case @YearType when 'Plus' then DaysInMonthPlus when 'Normal' then DaysInMonthNormal when 'Minus' then DaysInMonthMinus end,
            @MonthNum = case @Month when 12 then MonthNumNormal when 13 then MonthNumLeep end,
            @MonthNameHeb = MonthNameHebrew,
            @MonthNameEn = MonthNameEnglish
        from MonthName
        where (case @Month when 12 then MonthNumNormal when 13 then MonthNumLeep end) = @MonthStart
        while @DayInMonth < @DaysInMonth + 1
        begin
            if datepart(dw,@DateStart) = 7
            begin
                set @WeekNum += 1
                select @ParsheTable = p.ParsheName, @ParsheType = case @Month 
                    when 12 then case @YearType
                        when 'Plus' then case datepart(dw,@DateStart) when 2 then p.MonFull12 when 5 then p.ThuFull12 when 7 then p.ShabFull12 end
                        when 'Minus' then case datepart(dw,@DateStart) when 2 then p.MonMinus12 when 7 then p.ShabMinus12 end
                        when 'Normal' then case datepart(dw,@DateStart) when 3 then p.TueNormal12 when 5 then p.ThuNormal12 end
                    end
                    when 13 then case @YearType
                        when 'Plus' then case datepart(dw,@DateStart) when 2 then p.MonFull13 when 5 then p.ThuFull13 when 7 then p.ShabFull13 end
                        when 'Minus' then case datepart(dw,@DateStart) when 2 then p.MonMinus13 when 5 then p.ThuMinus13 when 7 then p.ShabMinus13 end
                        when 'Normal' then p.TueNormal13
                    end
                end
                from Parshias p
                where (case @Month 
                    when 12 then case @YearType
                        when 'Plus' then case datepart(dw,@DateStart) when 2 then p.MonFull12 when 5 then p.ThuFull12 when 7 then p.ShabFull12 end
                        when 'Minus' then case datepart(dw,@DateStart) when 2 then p.MonMinus12 when 7 then p.ShabMinus12 end
                        when 'Normal' then case datepart(dw,@DateStart) when 3 then p.TueNormal12 when 5 then p.ThuNormal12 end
                    end
                    when 13 then case @YearType
                        when 'Plus' then case datepart(dw,@DateStart) when 2 then p.MonFull13 when 5 then p.ThuFull13 when 7 then p.ShabFull13 end
                        when 'Minus' then case datepart(dw,@DateStart) when 2 then p.MonMinus13 when 5 then p.ThuMinus13 when 7 then p.ShabMinus13 end
                        when 'Normal' then p.TueNormal13
                    end
                end) = @WeekNum
            end
            else
            begin
                set @ParsheTable = ''
                set @ParsheType = ''
            end
            
            insert @YearDate(YearNum,YearHebrew,DayDate,DayHebrew,MonthNum,MonthHebrew,MonthName,Parshe,DayNameHeb)
            select @JewishYear, @YearNameHeb, @DateStart, (select DayHebrew from MonthDays where @DayInMonth = DayNum), @MonthNum, @MonthNameHeb, @MonthNameEn, @ParsheTable, (select DayNameHeb from DayWeek where DayNum = datepart(dw,@DateStart))
            set @DateStart = dateadd(day,1,@DateStart)
            set @DayInMonth += 1
        end
        set @Day += @DayInMonth
        set @MonthStart += 1
    end
    return
end
go

select * from dbo.FullYearDate(3782)