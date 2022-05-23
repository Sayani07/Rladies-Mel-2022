## ---- load
source("R/theme.R")
library(tidyverse)
library(dplyr)
library(sugrrants)
library(tsibble)
library(gravitas)
library(kableExtra)
library(gganimate)
library(lubridate)
library(ggridges)
library(ggpubr)
library(lvplot)
library(magrittr)
library(gghdr)
library(stats)
library(gghdr)
library(hdrcde)
library(ggplot2)

##----question1
set.seed(12000)
par(mfrow = c(2, 3))
norm <- rnorm(1000, 30, 10)
p1 <- plot(density(norm))
p2 <- plot(density(acidity*5))
p3 <- plot(density(chondrite))

p4 <- boxplot(norm)
p5 <- boxplot(acidity*5)
p6 <- boxplot(chondrite)


##----hdrdensity

hdr.den(faithful$eruptions,
        col = c("skyblue", "slateblue2", "slateblue4"),
        prob = c(95,50))

##----hdr.boxplot

hdr.boxplot(faithful$eruptions)

##----geom-hdr-boxplot

ggplot(data = faithful,
       aes(y = eruptions)) +
  geom_hdr_boxplot() +
  theme_remark()

##----geom-hdr-boxplot-group

ggplot(data = mpg,
       aes(y = hwy, fill = as.factor(cyl))) +
  geom_hdr_boxplot() + theme_remark() +
  theme(legend.position = "right") +
  labs(y = "highway miles per gallon",
       fill = "number of cylinders")



##----geom-hdr-box-jitter

ggplot(data = faithful,
       aes(y = eruptions)) +
  geom_hdr_boxplot(fill = c("blue")) +
  geom_jitter(aes(x = 0)) + theme_remark()


##----hdr-rug

ggplot(data = faithful, aes(x = waiting, y = eruptions)) +
  geom_point() +
  geom_hdr_rug(fill = "blue") + theme_remark()


##----hdr-scatter

ggplot(data = faithful, aes(x = waiting, y = eruptions)) +
  geom_point(aes(colour = hdr_bin(x = waiting, y = eruptions))) + scale_colour_viridis_d(direction = -1) + theme_remark()

##----combo

ggplot(data = faithful, aes(x = waiting, y = eruptions)) +
  geom_point(aes(colour = hdr_bin(x = waiting, y = eruptions))) +
  geom_hdr_rug() +
  scale_colour_viridis_d(direction = -1) + theme_remark()

##----covid19

library(tidycovid19)
#remotes::install_github("joachim-gassen/tidycovid19")
updates <- download_merged_data(cached = TRUE)
countries <- c("ITA", "GBR", "IND", "IRN", "SAU")

updates %>%
  plot_covid19_spread(
    highlight = countries,
    type = "confirmed",
    edate_cutoff = 40,
    min_cases = 100
  )

updates2D <- updates %>% mutate(first_date = min(date), days_from_first = date - first_date) %>% filter(days_from_first>=0, iso3c %in% countries)

ggplot(data = updates2D, aes(x = confirmed, y = days_from_first)) + geom_point(aes(colour = hdr_bin(x = days_from_first, y = confirmed))) +
  scale_colour_viridis_d(direction = -1) + facet_wrap(~country)

updates %>%
  filter(iso3c %in% countries) %>%
  mutate(cases_logratio = difference(log(confirmed))) %>%
  group_by(country) %>%
  ggplot(aes(x = country, y = cases_logratio)) +
  geom_boxplot()+
  scale_y_continuous(
    "Daily increase in cumulative cases",
    breaks = log(1+seq(0,60,by=10)/100),
    labels = paste0(seq(0,60,by=10),"%"))



updates %>%
  mutate(month = lubridate::month(date)) %>%
  filter(iso3c %in% countries, month>1) %>%
  mutate(cases_logratio = difference(log(confirmed))) %>%
  mutate(cases_percentage = 100*(exp(cases_logratio) - 1)) %>%
  filter(!is.na(cases_logratio)) %>%
  group_by(country) %>%
  ggplot(aes(y = confirmed, x = country)) +
  geom_hdr_boxplot(all.modes = TRUE) +
  scale_fill_brewer(palette = "Dark2")  + theme_minimal() + geom_boxplot(color = "blue", alpha = 0.05)

