# author: Vincy Huang
# date: 2025-05-03
"This scripts trains a knn classification based on the best K off the hyper-
parameter tunning and predict on the testing set, outputting the testing dataset
with its actual and predicted values along with the confusion matrix table and
visualization.

Usage: 07_knn_testing.R --training_data=<training_data> --testing_data=<testing_data> --knn_recipe=<knn_recipe> --tunning_accuracies_tbl=<tunning_accuracies_tbl> --tesing_pred_tbl=<tesing_pred_tbl> --testing_accuracy=<testing_accuracy> --conf_mat_tbl=<conf_mat_tbl> --conf_mat_plot=<conf_mat_plot>
" -> doc
# Rscript scripts/07_knn_testing.R --training_data="data/processed/05_training_set.csv" --testing_data="data/processed/06_testing_set.csv" --knn_recipe="results/models/01_knn_train_recipe.rds" --tunning_accuracies_tbl="results/tables/05_tunning_accuracies_tbl.csv" --tesing_pred_tbl="results/tables/06_tesing_pred_tbl.csv" --testing_accuracy="results/tables/07_testing_accuracy.csv" --conf_mat_tbl="results/tables/08_conf_mat.csv" --conf_mat_plot="results/figures/06_conf_mat_plot.png"

library(docopt)
library(readr)
library(dplyr)
library(ggplot2)
library(forcats)
library(tidymodels)
set.seed(999)

opt <- docopt(doc)

dementia_train <- read_csv(opt$training_data) |>
                  mutate(Group = as_factor(Group))

dementia_test <- read_csv(opt$testing_data) |>
                 mutate(Group = as_factor(Group))


accuracies <- read_csv(opt$tunning_accuracies_tbl)
optimal_k <- accuracies|>
             slice(1) |>
             pull(neighbors)

optimal_spec <- nearest_neighbor(weight_func = "rectangular", neighbors = optimal_k) |>
                set_engine("kknn") |>
                set_mode("classification")

dementia_recipe <- read_rds(opt$knn_recipe)

optimal_fit <- workflow() |>
               add_model(optimal_spec) |>
               add_recipe(dementia_recipe) |>
               fit(data = dementia_train)

optimal_predict <- predict(optimal_fit, dementia_test)
bind_predict <-  bind_cols(optimal_predict, dementia_test)
write_csv(bind_predict, opt$tesing_pred_tbl)

optimal_metrics <- bind_predict |>
  metrics(truth = Group, estimate = .pred_class) |>
  filter(.metric == "accuracy")
write_csv(optimal_metrics, opt$testing_accuracy)

confusion <- bind_predict |>
  conf_mat(truth = Group, estimate = .pred_class)
write_csv(tidy(confusion), opt$conf_mat_tbl)

options(repr.plot.width = 15)
autoplot(confusion, type = 'heatmap')
ggsave(opt$conf_mat_plot, width = 8, height = 6, units = "cm", dpi = 450)

