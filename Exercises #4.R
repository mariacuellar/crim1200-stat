
# load packages
library(tidyverse)
library(palmerpenguins)
library(ggplot2)
ggplot2::theme_set(ggplot2::theme_minimal())


penguins$bill_length_mm_char <- as.character(penguins$bill_length_mm)


# About the data
# Data were collected and made available by Dr. Kristen Gorman and the Palmer Station, Antarctica LTER, a member of the Long Term Ecological Research Network. The palmerpenguins package contains two datasets. One is called penguins, and is a simplified version of the raw data; see ?penguins for more info.
# Source: https://github.com/allisonhorst/palmerpenguins/blob/main/README.md
?penguins

# what does the data look like?
penguins
penguins <- na.omit(penguins)

# let's use the quantitative variable: flipper length
class(penguins$flipper_length_mm)

# summarize it
summary(penguins$flipper_length_mm)

# plot histogram using base R
hist(penguins$flipper_length_mm)

# plot histogram using ggplot
ggplot(data = penguins, aes(x = flipper_length_mm)) +
  geom_histogram( position = "identity")

# plot histogram, conditioning on species
ggplot(data = penguins, aes(x = flipper_length_mm)) +
  geom_histogram(aes(fill = species), alpha = 0.5, position = "identity") + 
  labs(x = "Flipper length (mm)",
       y = "Frequency",
       title = "Penguin flipper lengths")

# standard deviation for flipper length, only for adelie species
penguins %>% filter(species == "Adelie") %>% summarise(sd(flipper_length_mm))

# variance for this
penguins %>% filter(species == "Adelie") %>% summarise(var(flipper_length_mm))

# now mean, median, sd, var, iqr: all together, for adelie species
penguins %>% filter(species == "Adelie") %>% summarise(
  flipperlength_mean = mean(flipper_length_mm),
  flipperlength_median = median(flipper_length_mm),
  flipperlength_sd = sd(flipper_length_mm),
  flipperlength_var = var(flipper_length_mm),
  flipperlength_iqr = IQR(flipper_length_mm)
)




# EDA examples 

# histogram for quantitative var
ggplot(data = penguins, aes(x=flipper_length_mm)) + geom_histogram()

# comparing quantitative var (flipper length) with categorical var (species), with fill
ggplot(data = penguins, aes(x=flipper_length_mm, fill=species)) + geom_histogram()

# as above, but with facet wrap
ggplot(data = penguins, aes(x=flipper_length_mm)) + geom_histogram() + facet_wrap(vars(species))

# boxplot
penguins %>% ggplot(aes(x=flipper_length_mm, fill=species)) + geom_boxplot()

# scatterplot, 2 quantitative vars
penguins %>% ggplot(aes(x=flipper_length_mm, y=bill_length_mm)) + geom_point()

# scatterplot, 2 quantitative vars
penguins %>% ggplot(aes(x=flipper_length_mm, y=bill_length_mm, color=species)) + geom_point()



