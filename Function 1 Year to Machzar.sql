use JewishLuachDB
go
drop function if exists dbo.YearToMachzar
go
-- This function devides the input year by 19 to know which machzar it's in (Every 19 years the luach starts a new cycle)
create function dbo.YearToMachzar(@JewishYear decimal(6,2))
returns int
as
begin
    declare @Machzar int = ceiling(@JewishYear / 19)
    return (@Machzar)
end
go
select dbo.YearToMachzar(4294)