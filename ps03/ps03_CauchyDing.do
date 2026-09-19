* Problem Set 03

* Clear the environment
clear all
set more off

global projects : env projects
display "$projects"

cd "$projects/econ689/ps03"

* Capture log
capture mkdir output
capture log close
log using "output/ps03_CauchyDing.log", text replace

* Problem 1 Generate Data
* Set seed and observations
set seed 2026
set obs 500

* Generate values
gen x1 = rnormal(2, 1)
gen v = rnormal(0, 1)
gen x2 = 0.5 * x1 + v
gen u = rnormal(0, 2)
gen y = 3 + 2*x1 - x2 + u

* Summary
summ y x1 x2

* Create the scatterplot of y against x1
twoway ///
	(scatter y x1) ///
	(lfit y x1), ///
	title("Relationship between y and x1") ///
	xtitle("x1") ///
	ytitle("y") ///
	legend(order(1 "Observed data" 2 "Fitted line")) ///
	name(y_x1, replace)
	
* Create the scatterplot of y against x2
twoway ///
	(scatter y x2) ///
	(lfit y x2), ///
	title("Relationship between y and x2") ///
	xtitle("x2") ///
	ytitle("y") ///
	legend(order(1 "Observed data" 2 "Fitted line")) ///
	name(y_x2, replace)
	
* Problem 2 Verify orthogonality of the residuals
* Regress and estimate yhat and ehat
regress y x1 x2
predict yhat, xb
predict ehat, residuals

* Save the estimated coefficients
scalar b0hat = _b[_cons]
scalar b1hat = _b[x1]
scalar b2hat = _b[x2]

* Calculate x1e x2e
gen x1e = x1 * ehat
gen x2e = x2 * ehat

* Calculate the sums
summ x1e
display r(sum)

summ x2e
display r(sum)

* Create scatterplots
twoway ///
	(scatter ehat x1) ///
	(lfit ehat x1), ///
	yline(0) ///
	title("Relationship between ehat and x1") ///
	xtitle("x1") ///
	ytitle("ehat") ///
	legend(order(1 "Residuals" 2 "Fitted line")) ///
	name(ehat_x1, replace)

twoway ///
	(scatter ehat x2) ///
	(lfit ehat x2), ///
	yline(0) ///
	title("Relationship between ehat and x2") ///
	xtitle("x2") ///
	ytitle("ehat") ///
	legend(order(1 "Residuals" 2 "Fitted line")) ///
	name(ehat_x2, replace)
	
* Problem 3
* Calculate the sum and the mean of ehat
summ ehat
display "ehat_sum = " r(sum)
display "ehat_mean = " r(mean)

* Verify the mean of yhat equals to the mean of y
summ yhat
display r(mean)
summ y
display r(mean)

* Draw histogram of ehat
histogram ehat, frequency ///
	xline(0, lcolor(red) lpattern(dash)) ///
	title("Distribution of Residuals") ///
	xtitle("Residuals") ///
	ytitle("Frequency") ///
	name(hist_ehat, replace)

* Problem 4 Verify the prediction at the average observation
* Calculate the sample means
summ x1
gen x1bar = r(mean)

summ x2
gen x2bar = r(mean)

summ y
gen ybar = r(mean)

* Calculate yhatxbar
gen yhatxbar = b0hat + b1hat * x1bar + b2hat *x2bar
display "yhatxbar = " yhatxbar
display "ybar = " ybar


* End log	
log close