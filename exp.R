ggplot(faithful, aes(eruptions, waiting)) +
  geom_boxplot(stat = "identity")

ggplot(faithful, aes(eruptions, waiting)) +
  stat_summary(geom = "bar",fun = "mean")


