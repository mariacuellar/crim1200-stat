
# load packages
library(tidyverse)
library(palmerpenguins)
library(ggplot2)
ggplot2::theme_set(ggplot2::theme_minimal())




# EDA examples 

# histogram for quantitative var
ggplot(data = penguins, aes(x=flipper_length_mm)) + geom_histogram()

# comparing quantitative var (flipper length) with categorical var (species), with fill
ggplot(data = penguins, aes(x=flipper_length_mm, fill=species)) + geom_histogram()

# as above, but with facet wrap
ggplot(data = penguins, aes(x=flipper_length_mm)) + geom_histogram() + facet_wrap(vars(species))

# boxplot
penguins %>% ggplot( aes(x=flipper_length_mm, fill=species)) + geom_boxplot()

# scatterplot, 2 quantitative vars
penguins %>% ggplot(aes(x=flipper_length_mm, y=bill_length_mm)) + geom_point()

# scatterplot, 2 quantitative vars
penguins %>% ggplot(aes(x=flipper_length_mm, y=bill_length_mm, color=species)) + geom_point()




# load packages
library(tidyverse)
library(palmerpenguins)
library(ggplot2)
ggplot2::theme_set(ggplot2::theme_minimal())


# Manipulating data
# (From https://cran.r-project.org/web/packages/dplyr/vignettes/dplyr.html)

# SELECTING SOME OBSERVATIONS
# filter() allows you to select a subset of rows in a data frame. Like all single verbs, the first argument is the tibble (or data frame). The second and subsequent arguments refer to variables within that data frame, selecting rows where the expression is TRUE.
penguins %>% filter(species == "Adelie")

# REORDERING ROWS
# arrange() works similarly to filter() except that instead of filtering or selecting rows, it reorders them. It takes a data frame, and a set of column names (or more complicated expressions) to order by. If you provide more than one column name, each additional column will be used to break ties in the values of preceding columns

penguins

penguins %>% arrange(bill_length_mm) # sort by bill length

penguins %>% arrange(desc(bill_length_mm)) # sort by reverse bill length

# CHOOSING ROWS
# Choose rows using their position using slice()
penguins %>% slice(3:4)

penguins %>% slice_tail(n=5) # see the last five rows

penguins %>% slice_sample(n=5) # see a random sample of five rows

penguins %>% slice_sample(n=5, replace=TRUE) # sample with replacement

penguins %>% slice_max(bill_length_mm, n=1) # select row for highest bill_length_mm


# SELECT A SPECIFIC COLUMN
penguins %>% select(bill_length_mm) # select a single column, bill_length_mm

penguins %>% select(bill_length_mm) %>% max(na.rm = TRUE) # find the maximum of that column. note: if there are missing NA values, just add "na.rm = TRUE".


# ADD NEW COLUMN
penguins %>% mutate(bill_length_m = bill_length_mm / 1000) # made new column that's in meters now

penguins %>% mutate(bill_length_m = bill_length_mm / 1000, .keep = "none") # only keeps new var


# SUMMARIZE VALUES
# get the mean for a specific
penguins %>% summarise(avg=mean(flipper_length_mm, na.rm=TRUE))

# create a frequency table
penguins %>% count(species)


# 










