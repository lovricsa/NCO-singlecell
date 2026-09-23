## Requirements & Dependencies

This project was developed under the following environment:
* **R Version:** 4.5.2
* **OS:** Ubuntu 24.04.4 LTS (x86_64-pc-linux-gnu)

## Setup R packages

Run the following R snippet to automatically check for and install any missing packages required by this project (handles CRAN and Bioconductor dependencies):

```r
# List of required packages
required_packages <- c(
  "Biobase", "BiocGenerics", "biomaRt", "CellChat", "clusterProfiler", 
  "clustree", "ComplexHeatmap", "concaveman", "DESeq2", "destiny", 
  "DoubletFinder", "dplyr", "DT", "edgeR", "EnhancedVolcano", "forcats", 
  "future", "generics", "GenomicRanges", "ggforce", "ggplot2", "ggraph", 
  "ggrepel", "here", "htmltools", "htmlwidgets", "igraph", "IRanges", 
  "limma", "lubridate", "Matrix", "MatrixGenerics", "matrixStats", 
  "monocle3", "msigdbr", "openxlsx", "patchwork", "pathview", "plotly", 
  "princurve", "purrr", "RColorBrewer", "readr", "reticulate", "S4Vectors", 
  "scCustomize", "scDblFinder", "Seqinfo", "Seurat", "SeuratObject", 
  "SeuratWrappers", "SingleCellExperiment", "slingshot", "sp", "stringr", 
  "SummarizedExperiment", "tibble", "tidyr", "tidyverse", "TrajectoryUtils", 
  "viridis", "viridisLite",  "knitr", "enrichplot", "AnnotationDbi",
  "org.Hs.eg.db" 
)

# Ensure BiocManager is installed
if (!requireNamespace("BiocManager", quietly = TRUE)) {
  install.packages("BiocManager")
}

# Identify missing packages
missing_packages <- required_packages[!(required_packages %in% installed.packages()[, "Package"])]

# Install missing packages
if (length(missing_packages) > 0) {
  message("Installing missing packages: ", paste(missing_packages, collapse = ", "))
  BiocManager::install(missing_packages, ask = FALSE)
} else {
  message("All required packages are already installed!")
}
```

> **Note on GitHub-only packages:** If any package (e.g., `CellChat`, `monocle3`, `DoubletFinder`) fails to install via `BiocManager`, install `remotes` via `install.packages("remotes")` and install directly from their respective GitHub repositories.

---

<details>
<summary><b>Click to view full R sessionInfo()</b></summary>

```text
R version 4.5.2 (2025-10-31)
Platform: x86_64-pc-linux-gnu
Running under: Ubuntu 24.04.4 LTS

Matrix products: default
BLAS:   /usr/lib/x86_64-linux-gnu/blas/libblas.so.3.12.0 
LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0

locale:
 [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C               LC_TIME=hu_HU.UTF-8        LC_COLLATE=en_US.UTF-8     LC_MONETARY=hu_HU.UTF-8    LC_MESSAGES=en_US.UTF-8    LC_PAPER=hu_HU.UTF-8      
 [8] LC_NAME=C                  LC_ADDRESS=C               LC_TELEPHONE=C             LC_MEASUREMENT=hu_HU.UTF-8 LC_IDENTIFICATION=C       

time zone: Europe/Budapest
tzcode source: system (glibc)

attached base packages:
[1] stats4    grid      stats     graphics  grDevices utils     datasets  methods   base      

other attached packages:
 [1] viridis_0.6.5                viridisLite_0.4.3            lubridate_1.9.5              forcats_1.0.1                purrr_1.2.2                  readr_2.2.0                  tibble_3.3.1                
 [8] tidyverse_2.0.0              tidyr_1.3.2                  stringr_1.6.0                slingshot_2.16.0             TrajectoryUtils_1.16.1       princurve_2.1.6              SeuratWrappers_0.4.0        
[15] scCustomize_3.3.0            Seurat_5.5.0                 SeuratObject_5.4.0          sp_2.2-1                     scDblFinder_1.25.0           reticulate_1.46.0            RColorBrewer_1.1-3          
[22] plotly_4.12.0                pathview_1.48.0              patchwork_1.3.2              openxlsx_4.2.8.1             msigdbr_26.1.0               monocle3_1.4.26              SingleCellExperiment_1.32.0
[29] Matrix_1.7-4                 htmlwidgets_1.6.4            htmltools_0.5.9              here_1.0.2                   ggforce_0.5.0                future_1.70.0                EnhancedVolcano_1.26.0      
[36] ggrepel_0.9.8                edgeR_4.6.3                  limma_3.66.0                 DT_0.34.0                    DoubletFinder_2.0.6          destiny_3.24.0               DESeq2_1.48.2               
[43] SummarizedExperiment_1.40.0 MatrixGenerics_1.22.0        matrixStats_1.5.0            GenomicRanges_1.62.1         Seqinfo_1.0.0                IRanges_2.44.0               S4Vectors_0.48.1            
[50] concaveman_1.2.0             ComplexHeatmap_2.24.1        clustree_0.5.1               ggraph_2.2.2                 clusterProfiler_4.17.0       CellChat_2.2.0               Biobase_2.70.0              
[57] BiocGenerics_0.56.0          generics_0.1.4               ggplot2_4.0.3                igraph_2.3.1                 dplyr_1.2.1                  biomaRt_2.64.0              
```

