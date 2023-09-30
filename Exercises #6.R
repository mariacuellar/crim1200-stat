
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




library(tidyverse)

samplesize = 300

crimetype <- sample(1:3, size = samplesize, replace = TRUE, prob = c(.07, .3, .5))
crimetype <- as.factor(crimetype)
levels(crimetype) <- c("murder", "aggravated assault", "forcible rape")

crimetype

age <- rnorm(n=samplesize, mean=39, sd=10)
age <- ifelse(age<=18, 18, age)
hist(age, xlim=c(0,100))
age <- round(age, digits = 0)

age  
  
gender <- rbinom(n=samplesize, size=1, prob=0.1)
gender <- as.factor(gender)
levels(gender) <- c("male", "female")

gender

# install.packages("FamilyRank")
library(FamilyRank)
mentalhealthscore <- rbinorm(n=samplesize, mean1=5, mean2=15, sd1=2, sd2=3, prop=.5)
mentalhealthscore <- ifelse(mentalhealthscore <= 0, 0 , mentalhealthscore)
hist(mentalhealthscore)
mentalhealthscore <- round(mentalhealthscore, digits = 1)

mentalhealthscore



  crime.dat <- data.frame(crimetype, age, gender, mentalhealthscore)

as_tibble(crime.dat)

write.csv(crime.dat, "/Users/mariacuellar/Documents/Penn/Classes/Statistics for the Social Sciences - Crim 1200/Fall 2023/Quizzes/crime.dat.csv", row.names=FALSE)

crime.dat %>% ggplot(aes(x=gender, y=mentalhealthscore)) + geom_boxplot()

plot(crime.dat$age, crime.dat$mentalhealthscore)












cbind(crimetype, age, )


barplot(table(dat$education, dat$gender), beside=TRUE)
legend("topleft", c("A","B"))

melt(dat) %>% ggplot(aes(x=education, y=value, fill=gender)) + geom_bar(stat="identity", position="dodge")

melt(dat) %>% ggplot(aes(x=gender, y=value, fill=education)) + geom_bar(stat="identity", position="dodge")

melt(dat) %>% ggplot(aes(x=gender, y=value)) + geom_bar(stat="identity")
 


df = melt(data.frame(A=c(2, 10), B=c(3, 20), 
                     experiment=c("X", "X & Y")),
          variable_name="metric")

ggplot(df, aes(experiment, value, fill=metric)) + 
  geom_bar(position="dodge")












