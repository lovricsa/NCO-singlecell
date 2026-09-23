## Setup Python Environment for scVI Integration

This project integrates single-cell datasets using `scvi-tools` (v1.4.1) and `torch` (v2.9.1). To run the integration steps in the R Markdown scripts seamlessly, you must initialize a local Python virtual environment named `scvi-env` inside the project root directory.

### 1. Create the Virtual Environment

Open your terminal or command prompt, navigate to the cloned project root folder, and run the command for your operating system:

* **macOS / Linux:**
```bash
python3 -m venv scvi-env
```

* **Windows:**
```cmd
python -m venv scvi-env

```

### 2. Activate and Install Dependencies

Select the appropriate commands below to activate the environment and install the exact package manifest:

* **macOS / Linux:**
```bash
source scvi-env/bin/activate
pip install --upgrade pip
pip install -r scvi-requirements.txt
```

* **Windows (PowerShell):**
```powershell
.\scvi-env\Scripts\Activate.ps1
pip install --upgrade pip
pip install -r scvi-requirements.txt
```

* **Windows (Command Prompt - cmd):**
```cmd
scvi-env\Scripts\activate.bat
pip install --upgrade pip
pip install -r scvi-requirements.txt
```

Once installed, the R package `reticulate` will automatically detect this local `scvi-env` folder via the pipeline's `here()` paths and run the integration downstream.

### Troubleshooting Platform-Specific Installation Errors
The `scvi-requirements.txt` file is pre-configured with explicit Nvidia CUDA 12 wheels (`nvidia-*-cu12`) for high-performance GPU integration. 

* **If installing on an Apple Silicon Mac (M1/M2/M3) or a CPU-only machine:** `pip` may throw an environment mismatch error trying to locate those Nvidia wheels. If this occurs, simply open `requirements.txt`, delete or comment out the lines starting with `nvidia-` and `triton==`, and re-run the `pip install` command. PyTorch will automatically default to using your local CPU or Apple Silicon MPS graphics framework.


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
  "viridis", "viridisLite"
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

### Output Files
- **Data Objects** (`Data_calculated/`):
  - `seu_qc_tmp.rds`: Intermediate Seurat object saved after multiplet and XXY cell identification.
  - `output_list.rds`: Saved iteration history and doublet statistics from `scDblFinder`.
  - `seu_clean.rds`: Cleaned Seurat object containing only high-quality singlet cells.
  - `seu_final.rds`: Final preprocessed object populated with cell cycle scores (`S.Score`, `G2M.Score`, `Phase`, `ccvar`), module scores, and transgene detection metadata.
- **Diagnostic Plots** (`Figures/QC/`):
  - `nCount_vs_nFeature_*.pdf` & `violinplot_nCount_nFeature_*.pdf`: Pre/post-QC sequencing depth distributions.
  - `Violin_mito_ribo_globin_*.pdf`: Organelle read proportion metrics across samples.
  - `QC_orig_*.pdf`: Per-sample MAD threshold validation histograms.
  - `doublet_score_distribution_*.pdf` & `doublet_check_rate_convergence.pdf`: Multiplet score distributions and iteration saturation plots.
  - `doublet_check_umap_combined.pdf`: Sample UMAP plots showing multiplet spatial distribution.
  - `doublet_xxy_filter.pdf`: Percentage summary bar plot of excluded doublets and XXY cells.
  - `violinplot_sex_socres.pdf` & `violinplot_mito_stress_RNA.pdf`: Biological sex module validation and stress score comparisons.
  - `dotplot_clean_MYCN_EGFP.pdf`: Transgene expression levels across samples.
  - `cell_cycle_phases_arc_combined.pdf` & `cell_cycle_phases.pdf`: Cell cycle PCA arcs and population proportion bar plots.


## Integration & Resolution Testing (`anal2_integration_and_markers.rmd`)

