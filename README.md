# My talk at R Ladies Melbourne

I will walk you through how to build new plotting symbols that are not implemented in ggplot2 yet. This enables users to customize and integrate new graphical elements with existing ggplot2 visualizations, resulting in a broad range of informative graphics. The idea is to illustrate it with a few examples, but mainly demonstrate it through the recently developed R package `gghdr`. The package provides a framework for visualizing Highest Density Regions (HDR) using the ggplot2 graphics syntax. The method of summarizing a distribution using HDR is useful for plotting multimodal distributions, but unlike box plots, density plots, or violin plots, there is no way to draw HDRs in a ggplot2 framework. We will see how `gghdr` extends the functionality of ggplot2 by calling new stat_* and geom_* functions, where the stat_* functions are inherited from the R package `hdrcde` and the geom_* functions are built to produce the new plotting symbols.

You can find more about package `gghdr` in https://cran.r-project.org/web/packages/gghdr/index.html and https://sayani07.github.io/gghdr/

Event details: https://www.meetup.com/rladies-melbourne/events/285876172/

More about R-Ladies: https://rladies.org/ladies-complete-list/locality/Melbourne/
