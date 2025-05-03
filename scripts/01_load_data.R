# author: Vincy Huang
# date: 2025-05-03
"This script loads the OASIS-2 dataset from data folder, changees the `M/F` c
olumn name into `Sex`, and then saves the data with nicecly named columns locally.

Usage: 01_load_data.R --input_path=<input_path> --output_loaded_data=<output_loaded_data>

Options:
--input_path=<input_path>                 Path to the raw OASIS-2 dataset.
--output_loaded_data=<output_loaded_data> Path to the dataset with M/F column's name changed to Sex.
" -> doc
library(readr)
library(docopt)

opt <- docopt(doc)

dementia_df <- read_csv(opt$input_path)
colnames(dementia_df)[6] <- "Sex"

write_csv(dementia_df, opt$output_loaded_data)


# Rscript scripts/01_load_data.R --input_path="data/raw/oasis_longitudinal.csv" --output_loaded_data="data/processed/01_loaded_data.csv"
