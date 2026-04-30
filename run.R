#!/usr/bin/env Rscript

library(argparse)

# Source main functions
source("src/main.R")

# Parse command line arguments
parser <- ArgumentParser(description="OmniBenchmark module")

# Required by OmniBenchmark
parser$add_argument("--output_dir", dest="output_dir", type="character", required=TRUE,
                   help="Output directory for results")
parser$add_argument("--name", dest="name", type="character", required=TRUE,
                   help="Module name/identifier")
# Stage-specific inputs
parser$add_argument("--pca", dest="pca",
                   type="character", nargs="+", required=TRUE,
                   help="Input: pca")

args <- parser$parse_args()

cat("Output directory:", args$output_dir, "\n")
cat("Module name:", args$name, "\n")
cat("pca:", args$pca, "\n")

# TODO: Implement your module logic
# Process the data using main function
process_data(args)
