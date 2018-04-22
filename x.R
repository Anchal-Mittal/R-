attach(iris)
iris
plot(density(iris$Sepal.Length), main = "Density of sepal length")

plot(density(iris$Sepal.Width), main = "Density of Sepal Width")

rug(iris$Sepal.width)
plot(hist(iris$Sepal.Length), main ="histogram of sepal length")
rug(iris$Sepal.Length)
attach(mtcars)
mtcars
