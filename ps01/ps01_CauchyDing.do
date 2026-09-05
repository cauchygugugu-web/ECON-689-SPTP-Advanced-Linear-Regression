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

* Upcoming code here

* End logging
log close
