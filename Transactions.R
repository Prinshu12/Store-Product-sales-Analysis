install.packages("arules")
install.packages("arulesViz")
library(arulesViz)


set.seed(52)

transactions_data1<-read.transactions("transactions.csv", format = "single", sep = ",",cols = c("Transaction","Product"), rm.duplicates = FALSE)

head(transactions_data1)

itemFrequencyPlot(transactions_data1,topN=10,type="absolute")
 
# Generate rules and sort by lift
rules <- apriori(transactions_data1, parameter = list(supp = 0.03, conf = 0.20, minlen = 2, maxlen = 4))
rules <- sort(rules, by="lift", decreasing=TRUE)

# Limit output to 2 digits
options(digits=2)

summary(rules)
inspect(rules)

# Remove duplicate rules
redundant_index <- is.redundant(rules)
redundant_index
pruned_rules <- rules[!redundant_index]
pruned_rules
inspect(pruned_rules[1:9])
summary(pruned_rules)


plot(pruned_rules,method="graph",interactive=FALSE,shading=NA)


