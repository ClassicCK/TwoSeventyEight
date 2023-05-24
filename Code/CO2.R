#CO2
csv <- read.csv("~/Documents/TwoSeventyEight/Data/co2_weekly_mlo.csv")
csv.clean <- csv[csv$average != -999.99,]
csv.clean$Date <- as.Date(strptime(paste(csv.clean$year, csv.clean$month, 
                                         csv.clean$day, sep="/"), 
                                   format="%Y/%m/%d"), "%y-%m-%d")
colnames(csv.clean)[5] <- "PPM"

csv.clean$group <- as.factor(1)

co2 <- ggplot(csv.clean, aes(x = Date, y = PPM)) +
  geom_line(color = colors_twoseventyeight$purple) +
  geom_line(stat = "smooth", alpha = 0.5, se = F, 
            color = colors_twoseventyeight$purple) +
  theme_twoseventyeight() +
  scale_color_278(palette = "single") +
  guides(size = "none") +
  labs(title = "Global CO₂ Concentration",
       subtitle = str_wrap("Montly Carbon Dioxide concentration measured in parts per million at the Mauna Loa Observatory in Hawai'i", 60),
       caption = str_wrap("The carbon dioxide data on Mauna Loa constitute the 
       longest record of direct measurements of CO₂ in the atmosphere. They were 
                          started by C. David Keeling of the Scripps Institution 
                          of Oceanography in March of 1958 at a facility of the 
                          National Oceanic and Atmospheric Administration (NOAA). 
                          NOAA started its own CO₂ measurements in May of 1974, 
                          and they have run in parallel with those made by 
                          Scripps since then. The sinusoidal pattern observed 
                          within a year is a decrese in local CO₂ concentration 
                          during Northern Hemisphere summer, as the larger 
                          landmass and tree cover of the hemisphere leads 
                          to a temporal increase in photosynthesis.", 160),
       tag = c("","\U24B8 2023 TWOSEVENTYEIGHT"))

ggsave(filename= "~/Documents/TwoSeventyEight/Figures/CO2.png",
       plot = co2, units=c("px"), width = 3200, height = 1800, dpi=300)
