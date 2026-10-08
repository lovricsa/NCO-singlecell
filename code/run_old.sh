#!/usr/bin/env bash
set -ex

# Folder where this script lives (NCO-singlecell/code locally, /code on Code Ocean)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ -d /data ] && [ -d /code ]; then
    # Code Ocean capsule
    ROOT_DIR=/code
    RESULTS_DIR=/results
else
    # Local: project root is one level above the code folder
    ROOT_DIR="$(dirname "$SCRIPT_DIR")"
    RESULTS_DIR="$ROOT_DIR/results"
fi

# ---- run mode ---------------------------------------------------------------
# "published": reproduce manuscript figures from the shipped objects (default)
# "rerun":     regenerate clusters with part 2 (results may differ)
# Usage:  bash run.sh            or   RUN_MODE=rerun bash run.sh
export RUN_MODE="${RUN_MODE:-published}"
case "$RUN_MODE" in
  published|rerun) ;;
  *) echo "RUN_MODE must be 'published' or 'rerun' (got '$RUN_MODE')" >&2; exit 1 ;;
esac
echo "Running in mode: $RUN_MODE"

# HTML reports for the two modes go to separate folders
REPORT_DIR="$RESULTS_DIR/$RUN_MODE"

MAKE_DC_CACHE=1 RUN_MODE=published
for ct in EpiC kolf2; do
    Rscript -e "rmarkdown::render('${SCRIPT_DIR}/Rscripts/anal5_diffusion_plot.rmd', \
        output_dir='${RESULTS_DIR}', \
        output_file='anal5_diffusion_plot_${ct}.html', \
        knit_root_dir='${ROOT_DIR}', \
        params=list(ct='${ct}'), \
        envir=new.env())"
done

mkdir -p "$RESULTS_DIR" "$REPORT_DIR"

# run all scripts sequentially - some depend on the succesful finishing of a previous one
#Rscript -e "rmarkdown::render('${SCRIPT_DIR}/Rscripts/anal0_index_hopping.rmd', output_dir='${RESULTS_DIR}', knit_root_dir='${ROOT_DIR}')"
#Rscript -e "rmarkdown::render('${SCRIPT_DIR}/Rscripts/anal1_quality_control.rmd', output_dir='${RESULTS_DIR}', knit_root_dir='${ROOT_DIR}')"
#Rscript -e "rmarkdown::render('${SCRIPT_DIR}/Rscripts/anal2_integration_and_markers.rmd', output_dir='${RESULTS_DIR}', knit_root_dir='${ROOT_DIR}')"
#Rscript -e "rmarkdown::render('${SCRIPT_DIR}/Rscripts/anal3a_save_selected_resolution.rmd', output_dir='${RESULTS_DIR}', knit_root_dir='${ROOT_DIR}')" 
Rscript -e "rmarkdown::render('${SCRIPT_DIR}/Rscripts/anal3a_save_selected_resolution.rmd', output_dir='${REPORT_DIR}', knit_root_dir='${ROOT_DIR}')"


#for ct in EpiC kolf2; do
#    Rscript -e "rmarkdown::render('${SCRIPT_DIR}/Rscripts/anal3b_plot_selected_resolution.rmd', \
#        output_dir='${RESULTS_DIR}', \
#        output_file='anal3b_plot_selected_resolution_${ct}.html', \
#        knit_root_dir='${ROOT_DIR}', \
#        params=list(ct='${ct}'), \
#        envir=new.env())"
#done

#for ct in EpiC kolf2; do
# for ct in EpiC kolf2; do
#    Rscript -e "rmarkdown::render('${SCRIPT_DIR}/Rscripts/anal4_reference_mapping.rmd', \
#        output_dir='${RESULTS_DIR}', \
#        output_file='anal4_reference_mapping_${ct}.html', \
#        knit_root_dir='${ROOT_DIR}', \
#        params=list(ct='${ct}'), \
#        envir=new.env())"
#done

MAKE_DC_CACHE=1 RUN_MODE=published
for ct in EpiC kolf2; do
    Rscript -e "rmarkdown::render('${SCRIPT_DIR}/Rscripts/anal5_diffusion_plot.rmd', \
        output_dir='${RESULTS_DIR}', \
        output_file='anal5_diffusion_plot_${ct}.html', \
        knit_root_dir='${ROOT_DIR}', \
        params=list(ct='${ct}'), \
        envir=new.env())"
done


#Rscript -e "rmarkdown::render('${SCRIPT_DIR}/Rscripts/anal6a_functional_analysis_pseudo_bulk_samples.rmd', output_dir='${RESULTS_DIR}', knit_root_dir='${ROOT_DIR}')"
Rscript -e "rmarkdown::render('${SCRIPT_DIR}/Rscripts/anal6b_functional_analysis_pseudo_bulk_SCP_EGFP_tumor.rmd', output_dir='${RESULTS_DIR}', knit_root_dir='${ROOT_DIR}')"

for ct in EpiC kolf2; do
    Rscript -e "rmarkdown::render('${SCRIPT_DIR}/Rscripts/anal7_cell_chat.rmd', \
        output_dir='${RESULTS_DIR}', \
        output_file='anal7_cell_chat_${ct}.html', \
        knit_root_dir='${ROOT_DIR}', \
        params=list(ct='${ct}'), \
        envir=new.env())"
done

Rscript -e "rmarkdown::render('${SCRIPT_DIR}/Rscripts/anal7b_cell_chat_public.rmd', output_dir='${RESULTS_DIR}', knit_root_dir='${ROOT_DIR}')"



