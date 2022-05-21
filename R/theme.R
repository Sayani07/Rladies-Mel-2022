## ---- theme-remark
theme_remark <- function() {
  theme_grey() +
    theme(
      axis.text = element_text(size = 24),
      strip.text = element_text(size = 24,
                                margin = margin()),
      axis.title = element_text(size = 24),
      legend.title = element_text(size = 24),
      legend.text = element_text(size = 24),
      legend.position = "bottom",
      plot.title =  element_text(size = 24),
          panel.background = element_rect(colour = "white", fill = "white"),  axis.line = element_line(colour = "black"),   panel.grid.major = element_line(size = 0.5, linetype = 'solid',                                      colour = "#D3D3D3"), 
          panel.grid.minor = element_line(size = 0.25, linetype = 'solid',
                                          colour = "#D3D3D3"))
}

## ---- theme-alldist
theme_alldist <- function() {
  theme_grey() +
    theme(
      axis.text = element_text(size = 16),
      strip.text = element_text(size = 16, margin = margin()),
      axis.title = element_text(size = 16),
      legend.title = element_text(size = 16),
      legend.text = element_text(size = 16),
      plot.title =  element_text(size = 16)
    )
}