</details>

# Scripts details

## Demultiplexing and Index Hopping Analysis (`anal0_index_hopping.rmd`)

### Description
Analyzes single-cell RNA-seq demultiplexing statistics, undetermined read rates, top unassigned barcode combinations (e.g., polyG artifacts), and sample-to-sample index hopping directionality/burden from Illumina flowcell sequencing outputs.

### Required Input Files
- `Data/BS_stats_anonymous.xlsx`: Excel file containing three required sheets:
  - `Demultiplex_Stats`: Per-sample read counts and index mismatch percentages.
  - `Top_Unknown_Barcodes`: Frequent unassigned index sequences.
  - `Index_Hopping_Counts`: Sample index definitions and observed hopped read counts.

### Output Files
- Compiled R Markdown report (`.html` or `.pdf`) containing:
  - Flowcell sequencing yield and undetermined read statistics table.
  - Per-sample demultiplexing performance table and read balance bar plot.
  - Top 20 undetermined index combinations table.
  - Per-sample index hopping burden table and donor-recipient heatmap.

## Single-Cell Neuroblastoma Organoids: Quality Control & Preprocessing (`anal1_quality_control.rmd`)

### Description
Performs comprehensive single-cell RNA-seq quality control on neuroblastoma organoids. The pipeline loads CS genetics' raw feature-barcode matrices, calculates cell quality metrics (mitochondrial, ribosomal, and hemoglobin read percentages), applies sample-specific adaptive thresholding using Median Absolute Deviation (MAD), runs an iterative `scDblFinder` convergence algorithm to flag multiplets, filters out male/female doublet artifacts (XXY cells), scores cell stress and sex-linked markers, quantifies transgene expression (`MYCN` and `EGFP`), and performs sample-level cell cycle phase classification.

### Required Input Files
GEO GSE335864: count matrix output triplets for all 8 samples obtained by running the CS genetics' pipeline on the raw fastq files are available from the custom GSE335864_RAW.tar archive
  - `*_matrix.mtx.gz`
  - `*_barcodes.tsv.gz`
  - `*_features.tsv.gz`
After download, these files should be saved into the folder Data/count_matrix/

## Integration & Resolution Testing (`anal2_integration_and_markers.rmd`)

### Description
Integrates cell line backgrounds (EpiC / H1 vs kolf2 / H2), generates sample-split UMAPs with spatial concave hulls (concaveman/ggforce), calculates module scores for neuroblastoma lineages (sympathoblast, chromaffin, SCP, bridging, MES, proliferation), and exports per-resolution cluster markers into multi-sheet Excel workbooks.

