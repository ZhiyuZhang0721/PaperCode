function nir = calculateNIR(GT, detected_edges)
    % GT: Ground truth edges (binary image)
    % detected_edges: Detected edges (binary image)
    
    % False positives: Non-edges identified as edges
    FP = sum(sum((GT == 0) & (detected_edges == 1)));
    
    % Total number of non-edge pixels in the ground truth
    total_non_edge_pixels = sum(sum(GT == 0));
    
    % Noise Introduction Rate: Proportion of non-edges identified as edges
    nir = FP / total_non_edge_pixels;
end