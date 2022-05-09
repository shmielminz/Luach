## Welcome to my Luach in SQL

This is a full Luach in sql server, where you can just enter any Gregorian date and get returned the resulting Yiddish date. Or enter a Yiddish date and get returned the Gregorian date.
#### Here you have some info on how it works:
-	First you have a function that returns the Machzar of any year you pass in. It takes the year you pass in and devides it by 19, which is the number of years in a Machzar, and it returns the Machzar number.
-	Then comes the second function, and checks the Machzar num the first function returned, and then multiplies it by 19, and compares it to the year you passed in, if it's the same, it means that it is the last year of the Machzar. For example, if you passed in for example 19 as the year, it will first devide it by 19, 19 / 19 = 1, so it's the first Machzar, then it will mutiply it by 19, to check what year in the Machzar it is, 19 * 1 = 19, so it returns 19, the 19'th (last) year in the first Machzar.
-	If it's not the same: It will loop until it's the same, while after each loop it adds 1 to the year, and it subtracts 1 from a answer variable, which started at 19, and it loops until the Machzar * 19 = the updated year, and the function returns the answer variable.
-	The third function checks the year of the Machzar (from function 2), and returns if it's a Shnas Ibur (leap year), if the year in Machzar is in 3,6,8,11,14,17,19 it's a Shnas Ibur with 13 months else it's a normal year with 12 months.
-	The 4'th function returns the Moiled for every Rosh Hashona since ג'תשסג which is the first year of the first Machzar since CE, up to and including year ה'תתקצט which is the last year before ששת אלפים. And it inserts it to MoiledForMachzar table which will be referenced from later.

**Don't change function 4 as it's only a one time use**
-	Function 5 returns the Moiled for the full year, a month is 29 days 12 hours 44 minutes and 1 chailek, so it checks the Moiled from Rosh Hashona using MoiledForMachzar table, and by using the third function it returns the Moiled for 12 or 13 months.
-	Function 6, makes calculations on the Moiled of Rosh Hashona, and returns when Rosh Hashona is for this year and for the next year, and returns the first and last day of the year, and it makes calculations on the year if it has 29 days on Chesvon and Kislev, 30 days, or if 1 is 29 and 1 is 30.
-	Function 7 returns a table of a full Luach on the year, with Parshias (חוץ לארץ) and days, and the Gregorian date.
-	Function 8 and 9 converts a Gregorian date to a Jewish date and vice versa, using function 7.

