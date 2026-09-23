
test_markers <- c("ASCL1", "CHGA", "HAND2", "TH")

marker_list <- list(
  proliferation = c("CDK1", "CENPF", "TOP2A", "UBE2C"), #vanHaver
  #sympathoblast = c("CDK1", "PRPH", "ELAVL4", "ELAVL3", "ELAVL2", "ISL1", "STMN2", "GAP43", "GATA3", "PHOX2B", "SOX11", "TFAP2B",  "HMX1"), # Saldana?
  sympathoblast = c("PRPH", "ELAVL2", "ELAVL3", "ELAVL4", "ISL1","STMN2", "STMN4", "GAP43", "GATA3", "PHOX2B", "SOX11", "SOX11", "TFAP2B"), #vanHaver
  chromaffin = c("ADM", "CARTPT", "CHGA", "CHGB", "DBH", "DDC", "DLK1", "EGR1", "FOS", "JUNB", "PENK", "PNMT", "TH"), #vanHaver
  #bridging = c("ASCL1", "MEIS1"), #vanHaver
  bridging  = c("ASCL1", "MEIS1", "PHOX2B", "PENK", "TH", "CHGA", "HAND2"),
  SCP = c("CDH19", "EDNRB", "ERBB3", "ERBB4", "FTS1", "FOXD3", "MPZ", "NR2F2", "PLP1", "SOX10", "SOX2", "SPARC"), #vanHaver
  #SCP_other = c("SOX10", "PLP1", "FOXD3", "FABP7", "S100B", "ERBB3", "NGFR", "MPZ", "COL2A1", "POSTN", "MOXD1", "GAS7", "ASCL1"), #Saldana?
  MES = c("COL1A1", "COL1A2", "COL12A1", "COL3A1", "VIM", "CXCL12", "TWIST1", "TWIST2") #Saldana fig2
)

vanHaver_list <- list(
  immune = c(    "FCGR1A", "CD163" ),
  liver = c(    "HNF4A",    "AHSG"  ),
  erythroid = c(    "HBA2",    "HBB"  ),
  adrenal_gland = c(    "NR5A1",    "STAR"  ),
  CPC = c(    "PENK",    "CHGA",    "STMN2"  ),
  sympathoblasts = c(    "STMN2"),
  prolif_sym = c(    "STMN2",    "TOP2A"  ),
  bridging = c(    "ASCL1"  ),
  SCP = c(    "PLP1",    "SOX10"  ),
  #subepicardial_abdominal_mesenchyme = c(    "PRRX1"  ),
  sa_mes = c(    "PRRX1"  ),
  endothelial = c(    "PECAM1",     "KDR"   ),
  melanocyte_stem = c(    "MITF",    "PMEL"  ),
  #endoneurial_fibroblasts = c(    "DCN",    "FBN1"  ),
  endoneurial_fibroblasts = c(    "DCN",    "FBN1"  ),
  myofibroblasts = c(    "ACTA2",    "TAGLN"  )
)

hox_list <- list(
  "Cervical" = c("HOXA1", "HOXB1", "HOXA3", "HOXB3", "HOXD3"),
  "Truncal" = c("HOXA5", "HOXB5", "HOXA6", "HOXA7", "HOXB7", "HOXB8", "HOXC8", "HOXD8", "HOXB9"),
  "Lumbar-caudal" = c("HOXC9", "HOXD9", "HOXD11")
)

structure_list <- list(
  "Basement Membrane" = c("LAMA2", "LAMB1", "LAMC3", "COL4A6", "COL12A1", "NID2"),
  "ECM Assembly"      = c("COL1A1", "COL3A1", "COL6A3", "COL8A1", "BGN", "LUM", "POSTN", "FMOD", "DCN"),
  "Cell Adhesion"     = c("CDH19", "CDH11", "CDH20", "MPZ", "CNTN2", "CNTNAP5", "CLDN5"),
  "Tissue Patterning" = c("WNT1", "WNT7B", "WNT10B", "RSPO3", "DKK1", "DKK2", "SLITRK6", "ROBO3"),
  "Axon/Structure"    = c("NRG1", "ERBB3", "LGI4", "RELN", "POU4F1", "UNCX")
)

