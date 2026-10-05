# Single-cell analysis of neuroblastoma organoids

## Repository contents and data

This GitHub repository contains the **code only**:

* `run.sh`: runs the whole pipeline (see "Running the pipeline" below)
* `postInstall.sh`: installs the system libraries and R packages (used by Code Ocean to build the environment; it can also be run locally on Ubuntu 24.04)
* `Rscripts/`: the R Markdown scripts `anal*.rmd`, `config.R`, `utils.R`.

The data are **not** stored on GitHub. All inputs are public and are provided in the Code Ocean capsule (<capsule link/DOI>):

* the count matrices: GEO GSE335864
* the public reference datasets in `Data_public/` (sources listed in `ref_info` in `Rscripts/config.R`)
* the shipped objects in `Published_objects/`, which reproduce the manuscript figures (see "Shipped objects" below)

To run the code outside Code Ocean, place the data next to the code folder as follows. `run.sh` and the scripts detect this layout automatically, and `results/` is created on the first run:

```text
NCO-singlecell/
├── code/                      <- this repository
│   ├── run.sh
│   ├── postInstall.sh
│   └── Rscripts/
├── data/
│   ├── Data_organoid/count_matrix/    (GEO GSE335864)
│   ├── Data_public/                   (only needed for RUN_MODE=rerun)
│   └── Published_objects/             (needed for the default published mode)
└── results/                           (created by the pipeline)
```

On Code Ocean the same folders are `/code`, `/data` and `/results`.

## Requirements & Dependencies

This project was developed under the following environment:
* **R Version:** 4.5.2
* **OS:** Ubuntu 24.04.4 LTS (x86_64-pc-linux-gnu)
* **bash:** version 4 or newer (Ubuntu 24.04 ships 5.2). **Mac users:** the macOS default bash (3.2) is too old for `run.sh`. Install a newer one (for example `brew install bash`) and run `/opt/homebrew/bin/bash run.sh` (path may differ on Intel Macs), or run the pipeline in Code Ocean or on Linux.

## Setup R packages

On Code Ocean, `postInstall.sh` installs all system libraries (including `pandoc`, which is needed to render the HTML reports) and R packages. For local use, run the following R snippet to automatically check for and install any missing packages (handles CRAN and Bioconductor dependencies):