### Required Input Files
Data_calculated/seu_final.rds: Preprocessed Seurat object from Script anal1_quality_control.rmd.

# Single-Cell RNA-Seq Resolution Selection & Marker Analysis (`anal3_selected_resolution.rmd`)

Executes targeted downstream analysis, metadata standardization, differential expression testing, and visualization for integrated scRNA-seq datasets. Toggle between ct <- "EpiC" and ct <- "kolf2" to analyse either of the cell types.

### Required Input Files

Pre-processed Seurat RDS files located at `Results/seu_integrated_clusters_<ct>_all_nHVG<nHVG>.rds`.
`Rscripts/config.R` — configuration file.
`Rscripts/utils.R` — utility functions file.

### Notes and caveats

- The cell line to process is set manually via `ct <- "EpiC"` near the top
  of the mapping chunk; re-run with `ct <- "kolf2"` to process the other
  line.

## Reference Mapping (`anal4_reference_mapping.rmd`)

This step builds a harmonized single-cell reference atlas of neuroblastoma/adrenal
development from multiple public datasets. The organoid dataset is mapped onto the reference atlas or the the individual references to obtain annotations.

### Required Input Files

`Data_public/<reference files>` — raw public reference `.rds` Seurat
  objects, one per entry in `ref_info` (defined in `Rscripts/config.R`).
`Results/seu_integrated_clusters_newnames_<ct>_all_nHVG<nHVG_str>.rds` —
  clustered/annotated query object produced by the earlier steps in this
  pipeline.
`Rscripts/config.R` — configuration file.
`Rscripts/utils.R` — utility functions file.


### Notes and caveats

The cell line to process is set manually via `ct <- "EpiC"` near the top
  of the mapping chunk; re-run with `ct <- "kolf2"` to process the other
  line.


## Diffusion map and pseudotime (Slingshot) analysis (`anal5_diffusion_plot.rmd`)

Loads the annotated, integrated Seurat object produced by an earlier
step, subsets it to a specific cell line (`kolf2` or `EpiC`) and
timepoint, computes a diffusion map on the PCA
embedding, and infers pseudotime trajectories with `slingshot` along two
independently defined lineages:

1. **SCP → chromaffin/sympathoblast** lineage
2. **Fibroblast/mesenchymal (MES)** lineage

### Inputs

`Results/seu_integrated_clusters_newnames_<ct>_all_nHVG<nHVG_str>.rds` —
  clustered/annotated query object produced by the earlier steps in this
  pipeline.
`Rscripts/config.R` — configuration file.
`Rscripts/utils.R` — utility functions file.

## Pseudobulk functional analysis (`anal6a_functional_analysis.rmd`)

Loads the Seurat objects produced by the earlier
analysis steps, extracts D42 cells from the EpiC and kolf2 cell lines,
and performs a pseudobulk differential expression and functional enrichment
analysis comparing the normal and tumor conditions.

### Required Input Files

`Data_public/<reference files>` — raw public reference `.rds` Seurat
  objects, one per entry in `ref_info` (defined in `Rscripts/config.R`).
`Results/seu_integrated_clusters_newnames_<ct>_all_nHVG<nHVG_str>.rds` —
  clustered/annotated query object produced by the earlier steps in this
  pipeline.
`Rscripts/config.R` — configuration file.
`Rscripts/utils.R` — utility functions file.

## Cell–cell communication analysis with CellChat (anal7_cellchat.rmd)

Loads the  Seurat object produced by the earlier
analysis steps, subsets it to a selected cell line (kolf2 or EpiC) and
timepoint, and infers potential cell–cell communication networks between
annotated cell clusters using CellChat.

### Inputs

`Results/seu_integrated_clusters_newnames_<ct>_all_nHVG<nHVG_str>.rds` —
  clustered/annotated query object produced by the earlier steps in this
  pipeline.
`Rscripts/config.R` — configuration file.
`Rscripts/utils.R` — utility functions file.