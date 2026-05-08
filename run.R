#!/usr/bin/env Rscript

suppressPackageStartupMessages({
  library(argparse)
  library(data.table)
})

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
parser$add_argument("--pcas.tsv", dest="pcas.tsv",
                   type="character", required=FALSE,
                   help="Input: PCs TSV file")
parser$add_argument("--flavour", dest="flavour",
                   type="character", required=FALSE,
                   help="Input: flavour on non-linear embedding")
parser$add_argument("--rawdata.h5ad", dest="rawdata.h5ad",
                   type="character", required=FALSE,
                   help="Input: file with raw H5 AnnData")
parser$add_argument("--filtered.cellids", dest="filtered.cellids",
                   type="character", required=FALSE,
                   help="Input: file with the filtered cell ids")

#parser$add_argument("--perplexity", dest="perplexity",
#                   type="integer", required=FALSE,
#                   help="Input: perplexity value")

args <- parser$parse_args()

cat("Output directory:", args$output_dir, "\n")
cat("Module name:", args$name, "\n")
cat("pca:", args$pcas.tsv, "\n")
cat("flavour:", args$flavour, "\n")


# possible scrapper_UMAP params to expose
#> scrapper:::run_umap
#function (nnidx, nndist, ndim, min_dist, seed, num_epochs, num_threads, 
#    parallel_optimization) 
#{
#    .Call("_scrapper_run_umap", PACKAGE = "scrapper", nnidx, 
#        nndist, ndim, min_dist, seed, num_epochs, num_threads, 
#        parallel_optimization)
#}


if (args$flavour == "scrapper_UMAP") {
  require(scrapper)
  pca <- fread(args$pcas.tsv, header = TRUE)
  embed <- runUmap(pca) # maybe add params
} else if (args$flavour == "XXX") {
  # do something here
} else {
  errorCondition("incorrect 'flavour' specified")
}

out <- file.path(args$output_dir, paste0(args$name, "_lowdviz.tsv"))
cat("output_file:", out, "\n")
fwrite(data.frame(cell_id = rownames(embed), embed), out, 
       sep = "\t", quote = FALSE, row.names = FALSE)
file.info(out)[,c("size", "ctime")]


