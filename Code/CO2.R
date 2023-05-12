#CO2
csv <- read.csv("~/Documents/TwoSeventyEight/Data/co2_weekly_mlo.csv")
csv.clean <- csv[csv$average != -999.99,]
csv.clean$Date <- as.Date(strptime(paste(csv.clean$year, csv.clean$month, csv.clean$day, sep="/"), format="%Y/%m/%d"), "%y-%m-%d")
colnames(csv.clean)[5] <- "PPM"


co2 <- ggplot(csv.clean, aes(x = Date, y = PPM)) +
  geom_line(color = twoseventyeight_color("purple")) +
  geom_line(color = twoseventyeight_color("purple"), alpha = 0.5, stat = 'smooth', se = F) +
  theme_twoseventyeight +
  guides(size = "none") +
  labs(title = "Global CO₂ Concentration",
       subtitle = str_wrap("Carbon Dioxide concentration measured in parts per million at the Mauna Loa Observatory in Hawai'i", width = 50),
       caption = c("TWOSEVENTYEIGHT", "SOURCE: NOAA/GML & Scripps Institution of Oceanography")) +
  ylab("CO₂ (ppm)") +
  xlab("Year")

ggsave(filename= "~/Documents/TwoSeventyEight/Figures/CO2.png",
       plot = co2, units=c("px"), width = 3200, height = 1800, dpi=300)
