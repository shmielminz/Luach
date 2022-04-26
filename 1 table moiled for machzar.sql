use JewishLuachDB
go
drop table if exists MoiledForMachzar
go
create table dbo.MoiledForMachzar(
    MoiledForMachzarId int not null identity primary key,
    YearNum int not null,
    YearInMachzar int not null,
    DateStart datetime2 not null,
    HourStart int not null,
    MinuteStart int not null,
    ChailekStart int not null,
    WeekDayStart int not null
)
go
