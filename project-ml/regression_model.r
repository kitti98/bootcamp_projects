# build a regression model

head(mtcars)

model <- lm(mpg ~ hp + wt, data = mtcars)

summary(model)
