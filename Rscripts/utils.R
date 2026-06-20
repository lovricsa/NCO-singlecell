#######################################################################
# Function: test_umap_params
# Purpose: Iterates through a list of UMAP parameters, runs RunUMAP, 
#          and saves a diagnostic plot for each.
#######################################################################

test_umap_params <- function(seu_obj, param_list, reduction_use = "scvi", output_dir = Figures) {
  
  for (name in names(param_list)) {
    message(paste0("--- Running UMAP for configuration: ", name, " ---"))
    
    # Extract parameters from the list
    nn <- param_list[[name]]$nn      # n.neighbors
    md <- param_list[[name]]$md      # min.dist
    dims_use <- 1:param_list[[name]]$umapdims
    
    # Run UMAP
    # We use a unique reduction.name so we don't overwrite the default 'umap'
    reduction_name <- paste0("umap_", name)
    
    seu_obj <- RunUMAP(
      seu_obj, 
      reduction = reduction_use, 
      dims = dims_use, 
      n.neighbors = nn, 
      min.dist = md, 
      reduction.name = reduction_name,
      verbose = FALSE
    )
    
    # Create a plot to visualize the result
    # Group by sample.names or clusters if you've calculated them
    p <- DimPlot(seu_obj, reduction = reduction_name, group.by = "sample.names") + 
      labs(title = paste0("Config: ", name, " (nn:", nn, ", md:", md, ", dims:", max(dims_use), ")")) +
      theme_minimal()
    
    # Save the plot
    ggsave(
      filename = file.path(output_dir, paste0("umap_test_", name, ".png")),
      plot = p, width = 8, height = 6
    )
  }
  
  return(seu_obj)
}


#######################################################################
# Function: get_glasswork_layers
# Replicates the exact logic of clusterhull3 for your integrated object
#######################################################################
get_glasswork_layers <- function(seu_obj, 
                                 clusvar = "seurat_clusters", 
                                 reduction = "umap", 
                                 concavity = 2.5, 
                                 core_quantile = 0.8, # Keep densest 80%
                                 linecolor = "white", 
                                 size = 0.1) {
  require(concaveman)
  require(dplyr)
  require(MASS) # For density estimation
  
  umap_df <- as.data.frame(Embeddings(seu_obj, reduction = reduction))
  colnames(umap_df) <- c("UMAP_1", "UMAP_2")
  umap_df[[clusvar]] <- seu_obj@meta.data[[clusvar]]
  
  clusters <- sort(unique(umap_df[[clusvar]]))
  plot_layers <- list()
  
  for (cl in clusters) {
    # 1. Isolate cluster points
    cl_points <- umap_df %>% filter(!!sym(clusvar) == cl) %>% dplyr::select(UMAP_1, UMAP_2)
    
    if(nrow(cl_points) < 5) next # Skip tiny clusters
    
    # 2. Calculate Local Density (KDE)
    # This identifies which points are in the "crowd" vs outliers
    dens <- kde2d(cl_points$UMAP_1, cl_points$UMAP_2, n = 50)
    
    # Map density back to each point
    ix <- findInterval(cl_points$UMAP_1, dens$x)
    iy <- findInterval(cl_points$UMAP_2, dens$y)
    cl_points$density <- mapply(function(x, y) dens$z[x, y], ix, iy)
    
    # 3. Filter: Keep only points above the density threshold
    threshold <- quantile(cl_points$density, 1 - core_quantile)
    cl_core <- cl_points %>% filter(density >= threshold)
    
    # 4. Generate Hull from CORE points only
    hull_points <- as.data.frame(concaveman(as.matrix(cl_core[,1:2]), concavity = concavity))
    colnames(hull_points) <- c("UMAP_1", "UMAP_2")
    hull_points[[clusvar]] <- cl
    
    # 5. Create the Layer
    layer <- geom_polygon(
      data = hull_points,
      aes(x = UMAP_1, y = UMAP_2, fill = !!sym(clusvar)),
      color = linecolor,
      linewidth = size,
      inherit.aes = FALSE,
      alpha = 0.3
    )
    
    plot_layers <- append(plot_layers, list(layer))
  }
  
  return(plot_layers)
}

