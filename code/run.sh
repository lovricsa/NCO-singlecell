#!/usr/bin/env bash
set -euo pipefail
if [ "${DEBUG:-0}" = "1" ]; then set -x; fi

# ---- locations --------------------------------------------------------------
# Folder where this script lives (NCO-singlecell/code locally, /code on Code Ocean)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ -d /data ] && [ -d /code ]; then
    # Code Ocean capsule
    ROOT_DIR=/code
    RESULTS_DIR=/results
    PUBLISHED_DIR=/data/Published_objects
else
    # Local: project root is one level above the code folder
    ROOT_DIR="$(dirname "$SCRIPT_DIR")"
    RESULTS_DIR="$ROOT_DIR/results"
    PUBLISHED_DIR="$ROOT_DIR/data/Published_objects"
fi

# ---- run mode ---------------------------------------------------------------
# published: reproduce the manuscript figures from the shipped objects (default)
# rerun:     recompute everything (results may differ), written to results/rerun/
# Usage:  bash run.sh
#         RUN_MODE=rerun bash run.sh
#         STEPS="5 7" bash run.sh          (only some steps)
#         DEBUG=1 bash run.sh              (print every command)
export RUN_MODE="${RUN_MODE:-published}"
case "$RUN_MODE" in
  published|rerun) ;;
  *) echo "RUN_MODE must be 'published' or 'rerun' (got '$RUN_MODE')" >&2; exit 1 ;;
esac

# Same layout as out_root in config.R: published -> results/, rerun -> results/rerun/
if [ "$RUN_MODE" = "published" ]; then
    REPORT_DIR="$RESULTS_DIR"
else
    REPORT_DIR="$RESULTS_DIR/rerun"
fi
mkdir -p "$REPORT_DIR"

# Steps to run, in order. Add 0 (index hopping) if you need it.
STEPS="${STEPS:-1 2 3a 3b 4 5 6a 6b 7 7b}"

# Log everything to a file as well
LOG="$REPORT_DIR/run_$(date +%Y%m%d_%H%M%S).log"
exec > >(tee -a "$LOG") 2>&1
echo "Mode: $RUN_MODE | steps: $STEPS | reports: $REPORT_DIR"

# ---- check shipped objects (published mode) ---------------------------------
# md5sums.txt is created once with:  cd Published_objects && md5sum *.rds > md5sums.txt
if [ "$RUN_MODE" = "published" ]; then
    if [ -f "$PUBLISHED_DIR/md5sums.txt" ]; then
        (cd "$PUBLISHED_DIR" && md5sum -c --quiet md5sums.txt) \
            || { echo "Published objects do not match md5sums.txt" >&2; exit 1; }
        echo "Published objects verified."
    else
        echo "WARNING: $PUBLISHED_DIR/md5sums.txt not found, skipping the integrity check" >&2
    fi
fi

# ---- helpers ----------------------------------------------------------------
want() { [[ " $STEPS " == *" $1 "* ]]; }

# render <rmd name without extension> [cell line]
render() {
    local rmd="$1" ct="${2:-}" out="$1"
    local args=()
    if [ -n "$ct" ]; then out="${rmd}_${ct}"; args+=("$ct"); fi
    echo "=== $(date +%T) rendering $rmd ${ct:+($ct)} ==="
    Rscript -e '
        a <- commandArgs(trailingOnly = TRUE)
        p <- if (length(a) >= 5) list(ct = a[5]) else NULL
        rmarkdown::render(a[1], output_file = a[2], output_dir = a[3],
                          knit_root_dir = a[4], params = p, envir = new.env())
    ' "$SCRIPT_DIR/Rscripts/${rmd}.rmd" "${out}.html" "$REPORT_DIR" "$ROOT_DIR" "${args[@]}"
}

# step <id> <rmd> [per_cell_line]
step() {
    local id="$1" rmd="$2" per_ct="${3:-}"
    want "$id" || return 0
    if [ -n "$per_ct" ]; then
        for ct in EpiC kolf2; do render "$rmd" "$ct"; done
    else
        render "$rmd"
    fi
}

# ---- pipeline (sequential: later steps depend on earlier ones) --------------
#step 0  anal0_index_hopping
#step 1  anal1_quality_control
#step 2  anal2_integration_and_markers
#step 3a anal3a_save_selected_resolution
#step 3b anal3b_plot_selected_resolution                        per_ct
#step 4  anal4_reference_mapping                                per_ct
#step 5  anal5_diffusion_plot                                   per_ct
#step 6a anal6a_functional_analysis_pseudo_bulk_samples
#step 6b anal6b_functional_analysis_pseudo_bulk_SCP_EGFP_tumor
step 7  anal7_cell_chat                                        per_ct
step 7b anal7b_cell_chat_public

# ---- record the environment -------------------------------------------------
Rscript -e 'writeLines(capture.output(sessionInfo()), commandArgs(TRUE)[1])' \
    "$REPORT_DIR/sessionInfo_${RUN_MODE}.txt"
echo "Done. Log: $LOG"
