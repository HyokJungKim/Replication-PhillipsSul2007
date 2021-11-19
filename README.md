# Replication_PhillipsSul

This is a replication of [Phillips and Sul (2007)](https://onlinelibrary.wiley.com/doi/10.1111/j.1468-0262.2007.00811.x) "Transition Modeling and Econometric Convergence Tests" published in *Econometrica*.

Original code of Phillips and Sul (2007) is written in Gauss, but I reimplemented their algorithm in Matlab.

## The structure of the code ##

**(1) exm.m**
 - The main scripting code which replicates the results in the paper.
 
**(2) allsort.m**
 - prints output of club convergence tests, and club memberships
  
**(3) andrs.m**
 - HAC correction by Andrews (1991)
 
**(4) logts.m**
 - Estmation of equation (33) in the original paper. This gives the estimator for log-t test.

**(5) sorthat.m**
 - Returns the indices for the club membership, and tests whether if the series does converge.

**(6) PLOT2_hit.m**
 - Plots the transition paths for each convergence clubs.
