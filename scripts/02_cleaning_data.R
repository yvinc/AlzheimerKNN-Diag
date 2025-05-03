# author: Vincy Huang
# date: 2025-05-03
" This scripts wrangles and cleans the raw OASIS-2 dataset and saves the
  processed dataset for further summary computation and modelling.
Usage: 02_cleaning_data.R --input_raw_data=<input_raw_data> --output_data_fct=<output_data_fct> --output_data_unique_name=<output_data_unique_name> --dementia_filter_levels_tbl=<dementia_filter_levels_tbl> --dementia_levels_tbl=<dementia_levels_tbl> --output_cleaned_data=<output_cleaned_data>

Options:
--input_raw_data=<input_raw_data>
--output_data_fct=<output_data_fct> Path to factorized dataset preview.
--output_data_unique_name=<output_data_unique_name> Path to dataset with unique col names.
--dementia_filter_levels_tbl=<dementia_filter_levels_tbl> Path to table that shows all 3 target levels.
--dementia_levels_tbl=<dementia_levels_tbl> Path to table that shows target levels with Converted removed.
--output_cleaned_data=<output_cleaned_data> Path to cleaned OASIS-2 dataset
" -> doc
library(dplyr)
library(docopt)
library(forcats)
library(readr)
library(tibble)

opt <- docopt(doc)
dementia_df <- read_csv(opt$input_raw_data)

dementia <- dementia_df |>
  mutate(across(c("Group", "Sex", "Hand", "SES", "CDR"), as_factor))
write_csv(dementia, opt$output_data_fct) # factorized data set

unique_names <- make.names(names(dementia), unique = TRUE)
colnames(dementia) <- unique_names
write_csv(dementia, opt$output_data_unique_name) # data set with unique name

dementia <- dementia |>
  select(-c(SES, CDR, Hand)) # select only variables of interest

# 1st Attempt to filter out "Converted"
dementia_filter <- dementia |>
  filter(Group != "Converted")

dementia_filter_levels <- dementia_filter |>
                          pull(Group) |>
                          levels() |>
                          as_tibble()
write_csv(dementia_filter_levels, opt$dementia_filter_levels_tbl) # target var level


# 2nd Attempt to filter out "Converted"
dementia <- dementia |>
  filter(Group != "Converted") |>
  mutate(Group = fct_drop(Group))

dementia_levels <- dementia |>
  pull(Group) |>
  levels() |>
  as_tibble() # Group no longers has the factor level 'Converted'.
write_csv(dementia_filter_levels, opt$dementia_levels_tbl)

dementia <- dementia |>
  filter(!is.na(MMSE)) # remove empty NA value from MMSE
write_csv(dementia, opt$output_cleaned_data)
# Rscript scripts/02_cleaning_data.R --input_raw_data="data/processed/01_loaded_data.csv" --output_data_fct="data/processed/02_factorized_data.csv" --output_data_unique_name="data/processed/03_unique_names_data.csv" --dementia_filter_levels_tbl="results/tables/01_mmse_cate_levels.csv" --dementia_levels_tbl="results/tables/02_mmse_cate_levels.csv" --output_cleaned_data="data/processed/04_cleaned_data.csv"

