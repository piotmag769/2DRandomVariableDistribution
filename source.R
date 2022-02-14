# functions' description in task_description.md file
prob <- function(m)
{
  m/sum(m)
}


boundary <- function(prob, i)
{
  if (i == 1)
    return(rowSums(prob, na.rm=FALSE))
  if (i == 2)
    return(colSums(prob, na.rm=FALSE))
}


conditional <- function(prob, i, v)
{
  if (i == 1)
    return(prob[v,]/sum(prob[v,]))
  
  if (i == 2)
    return(prob[,v]/sum(prob[,v]))
}


mean <- function(prob, i=NA)
{
  x_mean <- sum(c(1:nrow(prob))*boundary(prob, 1))
  y_mean <- sum(c(1:ncol(prob))*boundary(prob, 2))

  if(is.na(i))
    return(c(x_mean, y_mean))
  if (i==1)
    return(x_mean)
  if (i==2)
    return(y_mean)
}


covariance <- function(prob)
{
  x_mean <- mean(prob, 1)
  y_mean <- mean(prob, 2)
  
  covar <- (-x_mean*y_mean)
  for(x in 1:nrow(prob))
    for(y in 1:ncol(prob))
      covar <- covar + prob[[x,y]]*x*y
  
  x_bound <- boundary(prob, 1)
  y_bound <- boundary(prob, 2)
  
  var_x <- 0
  var_y <- 0
  
  for(x in 1:length(x_bound))
    var_x <- var_x + (x-x_mean)^2*x_bound[[x]]
  
  for(y in 1:length(y_bound))
    var_y <- var_y + (y-y_mean)^2*y_bound[[y]]
  
  res <- matrix(nrow = 2, ncol = 2)
  res[[1,2]] <- covar
  res[[2,1]] <- covar
  res[[1,1]] <- var_x
  res[[2,2]] <- var_y
  
  return(res)
}


independent <- function(prob)
{
  x_bound <- boundary(prob, 1)
  y_bound <- boundary(prob, 2)
  
  for(x in 1:nrow(prob))
    for(y in 1:ncol(prob))
      if(prob[[x,y]] != x_bound[[x]]*y_bound[[y]])
        return(FALSE)
  
  return(TRUE)
}


# getting input from file
input <- as.matrix(read.table(commandArgs(trailingOnly=TRUE), header=FALSE, sep=" "))

probability <- prob(input)

# just printing output
cat("\nProbability table:\n")
print(probability)
cat("\nMarginal distribution of X:\n", boundary(probability, 1))
cat("\n\nMarginal distribution of Y:\n", boundary(probability, 2))
cat("\n\nProbability distribution of X under condition that Y=1:\n", conditional(probability, 2, 1))
cat("\n\nProbability distribution of Y under condition that X=1:\n", conditional(probability, 1, 1))
cat("\n\nMean value of X: ", mean(probability, 1))
cat("\n\nMean value of Y: ", mean(probability, 2))
cat("\n\nCovariance matrix:\n")
print(covariance(probability))
cat("\nAre X and Y independent?: ", independent(probability))