CD44_dimplots <- list(
  "NB ADRN-like" = c("DLK1", "DBH", "PHOX2A", "PHOX2B", "HAND2", "HAND1", "KLF7", "ISL1", "ASCL1", "TH", "GAP43"),
  "NB MES-like" = c("CD44", "FN1", "VIM", "SNAI2", "PRRX1", "YAP1", "WWTR1", "CD133")
  #"GD2 synthesis" = c("B4GALT6", "ST3GAL5", "ST8SIA1", "B4GALNT1", "B3GALT4", "ST3GAL2"),
  #"CAF" = c("COL1A1", "COL3A1", "COL6A3", "DCN", "LAMB1", "LAMC3", "LUM", "ACTA2", "PDGFRB", "TAGLN", "MYL9", "COL1A2")
)

CD44_dimplots_MES <- list(
  "NB ADRN-like" = c("DLK1", "DBH", "PHOX2A", "PHOX2B", "HAND2", "HAND1", "KLF7", "ISL1", "ASCL1"),
  "NB MES-like" = c("CD44", "FN1", "VIM", "SNAI2", "PRRX1", "YAP1", "WWTR1", "CD133")
)


# for the final manuscript:
dimplot_list <- list(
  "Cell Fate" = c("TH", "HOX2B", "GAP43", "STMN2", "ISL1", "CDKN1C", "CCND1"),
  "Neuromesodermal progenitor" = c("TBXT", "SOX2"), # TBXT: Brachyury
  "Proliferation" = c("PRPH", "SYN3", "GAP43", "NTRK1", "SOX4", "ALK", "MEIS2", "ERBB4", "VGF"),
  "GFP" = c("EGFP", "MYCN"),
  "Maturation Sympathoblasts" = c("CHRNA3", "VMAT1"), # VMAT1 missing
  "Enteric Neurons" = c("EDNRB", "RET"),
  "Sensory Neurons" = c("NGN1", "NGN2"), # missing?
  "Endoneurial Fibroblasts" = c("DCN", "FBN1"),
  "Myofibroblasts" = c("ACTA2", "TAGLN"),
  "Melanocyte stem cell" = c("PMEL", "MITF"),
  "SCP" = c("FOXD3", "SOX2", "SOX10", "MPZ", "S100B", "PLP1", "ERBB3"),
  "Briding" = c("ASCL1", "PHOX2B", "PENK", "TH", "CHGA", "HAND2"),
  "sympathoblast" = c("GATA3", "ELAVL2", "ELAVL4", "ISL1", "STMN2", "STMN4", "PRPH")
)

violinplot_array <- c("AZIN1", "TFAP2B", "PRPH", "SYN3", "NTRK1", 
                      "SOX4", "ALK", "MEIS2", "ERBB4", "VGF", "ACTB", "EGFP")

# based on testing each selres differently, these selres are used for further analysis
selres_list <- list(
  "EpiC" = "SCT_snn_res.0.3",
  "kolf2" = "SCT_snn_res.0.5" # changed to 0.5!!!
)

sample_names_dict <- c(
  "1_EpiC_MIX_D26" = "H1 WT D26",
  "2_EpiC_STOP_MYCN_D26" = "H1 STOP-MYCN D26",
  "3_EpiC_STOP_MYCN_D42" = "H1 STOP-MYCN no virus D42",
  "4_EpiC_STOP_MYCN_D42_hTH" = "H1 STOP-MYCN hTH-Cre D42",
  "5_kolf2_MIX_D26" = "H2 WT D26",
  "6_kolf2_STOP_MYCN_D26" = "H2 STOP-MYCN D26",
  "7_kolf2_STOP_MYCN_D42" = "H2 STOP-MYCN no virus D42",
  "8_kolf2_STOP_MYCN_D42_hTH" = "H2 STOP-MYCN hTH-Cre D42"
)

