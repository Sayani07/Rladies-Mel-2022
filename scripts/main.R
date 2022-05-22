library(ggplot2)
library(gghdr)
library(tidyverse)


faithful

p_density <- ggplot(data = faithful, aes(x = eruptions)) + geom_density()

p_hdr <- ggplot(data = faithful,
                aes(y = eruptions)) + geom_hdr_boxplot()

p_box <- ggplot(data = faithful,
                aes(y = eruptions)) +
  geom_boxplot()


#layer_data(p_hist)
layer_data(p_hdr)[1,]
layer_data(p_box)[1,]


geom_boxplot

class(geom_violin()$geom)
class(geom_violin()$stat)
class(geom_hdr_boxplot()$geom)
class(geom_hdr_boxplot()$stat)


b <- ggplot(mtcars, aes(wt, mpg)) +
  geom_point()

df <- data.frame(x1 = 2.62, x2 = 3.57, y1 = 21.0, y2 = 15.0)

b +
  geom_segment(aes(x = x1, y = y1, xend = x2, yend = y2, colour = "segment"),
               data = df)

b +
  geom_spoke(aes(angle = 45), radius = 0.5)
