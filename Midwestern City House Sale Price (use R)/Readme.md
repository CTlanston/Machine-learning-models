# README.md for Midwestern City House Sale Price Prediction using k-NN Regression

## Project Overview
This project focuses on predicting house sale prices in a Midwestern U.S. city using k-Nearest Neighbors (k-NN) regression. The data, from home sales between 2006 and 2010, has been detrended and adjusted to reflect prices as if they occurred in May 2010.

## Objective
To apply k-NN regression for predicting sale prices, evaluating the model's performance through mean squared error (MSE) analysis.

## Data
The dataset contains 2930 observations, featuring sale prices and attributes like lot area, total basement area, above-ground living area, number of bathrooms, number of bedrooms, and building age.

## Methodology
1. **Data Splitting**: Randomly split the data into training, validation, and test sets with a single-family home focus.
2. **k-NN Regression**: Apply k-NN regression to predict sale prices.
3. **MSE Analysis**: Evaluate the model's performance using MSE, particularly analyzing how it varies with different k values.
4. **Standardization and Transformation**: Experiment with standardizing and transforming variables to improve model accuracy.

## Deliverables
- R script implementing k-NN regression and analysis.
- Plots of MSE vs. k for various model iterations.
- A comprehensive report summarizing findings, including model performance and the impact of different preprocessing techniques.

---
*Note: This README provides an overview of the project's objectives and methodology. For detailed insights and methodologies, refer to the R script and the accompanying report.*