### Description
Integrates cell line backgrounds (EpiC / H1 vs kolf2 / H2) using scVI deep generative models while regressing out cell cycle noise. Converts counts to .h5ad, computes latent embeddings, automatically determines dimensionality via variance elbow detection, tests clustering resolutions from 0.1 to 1.2 (clustree), generates sample-split UMAPs with spatial concave hulls (concaveman/ggforce), calculates module scores for neuroblastoma lineages (sympathoblast, chromaffin, SCP, bridging, MES, proliferation), and exports per-resolution cluster markers into multi-sheet Excel workbooks.

### Required Input Files
Data_calculated/seu_final.rds: Preprocessed Seurat object from Script anal1_quality_control.rmd.

### Output Files (ct is the cell type)
  * Data_calculated/seu_hvg_anndata_converted_{ct}_all_nHVG2000.h5ad: AnnData input files for scVI.
  * Data_calculated/seu_integrated_{ct}_all_nHVG2000.rds: Seurat object populated with scvi embeddings.
  * Data_calculated/seu_integrated_clusters_{ct}_all_nHVG2000.rds: Seurat object containing multi-resolution cluster evaluations.
  * Figures/integration_and_markers/: PCA vs scVI UMAP comparisons, variance elbow plots, resolution trees (clustree), cluster proportion bar plots, spatial hull UMAPs, marker dot plots, and lineage expression maps.
  * Results/Top_Markers_By_Sample_{ct}_all_nHVG2000.xlsx: Excel workbooks containing top marker genes per resolution.


# Single-Cell RNA-Seq Resolution Selection & Marker Analysis (`anal3_selected_resolution.rmd`)

This R Markdown pipeline executes targeted downstream analysis, metadata standardization, differential expression testing, and visualization for integrated scRNA-seq datasets. Toggle between ct <- "EpiC" and ct <- "kolf2" to analyse either of the cell types.

## Pipeline Features

1. **Metadata & Identity Mapping**
   - Applies custom cluster renaming dictionaries based on cell line (`EpiC` / `kolf2`) and experimental timepoints.
   - Calculates cluster abundance, cell counts, and percentage distributions across conditions.

2. **Differential Expression & High-Dimensional Plots**
   - Runs pairwise cluster DE testing with `Seurat::FindMarkers`.
   - Exports top/bottom differentially expressed genes to structured Excel (`.xlsx`) files.
   - Generates customized bubble plots, volcano plots, and expression heatmaps (with or without transgene/EGFP exclusion).

3. **Targeted Gene Set Profiling**
   - Evaluates lineage-specific marker sets: Van-Haver markers, HOX homeobox clusters, structural matrix genes, and MSigDB Hallmark MYC Targets (`V1` / `V2`).
   - Generates unified multi-panel `DotPlot` and fixed-scale `FeaturePlot` grid outputs alongside standalone individual PDFs.

4. **Repository Packaging**
   - Merges cell-line objects (`EpiC` + `kolf2`) into a unified RDS container for GEO repository submission.

### Required Input Files

- **Input Objects**: Pre-processed Seurat RDS files located at `Results/seu_integrated_clusters_<ct>_all_nHVG<nHVG>.rds`.
- **Configuration File**: `config.R` (color vectors, subset definitions, and cell-type thresholds).

### Output Files
* Results/seu_integrated_clusters_newnames_both_cells_all_nHVG2000.rds: Combined RDS Object for GEO Upload.
  Output plots are written to Figures/selected_resolution and Figures/selected_resolution/dimplots; tabular results are saved in Results/.

### Notes and caveats

- The cell line to process is set manually via `ct <- "EpiC"` near the top
  of the mapping chunk; re-run with `ct <- "kolf2"` to process the other
  line.

## Part 4 — Reference Mapping (`anal4_reference_mapping.rmd`)

This step builds a harmonized single-cell reference atlas of neuroblastoma/adrenal
development from multiple public datasets. Such as for the H1 and H2 samples, integration with scVI is tested and
rejected. The organoid dataset is mapped onto the reference atlas to obtain annotations.

### Required Input Files

- `Data_public/<reference files>` — raw public reference `.rds` Seurat
  objects, one per entry in `ref_info` (defined in `Rscripts/config.R`).
