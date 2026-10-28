* ECON 689 - Problem Set 5
clear all
set more off
capture log close

global storage: env storage
global projects: env projects
global code "$projects/econ689/ps05"
global output "$code/output"

capture mkdir "$code"
capture mkdir "$output"
log using "$output/ps05_CauchyDing.log", text replace

* Problem 2

use "$storage/econ689_data/ps01/data/card.dta", clear

* Q(a)
reg lwage educ exper expersq black south smsa smsa66 reg662 reg663 reg664 reg665 reg666 reg667 reg668 reg669

scalar SSR_u = e(rss)
scalar df_u = e(df_r)

display SSR_u
display df_u

* Q(b)
scalar j2 = 8
test reg662 reg663 reg664 reg665 reg666 reg667 reg668 reg669
scalar f2_test = r(F)
scalar p2_test = r(p)

display "P2: J		 = " j2
display "P2: test F  = " f2_test
display "P2: p-value = " p2_test

* Q(c)
reg lwage educ exper expersq black south smsa smsa66
scalar SSR_r = e(rss)
scalar f2_ssr = ((SSR_r - SSR_u)/SSR_u)*(df_u/j2)

display "P2: SSR_r		= " SSR_r
display "P2: SSR_form F = " f2_ssr
display "P2: difference = " f2_ssr -f2_test

* Problem 3

* Q(a)
clear
set seed 2026
set obs 500

gen x1 = rnormal(0,1)
gen v = rnormal(0,1)
gen x2 = 0.5 * x1 + v
gen x3 = rnormal(1,1)
gen u = rnormal(0,2)
gen y = 1 + 1*x1 + 0.5*x2 - 0.5*x3 + u

summarize x1 v x2 x3 u y

reg y x1 x2 x3

* Q(b)
scalar j3 = 2
test (x1 = 1) (x2 + x3 = 0)
scalar f3_test = r(F)
scalar p3_test = r(p)

display "P3: test F  = " f3_test
display "P3: p-value = " p3_test

* Q(c)
matrix b = e(b)
matrix V = e(V)
matrix R = (1,0,0,0 \ 0,1,1,0)
matrix r = (1 \ 0)

matrix d = R*b' - r
matrix W = d' * invsym(R*V*R') * d
scalar f3_matrix = W[1,1] / j3

display "P3: matrix F = " f3_matrix
display "P3: difference = " f3_matrix - f3_test

log close