# MES - off target
new.cluster.ids.list <- list(
  "EpiC" =      c(
    "0" = "type_early/late_SCP", 
    "1" =  "type_chr_sym", 
    "2" =  "type_early_prog", 
    "3" =   "type_early/late_endoneural_fibroblasts", 
    "4" = "type_sympathoblast",  
    "5" = "type_early/late_myofibroblast", 
    "6" = "type_EGFP_MES",
    "7" =  "type_bridging",   
    "8" = "type_EGFP_tumor"
  ),
  "kolf2" =      c(
    "6" = "type_chromaffin", # try "type_chromaffin/type_chr_sym"? because cells from 1 go there; keep 10 cells as well
    "1" = "type_sympathoblast", 
    "7" = "type_bridging", 
    "0" = "type_early_SCP", #
    "3" = "type_late_SCP", #
    "8" = "type_early_endoneural_fibroblasts", #
    "9"=  "type_early_SYM_like", 
    "2" = "type_late_endoneural_fibroblasts", #
    "4" = "type_EGFP_tumor", #
    "5" = "type_chr_sym/type_sympathoblast", #
    "10" = "type_early_prog", #
    "11" = "type_EGFP_MES", #
    "12" = "type_12"
  )
)

cluster_names_dict <- list(
  "EpiC" =  list(
    "D26"=  c(
      "type_early/late_SCP" = "early SCP", 
      "type_chr_sym"= "chromaffin/sympathoblast", 
      "type_early_prog"="early progenitor", 
      "type_early/late_endoneural_fibroblasts"="early endoneural fibroblast", # previously "type_MES", 
      "type_sympathoblast"= "sympathoblast",  # previously "type_maturing_neurons", # previously type_bridge
      "type_early/late_myofibroblast"="early myofibroblast",  # previously"type_MES_like",  # previously type_early_MES
      "type_EGFP_MES"="EGFP MES-like",
      "type_bridging"="bridging",   
      "type_EGFP_tumor"="EGFP ADRN-like"
    ),
    "D42"=  c(
      "type_early/late_SCP" = "late SCP", 
      "type_chr_sym"= "chromaffin/sympathoblast", 
      "type_early_prog"="late progenitor", 
      "type_early/late_endoneural_fibroblasts"="late endoneural fibroblast", # previously "type_MES", 
      "type_sympathoblast"= "sympathoblast",  # previously "type_maturing_neurons", # previously type_bridge
      "type_early/late_myofibroblast"="late myofibroblast",  # previously"type_MES_like",  # previously type_early_MES
      "type_EGFP_MES"="EGFP MES-like",
      "type_bridging"="bridging",  
      "type_EGFP_tumor"="EGFP ADRN-like"
    ),
    "all"=  c(
      "type_early/late_SCP" = "early/late SCP", 
      "type_chr_sym"= "chromaffin/sympathoblast", 
      "type_early_prog"="early/late progenitor", 
      "type_early/late_endoneural_fibroblasts"="early/late endoneural fibroblast", # previously "type_MES", 
      "type_sympathoblast"= "sympathoblast",  # previously "type_maturing_neurons", # previously type_bridge
      "type_early/late_myofibroblast"="early/late myofibroblast",  # previously"type_MES_like",  # previously type_early_MES
      "type_EGFP_MES"="EGFP MES-like",
      "type_bridging"="bridging",  
      "type_EGFP_tumor"="EGFP ADRN-like"
    )
  ),
  "kolf2" = list(
    "D26"=  c(
      "type_chromaffin"= "chromaffin", 
      "type_sympathoblast" = "sympathoblast",
      "type_early_SCP" = "early SCP",
      "type_late_SCP" = "late SCP",
      "type_early_endoneural_fibroblasts"="early endoneural fibroblast", # previously "type_MES", 
      "type_early_SYM_like"= "early sympathoblast-like",  # previously "type_maturing_neurons", # previously type_bridge
      "type_late_endoneural_fibroblasts"="late endoneural fibroblast", # previously "type_MES", 
      "type_EGFP_tumor"="EGFP ADRN-like",
      "type_bridging"="bridging",   
      "type_early_prog"="early progenitor",
      "type_EGFP_MES"="EGFP MES-like",
      "type_12" = "cluster 12",
      "type_chr_sym/type_sympathoblast" = "chromaffin/sympathoblast"
    ),
    "D42"=  c(
      "type_chromaffin"= "chromaffin", 
      "type_sympathoblast" = "sympathoblast",
      "type_early_SCP" = "early SCP",
      "type_late_SCP" = "late SCP",
      "type_early_endoneural_fibroblasts"="early endoneural fibroblast", # previously "type_MES", 
      "type_early_SYM_like"= "early sympathoblast-like",  # previously "type_maturing_neurons", # previously type_bridge
      "type_late_endoneural_fibroblasts"="late endoneural fibroblast", # previously "type_MES", 
      "type_EGFP_tumor"="EGFP ADRN-like",
      "type_bridging"="bridging",   # previously "type_mature_SYM",
      "type_early_prog"="early progenitor",
      "type_EGFP_MES"="EGFP MES-like",
      "type_12" = "cluster 12",
      "type_chr_sym/type_sympathoblast" = "sympathoblast"
    ),
    "all"=  c(
      "type_chromaffin"= "chromaffin", 
      "type_sympathoblast" = "sympathoblast",
      "type_early_SCP" = "early SCP",
      "type_late_SCP" = "late SCP",
      "type_early_endoneural_fibroblasts"="early endoneural fibroblast", # previously "type_MES", 
      "type_early_SYM_like"= "early sympathoblast-like",  # previously "type_maturing_neurons", # previously type_bridge
      "type_late_endoneural_fibroblasts"="late endoneural fibroblast", # previously "type_MES", 
      "type_EGFP_tumor"="EGFP ADRN-like",
      "type_bridging"="bridging",   # previously "type_mature_SYM",
      "type_early_prog"="early progenitor",
      "type_EGFP_MES"="EGFP MES-like",
      "type_12" = "cluster 12",
      "type_chr_sym/type_sympathoblast" = "chromaffin/sympathoblast"
    )
  )
)