##----allplots

mpg <- mpg %>%
  filter (class %in% c("compact", "midsize", "suv","minivan")) %>%
  mutate(cls =
           case_when(
             class == "compact" ~ "A",
             class == "midsize" ~ "B",
             class == "suv" ~ "C",
             class == "minivan"  ~ "D"))

pbox <- ggplot(mpg, aes(cls, hwy)) +
  geom_boxplot() + ylab("") + xlab("") +
  theme(
    axis.text = element_text(size = 16))

pridge <-  ggplot(mpg, aes(hwy, cls)) +
  geom_density_ridges2() +
  xlab("") +
  ylab("") + theme(
    axis.text = element_text(size = 14))

pviolin <-  ggplot(mpg, aes(cls, hwy)) +
  geom_violin() + ylab("") + xlab("")+ theme(
    axis.text = element_text(size = 14))

plv <-  ggplot(mpg, aes(cls, hwy)) +
  geom_lv(aes(fill = ..LV..), outlier.colour = "red", outlier.shape = 1) +
  ylab("") + xlab("") +  xlab("") + ylab("")+  theme(legend.position = "bottom", legend.text = element_text(size=14)) +  scale_fill_brewer(palette = "Dark2")

p4_quantile <- mpg %>%
  group_by(cls) %>%  do({
    x <- .$hwy
    map_dfr(
      .x = c(0.25, 0.5, 0.75, 0.9),
      .f = ~ tibble(
        Quantile = .x,
        Value = quantile(x, probs = .x, na.rm = TRUE)
      )
    )
  })

pquant <- p4_quantile %>% ggplot(aes(x = cls, y = Value, group = Quantile,  col = as.factor(Quantile))) + geom_line() +   xlab("") + ylab("") + theme(legend.position = "bottom") + scale_color_brewer(palette = "Dark2") +   ylab("") + xlab("")  + guides(color = guide_legend(title = "quantiles"))+  theme(legend.position = "bottom", legend.text=element_text(size=16))
#
# phdr <- ggplot(data = mpg,
#                aes(y = hwy, fill = cls)) +
#   geom_hdr_boxplot(all.modes = FALSE, prob = c(0.5, 0.9)) +
#   ylab("") +
#   xlab("") + theme(legend.position = "bottom") + scale_fill_brewer(palette = "Dark2")

phist <-ggplot(data = mpg,
               aes(x = hwy)) +
  facet_grid(as.factor(cls)~.) +
  geom_histogram(bins = 50) +
  ylab("") + xlab("") +  xlab("") + ylab("")+  theme(legend.position = "bottom", legend.text = element_text(size=14)) +  scale_fill_brewer(palette = "Dark2")


ggarrange(pbox, pviolin, pridge, pquant, plv,  phist, nrow = 2, ncol = 3, labels = c("box", "violin", "ridge","quantile", "letter-value",  "histogram"))


##----hdrcde-boxplot
library(hdrcde)
hdr.boxplot(faithful$eruptions)


##----authors
knitr::include_graphics("images/authors1.png")


##----hdrcde
knitr::include_graphics("images/allplots1png.png")


##----falpha
knitr::include_graphics("images/falpha.png")

##----print-data
faithful %>% as_tibble()

##----faithful-density

p1 <- ggplot(data = faithful, aes(x = eruptions)) + geom_density() + theme_remark()

p2 <- ggplot(data = faithful, aes(y = eruptions)) +
  geom_boxplot() + theme_remark()  + coord_flip()

p3 <- ggplot(data = faithful, aes(y = eruptions)) +
  geom_hdr_boxplot() + theme_remark()  + coord_flip()

ggarrange(p1, p2, p3, nrow = 3, ncol = 1)

##----allplotspng

knitr::include_graphics("images/allplots.png")

##----question1png

knitr::include_graphics("images/question1.png")