- `Results/seu_integrated_clusters_newnames_<ct>_all_nHVG<nHVG_str>.rds` —
  clustered/annotated query object produced by the earlier steps in this
  pipeline.
- `Rscripts/config.R` — configuration file.
- `Rscripts/utils.R` — utility functions file.

### Outputs

- `Data_calculated/NB_reference_atlas.rds` — merged, scVI-integrated
  reference atlas (built once, then reused on subsequent runs).
- `Data_calculated/ref_<name>_harmonized_transformed_downsampled.rds` — one
  per reference dataset, harmonized/downsampled/SCTransformed.
- `Data_calculated/seu_integrated_clusters_newnames_refscores_<ct>_all_nHVG<nHVG_str>.rds`
  — query object annotated with per-reference predicted labels and scores.
- `Figures/reference_mapping/*.pdf` — atlas QC plots, label-transfer
  confidence violin plots, and query UMAPs colored by predicted cell type.

### Notes and caveats

- The cell line to process is set manually via `ct <- "EpiC"` near the top
  of the mapping chunk; re-run with `ct <- "kolf2"` to process the other
  line.
- Cell-type label transfer against the merged atlas uses the atlas's
  standard PCA/UMAP space, not the scVI-corrected embedding; the scVI
  embedding is used for atlas QC/visualization only.


## Part 5: Diffusion map and pseudotime (Slingshot) analysis (`anal5_diffusion_plot.rmd`)

Loads the annotated, integrated Seurat object produced by an earlier
step, subsets it to a specific cell line (`kolf2` or `EpiC`) and
timepoint, computes a diffusion map (`destiny::DiffusionMap`) on the PCA
embedding, and infers pseudotime trajectories with `slingshot` along two
independently defined lineages:

1. **SCP → chromaffin/sympathoblast** lineage
2. **Fibroblast/mesenchymal (MES)** lineage

### Requirements

In addition to the CRAN/Bioconductor packages installed by the
`packages` vector at the top of the script, the following need
non-standard installation and should be listed explicitly:

```r
# GitHub-only packages
remotes::install_github("satijalab/seurat-wrappers")
```

### Inputs

| File | Produced by | Description |
|---|---|---|
| `Results/seu_integrated_clusters_newnames_<ct>_all_nHVG<nHVG_str>.rds` | integration/annotation script | Integrated, cluster-annotated Seurat object |

Requires `config.R` to define: `nHVG_str`, `drop_clusters`, `drop_in_hTH`,
`bio_order_list`, `cluster_names_dict`, and the helper
`subset_seu_by_day()` in `utils.R`.

### Parameters to set before running

| Variable | Values | Effect |
|---|---|---|
| `ct` | `"kolf2"` / `"EpiC"` | which cell line to analyse |
| `day` | `"D26"`, `"D42"`, `"D42_hTH"` | which timepoint to analyse |
| `start_cluster_lookup` | per-chunk | Slingshot root cluster for that lineage |

This script currently runs a **single** `ct`/`day` combination per
render (the loops over cell type and day are commented out — see
Known issues below). To reproduce all combinations reported in the
manuscript, re-render with each combination of `ct` and `day` set
manually, or re-enable the loops.

### Outputs

- `Figures/diffusion_plot/Diffusion_plot_<ct>_day_<day>_nHVG<nHVG_str>.pdf`
- `Figures/diffusion_plot/Diffusion_plot_3D_<ct>_day_<day>.html` (interactive)
- `Figures/diffusion_plot/Diffusion_plot_MES_<ct>_day_<day>_nHVG<nHVG_str>.pdf`
- `Figures/diffusion_plot/Diffusion_plot_MES_3D_<ct>_day_<day>.html`
- `Figures/diffusion_plot/Slingshot_combined_<ct>_day_<day>_nHVG<nHVG_str>.pdf`
- `Figures/diffusion_plot/Slingshot_combined_MES_<ct>_day_<day>_nHVG<nHVG_str>.pdf`