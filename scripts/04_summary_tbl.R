# author: Vincy Huang
# date: 2025-05-03
"This script produces summary tables for the training OASIS-2 data set,
summarizing the proportion of MMSE of Non-demented and Demented target patients
and compute mean statistic of each predictor variable chosen: `EDUC` `MMSE` `nWBV`.

Usage: 04_summary_tbl.R --training_set=<training_set> --summary_tbl_mmse_prop=<summary_tbl_mmse_prop> --summary_tbl_predictors_mean=<summary_tbl_predictors_mean>
" -> doc
library(docopt)
library(dplyr)
library(readr)
library(purrr)
opt <- docopt(doc)

dementia_train <- read_csv(opt$training_set)
# Table 1
class_table <- dementia_train |>
  group_by(Subject.ID, Group) |>
  summarize(Count = n()) |>
  group_by(Group) |>
  summarize(Count = n())
write_csv(class_table, opt$summary_tbl_mmse_prop)


# Table 2
predictor_mean_table <- dementia_train |>
  select(EDUC, MMSE, nWBV)|>
  map_df(mean, na.rm = TRUE)

write_csv(predictor_mean_table, opt$summary_tbl_predictors_mean)

# Rscript scripts/04_summary_tbl.R --training_set="data/processed/05_training_set.csv" --summary_tbl_mmse_prop="results/tables/03_summary_tbl_mmse_prop.csv" --summary_tbl_predictors_mean="results/tables/04_summary_tbl_predictors_mean.csv"