# with outline only
get_glasswork_layers_outline <- function(seu_obj, 
                                 clusvar = "seurat_clusters", 
                                 reduction = "umap", 
                                 concavity = 2.5, 
                                 core_quantile = 0.8, 
                                 linecolor = "black", # Changed to black for better contrast
                                 size = 0.5) {        # Thicker line for outlines
  require(concaveman)
  require(dplyr)
  require(MASS) 
  
  umap_df <- as.data.frame(Embeddings(seu_obj, reduction = reduction))
  colnames(umap_df) <- c("UMAP_1", "UMAP_2")
  umap_df[[clusvar]] <- seu_obj@meta.data[[clusvar]]
  
  clusters <- sort(unique(umap_df[[clusvar]]))
  plot_layers <- list()
  
  for (cl in clusters) {
    cl_points <- umap_df %>% 
      filter(!!sym(clusvar) == cl) %>% 
      dplyr::select(UMAP_1, UMAP_2)
    
    if(nrow(cl_points) < 10) next 
    
    dens <- MASS::kde2d(cl_points$UMAP_1, cl_points$UMAP_2, n = 50)
    ix <- findInterval(cl_points$UMAP_1, dens$x)
    iy <- findInterval(cl_points$UMAP_2, dens$y)
    cl_points$density <- mapply(function(x, y) dens$z[x, y], ix, iy)
    
    threshold <- quantile(cl_points$density, 1 - core_quantile)
    cl_core <- cl_points %>% filter(density >= threshold)
    
    if(nrow(cl_core) < 3) next
    
    hull_points <- as.data.frame(concaveman(as.matrix(cl_core[,1:2]), concavity = concavity))
    colnames(hull_points) <- c("UMAP_1", "UMAP_2")
    
    # New Layer Logic: fill = NA removes the background color
    layer <- geom_polygon(
      data = hull_points,
      aes(x = UMAP_1, y = UMAP_2),
      fill = NA,            # <--- This turns off the hull coloring
      color = linecolor,    # <--- This keeps the outline
      linewidth = size,
      inherit.aes = FALSE
    )
    
    plot_layers <- append(plot_layers, list(layer))
  }
  
  return(plot_layers)
}

#######################################################################
# Function: subset_seu_by_day
# Subset the seurat object by the selected day (which could be several days)
#######################################################################
subset_seu_by_day <- function(seu_obj, day) {
  # Extract unique sample names once to speed up grep operations
  all_samples <- unique(seu_obj$sample.names)
  
  # Step 1: Identify the matching samples based on the 'day' key
  matched_samples <- switch(day,
                            "all"           = return(seu_obj), # Return early if 'all'
                            
                            "D26_both"      = grep(paste0(gsub("_both", "", day), "$"), all_samples, value = TRUE),
                            
                            "D42_both"      = grep(gsub("_both", "", day), all_samples, value = TRUE),
                            
                            "D26_WT"        = grep(paste0("MIX_", gsub("_WT", "", day), "$"), all_samples, value = TRUE),
                            
                            "D26_STOP_MYCN" = grep(paste0("MYCN_", gsub("_STOP_MYCN", "", day), "$"), all_samples, value = TRUE),
                            
                            "D42_novirus"   = grep(paste0("MYCN_", gsub("_novirus", "", day), "$"), all_samples, value = TRUE),
                            
                            "healthy"       = all_samples[!all_samples %in% grep("hTH", all_samples, value = TRUE)],
                            
                            # Default case (e.g., "D42_hTH", "D26", "D42")
                            grep(paste0(day, "$"), all_samples, value = TRUE)
  )
  
  # Step 2: Subset the Seurat object using the matched samples
  return(subset(seu_obj, subset = sample.names %in% matched_samples))
}


# Helper function to add minimalist corner axes to any Seurat plot
add_corner_axes <- function(plot_obj, arrow_length = 0.20, margin_offset = 0.02, text_offset = 0.03) {
  
  # 1. Dynamically extract dimension names (works for UMAP, t-SNE, or PCA)
  dims <- colnames(plot_obj$data)[1:2]
  
  # 2. Get coordinates to find the plot boundaries
  x_vals <- plot_obj$data[[dims[1]]]
  y_vals <- plot_obj$data[[dims[2]]]
  
  x_min <- min(x_vals); x_max <- max(x_vals); x_range <- x_max - x_min
  y_min <- min(y_vals); y_max <- max(y_vals); y_range <- y_max - y_min
  
  # 3. Define the origin point for the new corner axes (shifted slightly from absolute min)
  start_x <- x_min + (x_range * margin_offset)
  start_y <- y_min + (y_range * margin_offset)
  
  # Define how long the custom axis arrows should be
  len_x <- x_range * arrow_length
  len_y <- y_range * arrow_length
  
  # Clean up labels for display (e.g., "umap_1" becomes "UMAP 1")
  label_x <- toupper(gsub("_", " ", dims[1]))
  label_y <- toupper(gsub("_", " ", dims[2]))
  
  # 4. Remove original axes and layer on custom corner arrows
  plot_obj + 
    theme(
      axis.line = element_blank(),
      axis.text = element_blank(),
      axis.ticks = element_blank(),
      axis.title = element_blank(),
      panel.grid = element_blank()
    ) +
    # Custom X-Axis Arrow
    annotate("segment", x = start_x, xend = start_x + len_x, y = start_y, yend = start_y,
             arrow = arrow(length = unit(0.12, "cm"), type = "closed"), linewidth = 0.6, color = "black") +
    # Custom Y-Axis Arrow
    annotate("segment", x = start_x, xend = start_x, y = start_y, yend = start_y + len_y,
             arrow = arrow(length = unit(0.12, "cm"), type = "closed"), linewidth = 0.6, color = "black") +
    # Custom X Label
    annotate("text", x = start_x + (len_x / 2), y = start_y - (y_range * text_offset), 
             label = label_x, size = 3, vjust = 1, hjust = 0.5, fontface = "bold") +
    # Custom Y Label
    annotate("text", x = start_x - (x_range * text_offset), y = start_y + (len_y / 2), 
             label = label_y, size = 3, vjust = 0.5, hjust = 0.5, angle = 90, fontface = "bold")
}

recode_labels <- function(x, map) {
  dplyr::recode(x, !!!map, .default = "unknown")
}
