
# load packages
library(tidyverse)
library(palmerpenguins)
library(ggplot2)


# Manipulating data guidelines


# (From https://cran.r-project.org/web/packages/dplyr/vignettes/dplyr.html)


?penguins
penguins
View(penguins)

# SELECTING SOME OBSERVATIONS
penguins %>% filter(species == "Adelie")


# REORDERING ROWS
penguins %>% arrange(bill_length_mm) # sort by bill length

penguins %>% arrange(desc(bill_length_mm)) # sort by reverse bill length


# CHOOSING ROWS
# Choose rows using their position using slice()
penguins %>% slice(3:4) # select only rows 3 and 4

penguins %>% slice_tail(n=5) # see the last five rows

penguins %>% slice_sample(n=5) # see a random sample of five rows

penguins %>% slice_sample(n=5, replace=TRUE) # same, but sample with replacement

penguins %>% slice_max(bill_length_mm, n=1) # select row that has the highest bill_length_mm


# SELECT A SPECIFIC COLUMN
penguins %>% select(bill_length_mm) # select a single column, bill_length_mm

penguins %>% select(bill_length_mm) %>% max(na.rm = TRUE) 

# find the maximum of that column. note: if there are missing NA values, just add "na.rm = TRUE".


# ADD NEW COLUMN
penguins %>% mutate(bill_length_m = bill_length_mm / 1000) # made new column that's in meters now

penguins %>% mutate(bill_length_m = bill_length_mm / 1000, .keep = "none") # same but only keep new var


# MAKE A FREQUENCY TABLE
penguins %>% count(species) # create a frequency table, same as table(species) in base R


# SUMMARIZE VALUES
# get the mean for a specific
penguins %>% summarise(avg = mean(flipper_length_mm, na.rm=TRUE),
                       med = median(flipper_length_mm, na.rm=TRUE),
                       n=n())


# summarize by group
penguins %>% group_by(species) %>% summarize(m=mean(bill_length_mm, na.rm=TRUE), 
                                             sd=sd(bill_length_mm, na.rm=TRUE),
                                             n=n()) # group by species

penguins %>% group_by(island) %>% summarize(m=mean(bill_length_mm, na.rm=TRUE), 
                                             sd=sd(bill_length_mm, na.rm=TRUE),
                                             n=n()) # group by island






# study penguin body mass

# EDA: describe the distribution, visually and quantiatively 

# EDA: what about penguins that are of different species? Describe their differences in body mass

# Quantitative EDA overall

# quick summary
summary(penguins$body_mass_g)

# summarizing by the statistics I want
penguins %>% summarise(mean = mean(body_mass_g, na.rm=TRUE),
                       med = median(body_mass_g, na.rm=TRUE),
                       n=n(),
                       sd = sd(body_mass_g, na.rm=TRUE))

# base R
hist(penguins$body_mass_g)

# w ggplot
penguins %>% ggplot(aes(x=body_mass_g)) + geom_histogram()

# Actually, the quantitative EDA should show median and IQR
penguins %>% summarise(median = median(body_mass_g, na.rm=TRUE),
                       IQR = IQR(body_mass_g, na.rm=TRUE),
                       n=n())


# Quantitative EDA by species category
penguins %>% group_by(species) %>% summarize(mean=mean(body_mass_g, na.rm=TRUE), 
                                             sd=sd(body_mass_g, na.rm=TRUE), 
                                             n=n())


# by species, colors by category
penguins %>% ggplot(aes(x=body_mass_g, fill=species)) + geom_histogram()

# by species, facetted horizontally
penguins %>% ggplot(aes(x=body_mass_g)) + geom_histogram() + facet_grid(.~species)

# by species facetted vertically
penguins %>% ggplot(aes(x=body_mass_g)) + geom_histogram() + facet_grid(vars(species), scales="free_y")

# compare two quantitative variables using scatterplot
penguins %>% ggplot(aes(x=body_mass_g, y=flipper_length_mm, color=species)) + geom_point()

