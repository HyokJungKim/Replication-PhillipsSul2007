# Replication_PhillipsSul

This is a replication of Phillips and Sul (2007) "Transition Modeling and Econometric Convergence Tests" Econometrica.

Original code of Phillips and Sul (2007) is written in Gauss, but I reimplemented their algorithm in Matlab.

The structure of the code is as follows:

(1) exm.m
 - The main scripting code which replicates the results in the paper.
 
(2) inflation_club.m
 - Alternative scripting code for my own purposes.
 
(3) allsort.m
 - prints output of club convergence tests, and club memberships
  
(4) andrs.m
 - HAC correction by Andrews (1991)
 
(5) logts.m
 - Estmation of equation (33) in the original paper. This gives the estimator for log-t test.

(6) sorthat.m
 - Returns the indices for the club membership, and tests whether if the series does converge.

(7) PLOT2_hit.m
 - Plots the transition paths for each convergence clubs.