```r
# List of required packages
required_packages <- c(
  "AnnotationDbi", "clusterProfiler", "clustree", "ComplexHeatmap",
  "concaveman", "destiny", "dplyr", "edgeR", "EnhancedVolcano",
  "enrichplot", "future", "ggforce", "ggplot2", "glmGamPoi", "gridExtra",
  "here", "htmlwidgets", "knitr", "limma", "Matrix", "msigdbr", "openxlsx",
  "org.Hs.eg.db", "patchwork", "pathview", "plotly", "purrr", "RColorBrewer",
  "rmarkdown", "scCustomize", "scDblFinder", "Seurat", "SeuratObject",
  "SingleCellExperiment", "slingshot", "stringr", "tibble", "tidyr", "viridis"
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

> **Note on GitHub-only packages:** `CellChat` is not on CRAN or Bioconductor, and `presto` (optional, speeds up marker detection) is also installed from GitHub. Install `remotes` via `install.packages("remotes")` and then run `remotes::install_github("jinworks/CellChat")` and `remotes::install_github("immunogenomics/presto")`. `postInstall.sh` contains the complete list of system libraries and R packages. For exact reproducibility, set `CRAN_REPO` in `postInstall.sh` to a dated Posit Package Manager snapshot and pin the GitHub packages to a commit.

---

<details>
<summary><b>Click to view full R sessionInfo() of the original run</b></summary>

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

Each run of `run.sh` also writes its own `sessionInfo_<mode>.txt` into the report folder.

# Running the pipeline

All scripts are run in order by `run.sh` (from the `code` folder, or as the Code Ocean entry point). Each script is rendered to an HTML report; scripts 3b, 4, 5 and 7 are rendered once per cell line (`EpiC` = H1, `kolf2` = H2), so the cell line does not need to be edited by hand. Each run writes a log and `sessionInfo_<mode>.txt` into the report folder.

```bash
bash run.sh                    # published mode (default)
RUN_MODE=rerun bash run.sh     # full re-run
STEPS="5 7" bash run.sh        # only selected steps
DEBUG=1 bash run.sh            # print every command
```

Step names: `0 1 2 3a 3b 4 5 6a 6b 7 7b`. 

## Run modes

Several steps are stochastic (doublet detection, SCTransform/PCA/UMAP, clustering, reference mapping, diffusion maps, GSEA) and depend on package versions. Cluster numbers and cell labels can therefore change when the pipeline is re-run.

* **`published` (default):** reproduces the manuscript figures. The stochastic steps are not recomputed. The shipped objects in `data/Published_objects/` are used instead (see below), and `run.sh` checks them against `md5sums.txt`. Outputs go to `results/`. This mode needs the `Published_objects/` folder from the Code Ocean capsule; it is not part of this repository.
* **`rerun`:** recomputes everything from `data/Data_organoid` and `data/Data_public`. Outputs go to `results/rerun/`, so published results are never overwritten. The numbers may differ from the manuscript, and the cluster-label dictionaries in `config.R` (`new.cluster.ids.list`, `bio_order_list`, `cluster_names_dict`) must be re-checked against the new clustering.

Before the first run, back up any older `results/` folder: published mode writes files with the same names.

## Objects available on Code Ocean only (`data/Published_objects/`)

* `seu_qc_tmp.rds`, `output_list.rds`, `seu_final.rds`: doublet detection results and the final QC object (anal1).
* `seu_integrated_clusters_{EpiC,kolf2}_all_nHVG2000.rds`: clustering and UMAP (anal2).
* `expected_cell_counts_{EpiC,kolf2}.csv`: reference cell numbers per sample and cluster, checked in anal3a and anal3b.
* `seu_integrated_clusters_newnames_refscores_{EpiC,kolf2}_all_nHVG2000.rds`: per-reference label transfer results (anal4).
* `diffusion_DC_{main,MES}_{EpiC,kolf2}.rds`: diffusion map coordinates (anal5).
* `ref_{Jansky,GOSH,PMC}_harmonized_transformed_down2000.rds`: downsampled public references (anal7b).
* `md5sums.txt`: checksums of the `.rds` and `.csv` files above.


### Checksums

`md5sums.txt` is created once, after all shipped files are in place, and must be recreated whenever one of them changes. Run in the `Published_objects` folder (Linux):

```bash
cd data/Published_objects
md5sum *.rds *.csv > md5sums.txt
```

To verify (`run.sh` does this automatically in published mode):

```bash
cd data/Published_objects
md5sum -c md5sums.txt
```

# Scripts details

## Demultiplexing and Index Hopping Analysis (`anal0_index_hopping.rmd`)

### Description
Analyzes single-cell RNA-seq demultiplexing statistics, undetermined read rates, top unassigned barcode combinations (e.g., polyG artifacts), and sample-to-sample index hopping directionality/burden from Illumina flowcell sequencing outputs. 

### Required Input Files
- `data/Data_organoid/BS_stats_anonymous.xlsx`: Excel file containing three required sheets:
  - `Demultiplex_Stats`: Per-sample read counts and index mismatch percentages.
  - `Top_Unknown_Barcodes`: Frequent unassigned index sequences.
  - `Index_Hopping_Counts`: Sample index definitions and observed hopped read counts.

### Output Files
- Compiled R Markdown report (`.html`) containing:
  - Flowcell sequencing yield and undetermined read statistics table.
  - Per-sample demultiplexing performance table and read balance bar plot.
  - Top 20 undetermined index combinations table.
  - Per-sample index hopping burden table and donor-recipient heatmap.

## Single-Cell Neuroblastoma Organoids: Quality Control & Preprocessing (`anal1_quality_control.rmd`)

### Description
Performs comprehensive single-cell RNA-seq quality control on neuroblastoma organoids. The pipeline loads CS genetics' raw feature-barcode matrices, calculates cell quality metrics (mitochondrial, ribosomal, and hemoglobin read percentages), applies sample-specific adaptive thresholding using Median Absolute Deviation (MAD), runs an iterative `scDblFinder` convergence algorithm to flag multiplets, filters out male/female doublet artifacts (XXY cells), scores cell stress and sex-linked markers, quantifies transgene expression (`MYCN` and `EGFP`), and performs sample-level cell cycle phase classification.

In `published` mode the deterministic QC filtering is recomputed and checked against the shipped doublet object, and the cell-cycle scores are taken from the shipped `seu_final.rds`.

### Required Input Files
GEO GSE335864: count matrix output triplets for all 8 samples obtained by running the CS genetics' pipeline on the raw fastq files are available from the custom GSE335864_RAW.tar archive
  - `*_matrix.mtx.gz`
  - `*_barcodes.tsv.gz`
  - `*_features.tsv.gz`

After download, these files should be saved into the folder `data/Data_organoid/count_matrix/`.
In `published` mode additionally: `data/Published_objects/seu_qc_tmp.rds`, `output_list.rds`, `seu_final.rds`.

## Integration & Resolution Testing (`anal2_integration_and_markers.rmd`)

### Description
Integrates cell line backgrounds (EpiC / H1 vs kolf2 / H2), generates sample-split UMAPs with spatial concave hulls (concaveman/ggforce), calculates module scores for neuroblastoma lineages (sympathoblast, chromaffin, SCP, bridging, MES, proliferation), and exports per-resolution cluster markers into multi-sheet Excel workbooks. In `published` mode the shipped clustering is loaded and only the plots and marker tables are regenerated from it.

### Required Input Files
`results/Data_calculated/seu_final.rds`: Preprocessed Seurat object from `anal1_quality_control.rmd` (`rerun` mode, or `data/Published_objects/seu_final.rds`).
In `published` mode: `data/Published_objects/seu_integrated_clusters_<ct>_all_nHVG2000.rds`.

## Selected Resolution: Cluster Naming (`anal3a_save_selected_resolution.rmd`)

Applies the selected resolution (`selres_list` in `config.R`), renames the clusters (`new.cluster.ids.list`) and removes stray sample/cluster groups with fewer than 10 cells. Writes `results/Results/seu_integrated_clusters_newnames_<ct>_all_nHVG2000.rds` for both cell lines, which all later steps use. In `published` mode the cell numbers are checked against `expected_cell_counts_<ct>.csv`.

### Required Input Files
`seu_integrated_clusters_<ct>_all_nHVG2000.rds` (from `data/Published_objects/` or the re-run), `expected_cell_counts_<ct>.csv` (published mode).
`Rscripts/config.R` — configuration file (the label dictionaries must match the clustering used).
`Rscripts/utils.R` — utility functions file.

## Resolution Selection Plots & Marker Analysis (`anal3b_plot_selected_resolution.rmd`)

Draws the figures for the selected resolution of one cell line (UMAPs with hulls per sample group, cluster proportions, QC and cell-cycle violins, marker dotplots, HOX/structure/CD44 gene sets). Contains no random steps. Run once per cell line (`params: ct`).

### Required Input Files
`results/Results/seu_integrated_clusters_newnames_<ct>_all_nHVG2000.rds` — produced by `anal3a`.
`Rscripts/config.R`, `Rscripts/utils.R`.

## Reference Mapping (`anal4_reference_mapping.rmd`)

This step builds a harmonized single-cell reference atlas of neuroblastoma/adrenal development from multiple public datasets. The organoid dataset is mapped onto the reference atlas and onto the individual references to obtain annotations. Run once per cell line (`params: ct`).

In `published` mode the atlas is not rebuilt: the shipped per-reference predictions are used and only the per-reference and per-day figures are produced. The atlas-based figures (`Atlas`, `Label_transfer_confidence_*`, `Query_*`) come from the original run and are provided as PDFs.

### Required Input Files
`data/Data_public/<reference files>` (`rerun` mode only) — raw public reference `.rds` Seurat objects, one per entry in `ref_info` (defined in `Rscripts/config.R`).
`results/rerun/Results/seu_integrated_clusters_newnames_<ct>_all_nHVG2000.rds` (`rerun` mode).
`data/Published_objects/seu_integrated_clusters_newnames_refscores_<ct>_all_nHVG2000.rds` (`published` mode).
`Rscripts/config.R`, `Rscripts/utils.R`.

## Diffusion map and pseudotime (Slingshot) analysis (`anal5_diffusion_plot.rmd`)

Loads the annotated, integrated Seurat object produced by an earlier
step, subsets it to a specific cell line (`kolf2` or `EpiC`) and
timepoint, computes a diffusion map on the PCA
embedding, and infers pseudotime trajectories with `slingshot` along the lineage:

1. **SCP → chromaffin/sympathoblast** lineage

The diffusion map eigenvectors can be mirrored between runs, so in `published` mode the shipped coordinates are used; `slingshot` and the plots are recomputed from them. Run once per cell line (`params: ct`).

### Inputs

`results/Results/seu_integrated_clusters_newnames_<ct>_all_nHVG2000.rds` — produced by `anal3a`.
`data/Published_objects/diffusion_DC_{main,MES}_<ct>.rds` (`published` mode).
`Rscripts/config.R`, `Rscripts/utils.R`.

## Pseudobulk functional analysis (`anal6a_functional_analysis_pseudo_bulk_samples.rmd`)

Loads the Seurat objects produced by the earlier
analysis steps, sums the counts of the D42 samples of the EpiC and kolf2 cell lines,
and performs a whole-sample pseudobulk differential expression (limma-voom) and GSEA
comparing the normal and tumor (hTH-Cre) conditions. With four samples the model has one
residual degree of freedom, so the results are exploratory. GSEA is permutation-based and
adjusted p-values can vary slightly between runs.

### Required Input Files

`results/Results/seu_integrated_clusters_newnames_<ct>_all_nHVG2000.rds` — produced by `anal3a`.
`Rscripts/config.R`, `Rscripts/utils.R`.

## Pseudobulk functional analysis of selected populations (`anal6b_functional_analysis_pseudo_bulk_SCP_EGFP_tumor.rmd`)

Builds pseudobulk samples per cell population (late SCP, late endoneural fibroblast, EGFP ADRN-like, EGFP MES-like; with and without virus) and cell line at D42 (12 samples), runs limma-voom with the design `~ 0 + condition + cell_line`, and performs PCA, volcano plots, heatmaps and GSEA for five contrasts. In `published` mode the published filtering is used and the library sizes are checked against the published run.

### Required Input Files

`results/Results/seu_integrated_clusters_newnames_<ct>_all_nHVG2000.rds` — produced by `anal3a`.
`Rscripts/config.R`, `Rscripts/utils.R`.

## Cell–cell communication analysis with CellChat (`anal7_cell_chat.rmd`)

Loads the Seurat object produced by the earlier
analysis steps, subsets it to a selected cell line (kolf2 or EpiC) and
timepoint (D42 hTH-Cre), and infers potential cell–cell communication networks between
annotated cell clusters using CellChat. Run once per cell line (`params: ct`).

### Inputs

`results/Results/seu_integrated_clusters_newnames_<ct>_all_nHVG2000.rds` — produced by `anal3a`.
`Rscripts/config.R`, `Rscripts/utils.R`.

## Cell–cell communication in public datasets (`anal7b_cell_chat_public.rmd`)

Runs the same CellChat analysis on the public neuroblastoma datasets (Jansky, GOSH, PMC) for comparison, and shows FGF/EGF ligand and receptor expression in them.

### Inputs

`data/Published_objects/ref_<name>_harmonized_transformed_down2000.rds` (`published` mode), or the raw files in `data/Data_public/` (`rerun` mode, random downsampling to 2000 cells per label).
`Rscripts/config.R`, `Rscripts/utils.R`.