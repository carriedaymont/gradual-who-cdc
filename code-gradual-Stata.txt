*Stata code for  
*Gradual transition WHO-CDC z-score smoothing code

*2025-07-06

/*
The code is set up for the variable names below, but you can adjust it to your own variable names.
It is not a program, you have to paste it into your code.

agedays = age in days (will be converted to ageyears = age in fractional years)

whowtz, whohtz, whobmiz = who z-score for wt, ht, bmi
cdcwtz, cdchtz, cdcbmiz = cdc z-score for wt, ht, bmi

wt = weight
ht = length or height
bmi = body mass index

Will output gradual z-scores: gwtz, ghtz, gbmiz
*/


*Get variable in fractional age years, as precise as possible. 
gen ageyears=agedays/365.25


/*
Generate weights for weighted average from 2-5 years
The whoweight value is bigger when the child is younger
The cdcweight value is bigger when the child is older
The weights add up to 3, which is the duration, in years, of the smoothing period
*/

gen whoweight=5-ageyears
gen cdcweight=ageyears-2

/*
Generate weighted average from 2-5 years
Make everything below 2 years WHO
Make everything above 5 years CDC

*/

foreach p in wt ht bmi {
	
	gen g`p'z = who`p'z * whoweight/3 + cdc`p'z * cdcweight/3
	replace g`p'z = who`p'z if agedays <= 730
	replace g`p'z = cdc`p'z if agedays >=1826

}

*Drop unneeded variables
drop whoweight cdcweight
