# author: Vincy Huang
# date: 2025-05-03
"This script performs hyperparameter (K) tunning for K-nearest Neighbor (KNN)
Classification algorithm to optimize the accuracy predicting patient Alzheimer's
state using three key predictors: `EDUC`, `MMSE`, and `nWBV`. Cross-validation
will be performed. This script also produces visualization of the accuracies
across a range of hyperparameters (K).

Usage: 06_knn_tunning.R --training_set=<training_set> --knn_recipe=<knn_recipe> --tunning_accuracies_tbl=<tunning_accuracies_tbl> --accuracy_vs_k_plot=<accuracy_vs_k_plot>
" -> doc
library(docopt)
library(dplyr)
library(tidyr)
library(readr)
library(forcats)
library(ggplot2)
library(tidymodels)
set.seed(999)

opt <- docopt(doc)
options(repr.plot.width = 13)
dementia_train <- read_csv(opt$training_set) |>
                  mutate(Group = as_factor(Group))

knn_spec <- nearest_neighbor(weight_func = "rectangular",
                             neighbors = tune()) |>
            set_engine("kknn") |>
            set_mode("classification")


dementia_recipe <- recipe(Group ~ EDUC + MMSE + nWBV, data = dementia_train) |>
                   step_scale(all_predictors()) |>
                   step_center(all_predictors())
write_rds(dementia_recipe, opt$knn_recipe)


dementia_vfold <- vfold_cv(dementia_train, v = 10, strata = Group)
kvals <- tibble(neighbors = seq(from = 1, to = 100, by = 5))
dementia_wrkflw <- workflow() |>
                   add_model(knn_spec) |>
                   add_recipe(dementia_recipe) |>
                   tune_grid(resamples = dementia_vfold, grid = kvals) |>
                   collect_metrics()

accuracies <- dementia_wrkflw |>
              filter(.metric == "accuracy") |>
              arrange(desc(mean))
write_csv(accuracies, opt$tunning_accuracies_tbl)

accuracy_vs_k <- ggplot(accuracies, aes(x = neighbors, y = mean)) +
                 geom_point() +
                 geom_line() +
                 labs(x = "K Neighbors", y = "Accuracy Estimate",
                      title = "Accuracy Estimates for Range of K = 1 to 100") +
                 theme(text = element_text(size = 16))
ggsave(opt$accuracy_vs_k_plot)

# Rscript scripts/06_knn_tunning.R --training_set="data/processed/05_training_set.csv" --knn_recipe="results/models/01_knn_train_recipe.rds" --tunning_accuracies_tbl="results/tables/05_tunning_accuracies_tbl.csv" --accuracy_vs_k_plot="results/figures/05_accuracy_vs_k_plot.png"
