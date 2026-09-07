* ECON689 - Problem Set 1
* Name: Cauchy Ding

* Environment Preperation
clear all
set more off
capture log close

* Read the enviroment variables
global storage: env storage
global projects: env projects

* Define the output paths
global dataready "$storage/econ689_data/ps01/data"
global code "$projects/econ689/ps01"
global output "$projects/econ689/ps01/output"

* PROBLEM 1

* Problem 1c
capture mkdir "$storage/econ689_data"
capture mkdir "$storage/econ689_data/ps01"
capture mkdir "$dataready"
capture mkdir "$code"
capture mkdir "$output"

* Problem 1e:
log using "$output/ps01_CauchyDing.log", text replace

*Problem 1a:
display "storage   = $storage"
display "projects  = $projects"
display "dataready = $dataready"
display "code      = $code"
display "output    = $output"

* problem 1d:
confirm file "$dataready/card.dta"
display "card.dta found."

* PROBLEM 2

* Prepare 500 observations
clear
set obs 500
set seed 68901

* Generate study hours
generate double v = rnormal(8, 2.5)
generate double study_hours = max(0, v)

* Generate prior GPA
generate double w = rnormal(3, 0.45)
generate double prior_gpa = min(4, max(0, w))

* Generate the random error and exam score
generate double u = rnormal(0, 5)
generate double exam_score = 45 + 2.5*study_hours + 6*prior_gpa + u

* Problem 2b
summarize study_hours prior_gpa exam_score

* Problem 2c
regress exam_score study_hours

* Store the study-hours coefficient
scalar p2_b_simple = _b[study_hours]

* Problem 2d
predict double fitted_simple, xb
predict double residual_simple, residuals

summarize residual_simple
display "Mean residual = " %21.15e r(mean)

* Problem 2e
regress exam_score study_hours prior_gpa

scalar p2_b_multiple = _b[study_hours]

* Compare the two study-hours coefficients
display "Simple regression coefficient = " %12.6f scalar(p2_b_simple)
display "Multiple regression coefficient = " %12.6f scalar(p2_b_multiple)

* Problem 2g
save "$dataready/ps01_stimulated_CauchyDing.dta", replace


* PROBLEM 3

* Problem 3a
use "$dataready/card.dta", clear
describe

* Summary statistics for the required variables
summarize lwage educ exper expersq black south smsa nearc4

* Count obserbations with no missing values in these variables
count if !missing(lwage, educ, exper, expersq, black, south, smsa, nearc4)

display "Usable obserbations = " r(N)

* Problem 3b
regress lwage educ

* Approximate percentage change
display 100 * _b[educ]

* Exact percentage change
display 100 * (exp(_b[educ]) - 1)

* Problem 3c
regress lwage educ exper expersq black south smsa

* Problem 3e
predict double log_wage_multi, xb
predict double residual_multi, residuals
summarize residual_multi

* Poblem 3f
regress educ nearc4

* Upcoming code here

* End logging
log close
