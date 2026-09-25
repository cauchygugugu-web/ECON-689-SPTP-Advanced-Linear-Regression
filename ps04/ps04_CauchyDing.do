* Problem Set 04

* Prepare the environment
clear all
set more off

global projects : env projects
display "$projects"

cd "$projects/econ689/ps04"

* Capture log
capture mkdir output
capture log close
log using "output/ps04_CauchyDing.log", text replace

* Problem 1
set seed 2026
set obs 500

* Generate values
gen x2 = rnormal(1, 1)
gen v = rnormal(0, 1)
gen x1 = 0.7 * x2 + v

gen u = rnormal(0, 2)
gen y = 5 + 3*x1 -2*x2 + u

* Summarize y x1 x2
summ y x1 x2

* Regress y x1 x2
reg y x1 x2

* Store beta1
scalar b1_full = _b[x1]
display b1_full

* Problem 2
* Step 1
reg y x2
predict y_resid, residuals

* Step 2
reg x1 x2
predict x1_resid, residuals

* Step 3
twoway ///
	(scatter y_resid x1_resid) ///
	(lfit y_resid x1_resid), ///
	title("Relationship between y_resid and x1_resid") ///
	xtitle("x1_resid") ///
	ytitle("y_resid") ///
	legend(order(1 "Observed values" 2 "Fitted line"))
	
* Step 4
reg y_resid x1_resid, noconstant
scalar b1_fwl = _b[x1_resid]

* Step 5
display "b1_full = " b1_full
display "b1_fwl = " b1_fwl
display "b1_full - b1_fwl = " b1_full - b1_fwl

* End log
log close