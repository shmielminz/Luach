-- Don't change this function
use JewishLuachDB
go
drop function if exists dbo.FullMoiledTable
go
-- This function returns a table of the moiled of every year starting 3763 up until 6000, and inserts it into table MoiledForMachzar
create function dbo.FullMoiledTable(@JewishYear int)
returns @Year table (
    YearId int not null identity primary key,
    YearNum int,
    YearInMachzar int,
    StartWeekday int,
    MoiledHour int,
    MoiledMinute int,
    MoiledChailek int,
    GregorianDate datetime2
)
as
begin
    declare @Chailek int = 5,
        @Minute int = 32,
        @Hour int = 23,
        @Day int = 0,
        @DaysInYear int,
        @WeekDay int = 7, 
        @StartYear int = 3763,
        @StartMonth int = 1,
        @MaxMonth int,
        @Week int = 1, 
        @TempMonth int,
        @GregorianDate datetime2 = '0002-08-24 23:32:00.0000000',
        @MachzarYear int

    if @JewishYear >= 6000 return

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
        set @MachzarYear = dbo.FindYearInMachzar(@StartYear)
        -- if year = year passed into function than loop until max month else loop until month = months in year of loop
        while @StartMonth < @TempMonth + 1 and (@StartMonth <= @MaxMonth or @JewishYear <> @StartYear)
        begin
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
            -- if Month of loop = 1st Month insert into table month of loop
            if @StartMonth = 1
            begin
                insert @Year(YearNum,YearInMachzar,StartWeekday,MoiledHour,MoiledMinute,MoiledChailek,GregorianDate)
                select @StartYear,@MachzarYear,@WeekDay,@Hour,@Minute,@Chailek,@GregorianDate
            end
            set @StartMonth = @StartMonth + 1
        end
        set @StartYear = @StartYear + 1
    end
    return
end
go
delete MoiledForMachzar
go
insert MoiledForMachzar(YearNum,YearInMachzar,DateStart,HourStart,MinuteStart,ChailekStart,WeekDayStart)
select YearNum,YearInMachzar,GregorianDate,MoiledHour,MoiledMinute,MoiledChailek,StartWeekday from dbo.FullMoiledTable(5999)

select * from MoiledForMachzar