abbrev_dict <- c(
  # SCP lineage
  "early SCP"                        = "early SCP",
  "late SCP"                         = "late SCP",
  "early/late SCP"                   = "early/late SCP",
  
  # chromaffin / sympathoblast
  "chromaffin"                       = "ChC",
  "sympathoblast"                    = "SYM",
  "chromaffin/sympathoblast"         = "ChC/SYM",
  "early sympathoblast-like"         = "early SYM-like",
  
  # progenitor
  "early progenitor"                 = "early prog.",
  "late progenitor"                  = "late prog.",
  "early/late progenitor"            = "early/late prog.",
  
  # endoneural fibroblast
  "early endoneural fibroblast"      = "early ENF",
  "late endoneural fibroblast"       = "late ENF",
  "early/late endoneural fibroblast" = "early/late ENF",
  
  # myofibroblast
  "early myofibroblast"              = "early MF",
  "late myofibroblast"               = "late MF",
  "early/late myofibroblast"            = "early/late MF",
  
  # EGFP / misc
  "EGFP MES-like"                         = "EGFP MES-like",
  "EGFP ADRN-like"                       = "EGFP ADRN-like",
  "bridging"                         = "bridging"
)

bio_order_list <- list("EpiC" = 
                         c("type_early_prog", "type_early/late_myofibroblast", "type_early/late_endoneural_fibroblasts", "type_EGFP_MES",
                           "type_early/late_SCP", "type_chr_sym", "type_bridging", "type_sympathoblast",
                           "type_EGFP_tumor"),
                       "kolf2" = 
                         c("type_early_prog", "type_early_endoneural_fibroblasts", "type_late_endoneural_fibroblasts", "type_EGFP_MES",
                           "type_early_SCP",  "type_late_SCP", "type_bridging", "type_early_SYM_like", "type_chromaffin", 
                           "type_chr_sym/type_sympathoblast", "type_sympathoblast", "type_EGFP_tumor", "type_12"))

