use JewishLuachDB
go
drop table if exists Parshias
go
create table dbo.Parshias(
    ParsheId int not null identity primary key,
    ParsheName nvarchar(50) not null constraint u_Parshe_ParsheName unique,
    MonMinus12 int,
    MonFull12 int,
    TueNormal12 int,
    ThuNormal12 int,
    ThuFull12 int,
    ShabMinus12 int,
    ShabFull12 int,
    MonMinus13 int,
    MonFull13 int,
    TueNormal13 int,
    ThuMinus13 int,
    ThuFull13 int,
    ShabMinus13 int,
    ShabFull13 int
)
go
insert Parshias(MonMinus12,MonFull12,TueNormal12,ThuNormal12,ThuFull12,ShabMinus12,ShabFull12,MonMinus13,MonFull13,TueNormal13,ThuMinus13,ThuFull13,ShabMinus13,ShabFull13,ParsheName)
select null,null,null,null,null,1,1,null,null,null,null,null,1,1, N'א'' ראש השנה'
union select 1,1,1,null,null,null,null,1,1,1,null,null,null,null, N'וילך'
union select 2,2,2,1,1,2,2,2,2,2,1,1,2,2, N'האזינו'
union select null,null,null,2,2,null,null,null,null,null,2,2,null,null, N'יום כיפור'
union select null,null,null,null,null,3,3,null,null,null,null,null,3,3, N'א'' סוכות'
union select 3,3,3,3,3,null,null,3,3,3,3,3,null,null, N'שבת חול המועד סוכות'
union select null,null,null,null,null,4,4,null,null,null,null,null,4,4, N'שמיני עצרת'
union select 4,4,4,4,4,5,5,4,4,4,4,4,5,5, N'בראשית'
union select 5,5,5,5,5,6,6,5,5,5,5,5,6,6, N'נח'
union select 6,6,6,6,6,7,7,6,6,6,6,6,7,7, N'לך לך'
union select 7,7,7,7,7,8,8,7,7,7,7,7,8,8, N'וירא'
union select 8,8,8,8,8,9,9,8,8,8,8,8,9,9, N'חיי שרה'
union select 9,9,9,9,9,10,10,9,9,9,9,9,10,10, N'תולדות'
union select 10,10,10,10,10,11,11,10,10,10,10,10,11,11, N'ויצא'
union select 11,11,11,11,11,12,12,11,11,11,11,11,12,12, N'וישלח'
union select 12,12,12,12,12,13,13,12,12,12,12,12,13,13, N'וישב'
union select 13,13,13,13,13,14,14,13,13,13,13,13,14,14, N'מקץ'
union select 14,14,14,14,14,15,15,14,14,14,14,14,15,15, N'ויגש'
union select 15,15,15,15,15,16,16,15,15,15,15,15,16,16, N'ויחי'
union select 16,16,16,16,16,17,17,16,16,16,16,16,17,17, N'שמות'
union select 17,17,17,17,17,18,18,17,17,17,17,17,18,18, N'וארא'
union select 18,18,18,18,18,19,19,18,18,18,18,18,19,19, N'בא'
union select 19,19,19,19,19,20,20,19,19,19,19,19,20,20, N'בשלח'
union select 20,20,20,20,20,21,21,20,20,20,20,20,21,21, N'יתרו'
union select 21,21,21,21,21,22,22,21,21,21,21,21,22,22, N'משפטים'
union select 22,22,22,22,22,23,23,22,22,22,22,22,23,23, N'תרומה'
union select 23,23,23,23,23,24,24,23,23,23,23,23,24,24, N'תצוה'
union select 24,24,24,24,24,25,25,24,24,24,24,24,25,25, N'כי תשא'
union select null,null,null,null,25,null,null,25,25,25,25,25,26,26, N'ויקהל'
union select null,null,null,null,26,null,null,26,26,26,26,26,27,27, N'פקודי'
union select 25,25,25,25,null,26,26,null,null,null,null,null,null,null, N'ויקהל פקודי'
union select 26,26,26,26,27,27,27,27,27,27,27,27,28,28, N'ויקרא'
union select 27,27,27,27,28,28,28,28,28,28,28,28,29,29, N'צו'
union select null,null,null,28,null,null,null,null,32,32,null,null,null,null, N'א'' פסח'
union select 28,28,28,null,null,null,29,32,null,null,null,33,33,33, N'שבת חול המועד פסח'
union select null,null,null,null,29,29,null,null,null,null,33,null,null,null, N'שביעי של פסח'
union select null,null,null,29,null,null,null,null,33,33,null,null,null,null, N'אחרון של פסח'
union select 29,29,29,30,30,30,30,29,29,29,29,29,30,30, N'שמיני'
union select null,null,null,null,null,null,null,30,30,30,30,30,31,31, N'תזריע'
union select null,null,null,null,null,null,null,31,31,31,31,31,32,32, N'מצורע'
union select 30,30,30,31,31,31,31,null,null,null,null,null,null,null, N'תזריע מצורע'
union select null,null,null,null,null,null,null,33,33,34,32,32,34,34, N'אחרי'
union select null,null,null,null,null,null,null,34,34,35,34,34,35,35, N'קדושים'
union select 31,31,31,32,32,32,32,null,null,null,null,null,null,null, N'אחרי קדושים'
union select 32,32,32,33,33,33,33,35,35,36,35,35,36,36, N'אמור'
union select null,null,null,null,null,null,null,36,36,37,36,36,37,37, N'בהר'
union select null,null,null,null,null,null,null,37,37,38,37,37,38,38, N'בחוקותי'
union select 33,33,33,34,34,34,34,null,null,null,null,null,null,null, N'בהר בחוקותי'
union select 34,34,34,35,35,35,35,38,38,39,38,38,39,39, N'במדבר'
union select null,35,35,null,null,null,null,39,null,null,null,null,null,40, N'ב'' שבועות'
union select 35,36,36,36,36,36,36,40,39,40,39,39,40,41, N'נשא'
union select 36,37,37,37,37,37,37,41,40,41,40,40,41,42, N'בהעלותך'
union select 37,38,38,38,38,38,38,42,41,42,41,41,42,43, N'שלח'
union select 38,39,39,39,39,39,39,43,42,43,42,42,43,44, N'קרח'
union select 39,null,null,40,40,40,40,null,43,44,43,43,44,null, N'חוקת'
union select 40,null,null,41,41,41,41,null,44,45,44,44,45,null, N'בלק'
union select null,40,40,null,null,null,null,44,null,null,null,null,null,45, N'חוקת בלק'
union select 41,41,41,42,42,42,42,45,45,46,45,45,46,46, N'פינחס'
union select null,null,null,null,null,null,null,null,null,null,46,46,null,null, N'מטות'
union select null,null,null,null,null,null,null,null,null,null,47,47,null,null, N'מסעי'
union select 42,42,42,43,43,43,43,46,46,47,null,null,47,47, N'מטות מסעי'
union select 43,43,43,44,44,44,44,47,47,48,48,48,48,48, N'דברים'
union select 44,44,44,45,45,45,45,48,48,49,49,49,49,49, N'ואתחנן'
union select 45,45,45,46,46,46,46,49,49,50,50,50,50,50, N'עקב'
union select 46,46,46,47,47,47,47,50,50,51,51,51,51,51, N'ראה'
union select 47,47,47,48,48,48,48,51,51,52,52,52,52,52, N'שופטים'
union select 48,48,48,49,49,49,49,52,52,53,53,53,53,53, N'כי תצא'
union select 49,49,49,50,50,50,50,53,53,54,54,54,54,54, N'כי תבא'
union select null,null,null,51,51,51,null,null,54,55,55,null,null,null, N'נצבים'
union select 50,50,50,null,null,null,51,54,null,null,null,55,55,55, N'נצבים וילך'
