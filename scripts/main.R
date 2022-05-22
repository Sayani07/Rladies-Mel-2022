library(ggplot2)
library(gghdr)
library(tidyverse)


faithful

p_density <- ggplot(data = faithful, aes(x = eruptions)) + geom_density()

p_hdr <- ggplot(data = faithful,
                aes(y = eruptions)) + stat_hdrcde()

p_box <- ggplot(data = faithful,
                aes(y = eruptions)) +
  geom_boxplot()


#layer_data(p_hist)
layer_data(p_hdr)[1,]
layer_data(p_box)[1,]


geom_boxplot

class(geom_boxplot()$geom)
class(geom_boxplot()$stat)
class(geom_hdr_boxplot()$geom)
class(geom_hdr_boxplot()$stat)