root_list <- list(
  "EpiC"="type_SCP",
  "kolf2"="type_SCP" 
)

# for colour coding the expr levels
min_val <- 0
max_val <- 2.5

# define colors
cluster_palette <- c(
  
  # Early progenitors
  "type_early_prog" = "#F6C141",   # golden yellow
  
  # Schwann cell precursors (blue gradient)
  "type_early_SCP" = "#6BAED6",
  "type_late_SCP"  = "#2171B5",
  "type_early/late_SCP" = "#4292C6",
  
  # Bridging state
  "type_bridging" = "#C77CFF",     # purple
  
  # Adrenergic lineage (red gradient)
  "type_chr_sym/type_sympathoblast" = "#CB181D",
  "type_early_SYM_like"="#FB6A4A",
  "type_sympathoblast" = "#EF3B2C",
  "type_chr_sym" = "#B2182B",
  "type_chromaffin" = "#67000D",
  
  # Endoneurial fibroblasts (teal)
  "type_early_endoneural_fibroblasts" = "#66C2A4",
  "type_late_endoneural_fibroblasts" = "#238B6C",
  "type_early/late_endoneural_fibroblasts" = "#41AE76",
  
  # Myofibroblasts (green)
  "type_early/late_myofibroblast" = "#4DAF4A",
  
  # MES tumour
  "type_EGFP_MES" = "#006D2C",
  
  # Tumour
  "type_EGFP_tumor" = "#111111",
  
  # Unknown cluster
  "type_12" = "#BDBDBD"
)

# reference information
ref_info <- list(
  "Jansky" = list(path="Neuroblastoma_sc_Jansky.rds", label_col = "celltype"),
  "Kameneva" = list(path="adrenal.human.seurat.scrublet.rds", label_col = "fate2"),
  "adr"  = list(path = "adr_all.rds",  label_col = "Annotation"), # Kildisiute
  "GOSH" = list(path = "nb_GOSH.rds", label_col = "Annotation"), # Kildisiute
  "PMC"  = list(path = "nb_PMC.rds",  label_col = "Annotation"), # Kildisiute
  "Saldana" = list(path = "GSE221853_ncnb_seurat_full.rds",  label_col = "type3"), # note: lot of mappings to previous studies is available!
  "vanHaver" = list(path = "CellsOfInterest_SLB.rds",  label_col = "seurat_clusters")
)

# Colors for harmonized atlas labels
atlas_palette <- c(
  "tumor"         = "#111111",  # same as type_EGFP_tumor
  
  "SCP"           = "#2171B5",  # late SCP blue
  "bridge"        = "#C77CFF",  # bridging purple
  "CPC"           = "#F6C141",  # early progenitor yellow
  
  "sympathoblast" = "#EF3B2C",  # sympathoblast red
  "chromaffin"    = "#67000D",  # dark red
  
  "prolif"        = "#FB6A4A",  # intermediate adrenergic red
  
  "mesenchymal"   = "#006D2C",  # MES tumor green
  "endothelial"   = "#1B9E77",  # teal
  
  "immune"        = "#7570B3",  # muted violet # other!
  "cortex"        = "#E7298A",  # magenta # other!
  "kidney"        = "#A6761D",  # brown # other!
  "liver"         = "#D95F02",  # orange # other!
  "melanocyte"    = "#636363",  # dark gray # other!
  "erythroid"     = "#E41A1C",  # bright red # other!
  
  "other"       = "#BDBDBD",
  "low (<0.5)" = "#E0E0E0"
)

# drop_clusters <- 12 # below this number of cells, drop clusters
drop_clusters <- 10 # below this number of cells, drop clusters
drop_in_hTH <- c("type_early_endoneural_fibroblasts", "type_sympathoblast")


# number of genes used for integration
nHVG <- 2000 # 2000 is usually enough to capture sub-states. (5000 HVGs might be too many for a single cell type.)
nHVG_str <- as.character(nHVG)