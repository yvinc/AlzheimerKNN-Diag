# author: Vincy Huang
# date: 2025-05-03
"This script generate boxplot comparisons of EDUC, MMSE, and nWBV between
Demented & Nondemented patient groups and saves the plots locally.

Usage: 05_summary_vis.R --training_set=<training_set> --educ_boxplot=<educ_boxplot> --mmse_boxplot=<mmse_boxplot> --nwbv_boxplot=<nwbv_boxplot>
" -> doc
# Rscript scripts/05_summary_vis.R --training_set="data/processed/05_training_set.csv" --educ_boxplot="results/figures/01_educ_boxplot.png" --mmse_boxplot="results/figures/02_mmse_boxplot.png" --nwbv_boxplot="results/figures/03_nwbv_boxplot.png"
library(ggplot2)
library(readr)
library(docopt)
library(RColorBrewer)

opt <- docopt(doc)
dementia_train <- read_csv(opt$training_set)
# Boxplot Comparison: Education
options(repr.plot.width = 11)
education_boxplot <- dementia_train |>
  ggplot(aes(x = Group, y = EDUC, fill = Group)) +
  geom_boxplot(outlier.size = 2) +
  theme(text = element_text(size = 20)) +
  labs(y = "Highest Level of Education Completed (years)")+
  ggtitle("Comparison of EDUC Between \n Demented & Nondemented Groups")

education_boxplot + scale_fill_brewer(palette = "RdYlBu")
ggsave(opt$educ_boxplot)

# Boxplot Comparison: MMSE
options(repr.plot.width = 11)
MMSE_boxplot <- dementia_train |>
  ggplot(aes(x = Group, y = MMSE, fill = Group)) +
  geom_boxplot() +
  theme(text = element_text(size = 20)) +
  labs(y = "Mental State Examination Scores")+
  ggtitle("Comparison of MMSE Between \n Demented & Nondemented Groups")

MMSE_boxplot + scale_fill_brewer(palette = "RdYlBu")
ggsave(opt$mmse_boxplot)

# Boxplot Comparison: nWBV
options(repr.plot.width = 11)
nWBV_boxplot <- dementia_train |>
  ggplot(aes(x = Group, y = nWBV, fill = Group)) +
  geom_boxplot() +
  theme(text = element_text(size = 20)) +
  labs(y = "Total Brain Volume Estimates (normalized unit)")+
  ggtitle("Comparison of nWBV Between \n Demented & Nondemented Groups")

nWBV_boxplot + scale_fill_brewer(palette = "RdYlBu")
ggsave(opt$nwbv_boxplot)

