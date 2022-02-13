# 2D Random Variable Distribution
Implementation of two dimensional random variable distribution in R made for Probability Theory and Statistics at AGH UST 2021/22.
## Task description
Write a script in R that implements a two-dimensional discrete distribution. The assumptions are as follows:
- The set of probable values ​​for S has the form {1,. . . . m} × {1,. . . , n} for some m, n ∈ N.
- The (full) distribution is realized in the form of a probability matrix with non-negative terms adding up to 1
i.e. if X and Y are components of a variable with an implemented distribution then prob [i, j] = P (X = i, Y = j).
- The matrices from the previous point are formed by the prob(m) function whose argument is the matrix of
non-negative numbers that do not necessarily add up to 1 - the function is to perform appropriate normalization (i.e. divide all words by their sum).
- The boundary(prob, i) function returns the boundary distribution vector with respect to the variable number i 
(i.e. boundary(prob, 1) returns the boundary distribution vector with respect to X).
- The function conditional(prob, i, v) returns the vector of a conditional distribution with respect to the value v
of variable number i e.g. conditional (prob, 1, 3) [2] = P (Y = 2 | X = 3).
- The function mean(prob, i) returns the expected value of the number i variable - if i has the value NA (which
to be default) the expected value vector should be returned.
- The covariance(prob) function returns the covariance matrix.
- The independent(prob) function returns TRUE if the members are independent, FALSE otherwise.