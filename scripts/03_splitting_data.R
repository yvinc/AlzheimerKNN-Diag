# author: Vincy Huang
# date: 2025-05-03
"This scripts splits the processed OASIS-2 data into training and testing sets
and set seed to ensure reproducibility of the randomization involved.

Usage: 03_splitting_data.R --input_path=<input_path> --training_data=<training_data> --testing_data=<testing_data>
" -> doc
library(readr)
library(tidymodels)
library(docopt)
library(forcats)
set.seed(999)
opt <- docopt(doc)
dementia <- read_csv(opt$input_path) |>
            mutate(Group = as_factor(Group))

dementia_split <- initial_split(dementia, prop = 0.75, strata = Group)
dementia_train <- training(dementia_split)
dementia_test  <- testing(dementia_split)

write_csv(dementia_train, opt$training_data)
write_csv(dementia_train, opt$testing_data)

# Rscript scripts/03_splitting_data.R --input_path="data/processed/04_cleaned_data.csv" --training_data="data/processed/05_training_set.csv" --testing_data="data/processed/06_testing_set.csv"
