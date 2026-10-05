#!/usr/bin/env bash
set -euo pipefail

SUDO=""; [ "$(id -u)" -ne 0 ] && SUDO="sudo"

# ---- system libraries -------------------------------------------------------
# pandoc: needed by rmarkdown AND by htmlwidgets::saveWidget (the 3D plotly HTML files)
$SUDO apt-get update
$SUDO apt-get install -y --no-install-recommends \
  pandoc build-essential gfortran cmake \
  libcurl4-openssl-dev libssl-dev libxml2-dev \
  libfontconfig1-dev libfreetype6-dev libharfbuzz-dev libfribidi-dev \
  libpng-dev libtiff-dev libjpeg-dev \
  libcairo2-dev libxt-dev \
  libglpk-dev libgmp-dev libhdf5-dev \
  libgraphviz-dev \
  libgl1-mesa-dev libglu1-mesa-dev libx11-dev \
  libudunits2-dev
# concaveman needs V8; if unavailable the V8 R package will download its own static build
$SUDO apt-get install -y libnode-dev || echo "libnode-dev not available, V8 will fetch a static build"

# ---- R packages -------------------------------------------------------------
# Set CRAN_REPO to a dated Posit Package Manager snapshot matching the original run.
# Ubuntu 24.04 (Noble) binary path:
#   https://packagemanager.posit.co/cran/__linux__/noble/2026-06-12
export CRAN_REPO="${CRAN_REPO:-https://packagemanager.posit.co/cran/__linux__/noble/YYYY-MM-DD}"

Rscript - <<'EOF'
options(repos = c(CRAN = Sys.getenv("CRAN_REPO")), Ncpus = 4)
install.packages(c("BiocManager", "remotes"))
options(repos = BiocManager::repositories())   # so GitHub packages can resolve Bioconductor deps

# Bioconductor (release 3.22 for R 4.5.x)
BiocManager::install(c(
  "scDblFinder", "glmGamPoi", "SingleCellExperiment",
  "destiny", "slingshot",
  "limma", "edgeR",
  "clusterProfiler", "enrichplot", "EnhancedVolcano", "pathview",
  "AnnotationDbi", "org.Hs.eg.db",
  "ComplexHeatmap", "BiocNeighbors"
), ask = FALSE, update = FALSE)

# CRAN
install.packages(c(
  "Seurat", "SeuratObject", "Matrix", "future",
  "ggplot2", "patchwork", "ggrepel",
  "dplyr", "tidyr", "tibble", "purrr", "stringr",
  "here", "openxlsx", "viridis", "RColorBrewer",
  "clustree", "scCustomize", "ggforce", "concaveman",
  "msigdbr", "plotly", "htmlwidgets", "gridExtra", "ggridges",
  "reticulate", "FNN",
  "NMF", "circlize", "ggalluvial",           # CellChat dependencies
  "rmarkdown", "knitr"
))

# msigdbr >= 10 keeps its gene sets in a separate package
if (packageVersion("msigdbr") >= "10.0.0") {
  install.packages("msigdbdf",
    repos = c("https://igordot.r-universe.dev", Sys.getenv("CRAN_REPO")))
}

# GitHub — pin to a specific commit once your environment is finalised:
#   remotes::install_github("immunogenomics/presto@<commit>")
#   remotes::install_github("jinworks/CellChat@<commit>")
remotes::install_github("immunogenomics/presto")   # optional, speeds up FindAllMarkers / CellChat
remotes::install_github("jinworks/CellChat")
EOF

# ---- verify -----------------------------------------------------------------
# install.packages() only warns on failure; this block turns any missing
# package into a hard error so the build fails visibly rather than silently.
Rscript - <<'EOF'
pk <- c(
  # Seurat ecosystem
  "Seurat", "SeuratObject", "Matrix", "future",
  # Bioconductor – single-cell
  "scDblFinder", "glmGamPoi", "SingleCellExperiment",
  "destiny", "slingshot",
  # Bioconductor – DE / enrichment
  "limma", "edgeR",
  "clusterProfiler", "enrichplot", "EnhancedVolcano", "pathview",
  "AnnotationDbi", "org.Hs.eg.db",
  # Bioconductor – other
  "ComplexHeatmap", "BiocNeighbors",
  # Visualisation
  "ggplot2", "patchwork", "ggrepel", "viridis", "RColorBrewer",
  "plotly", "htmlwidgets", "gridExtra", "ggridges",
  "clustree", "scCustomize", "ggforce", "concaveman",
  # Tidyverse components
  "dplyr", "tidyr", "tibble", "purrr", "stringr",
  # Utilities
  "here", "openxlsx", "reticulate", "FNN",
  # CellChat and its CRAN dependencies
  "NMF", "circlize", "ggalluvial", "CellChat",
  # Reporting
  "rmarkdown", "knitr",
  # Gene sets
  "msigdbr"
)

# msigdbdf is only installed when msigdbr >= 10
if (requireNamespace("msigdbr", quietly = TRUE) &&
    packageVersion("msigdbr") >= "10.0.0") {
  pk <- c(pk, "msigdbdf")
}

bad <- pk[!vapply(pk, requireNamespace, logical(1), quietly = TRUE)]
if (length(bad)) stop("Failed to install: ", paste(bad, collapse = ", "))
cat("All packages installed successfully.\n")
EOF
