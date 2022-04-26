use JewishLuachDB
go
drop function if exists dbo.NewMoiledTable
go
-- This function returns when the moiled (the new moon) will be on each month of the year, by calculating using MoiledForMachzar table
create function dbo.NewMoiledTable(@JewishYear int)
returns @Year table (
    YearId int not null identity primary key,
    YearNum int,
    MonthNum int,
    StartWeekday int,
    MoiledHour int,
    MoiledMinute int,
    MoiledChailek int,
    GregorianDate datetime2
)
as
begin
    declare @Chailek int,
        @Minute int,
        @Hour int,
        @Day int = 0,
        @DaysInYear int,
        @WeekDay int, 
        @StartYear int,
        @StartMonth int = 1,
        @MaxMonth int,
        @Week int = 1, 
        @TempMonth int,
        @GregorianDate datetime2
    
    select top 1 @StartYear = YearNum, @GregorianDate = DateStart, @WeekDay = WeekDayStart, @Hour = HourStart, @Minute = MinuteStart, @Chailek = ChailekStart 
    from MoiledForMachzar
    where YearNum < @JewishYear
    order by YearNum desc

    if @JewishYear > 6000 return

    -- Loop until year = the year you want to check on
    while @StartYear < @JewishYear + 1
    begin
        -- Start from begining of year
        set @DaysInYear = 1
        set @Week = 1
        set @StartMonth = 1
        -- If year is not same year as passed into function set a temp month to be sum of months in year of loop
        if @JewishYear <> @StartYear
        begin
            set @TempMonth = dbo.FindMonthInYear(@StartYear)
        end
        -- else set temp month to be year passed into function to loop until month = months in year
        else
        begin
            set @TempMonth = dbo.FindMonthInYear(@JewishYear)
        end
        set @MaxMonth = dbo.FindMonthInYear(@StartYear)
        -- if year = year passed into function than loop until max month else loop until month = months in year of loop
        while @StartMonth < @TempMonth + 1 and (@StartMonth <= @MaxMonth or @JewishYear <> @StartYear)
        begin
            
            -- if year of loop = year passed into function insert into table month of loop
            if @StartYear = @JewishYear
            begin
                insert @Year(YearNum,MonthNum,StartWeekday,MoiledHour,MoiledMinute,MoiledChailek,GregorianDate)
                select @JewishYear,@StartMonth,@WeekDay,@Hour,@Minute,@Chailek,@GregorianDate
            end
            -- start first day of month and loop until day 29
            set @Day = 0
            while @Day < 29
            begin
                set @Day = @Day + 1
                set @WeekDay = @WeekDay + 1
                set @DaysInYear = @DaysInYear + 1
                set @GregorianDate = dateadd(day,1,@GregorianDate)
            end
            set @Chailek = @Chailek + 1
            -- 18 chalokim in minute
            if @Chailek >= 18
            begin
                set @Minute = @Minute + 1
                set @GregorianDate = dateadd(minute,1,@GregorianDate)
                set @Chailek = @Chailek - 18
            end
            set @Minute = @Minute + 44
            set @GregorianDate = dateadd(minute,44,@GregorianDate)
            if @Minute >= 60
            begin
                set @Hour = @Hour + 1
                set @Minute = @Minute - 60
            end
            set @Hour = @Hour + 12
            set @GregorianDate = dateadd(hour,12,@GregorianDate)
            if @Hour >= 24
            begin
                set @Day = @Day + 1
                set @DaysInYear = @DaysInYear + 1
                set @WeekDay = @WeekDay + 1
                set @Hour = @Hour - 24
            end
            while @WeekDay > 7
            begin
                set @Week = @Week + 1
                set @WeekDay = @WeekDay - 7
            end
            
            set @StartMonth = @StartMonth + 1
        end
        set @StartYear = @StartYear + 1
    end
    return
end
go
select * from dbo.NewMoiledTable(5379)