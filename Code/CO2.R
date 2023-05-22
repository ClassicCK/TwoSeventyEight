#CO2
csv <- read.csv("~/Documents/TwoSeventyEight/Data/co2_weekly_mlo.csv")
csv.clean <- csv[csv$average != -999.99,]
csv.clean$Date <- as.Date(strptime(paste(csv.clean$year, csv.clean$month, 
                                         csv.clean$day, sep="/"), 
                                   format="%Y/%m/%d"), "%y-%m-%d")
colnames(csv.clean)[5] <- "PPM"


co2 <- ggplot(csv.clean, aes(x = Date, y = PPM)) +
  geom_line(color = twoseventyeight_color("purple")) +
  geom_line(color = twoseventyeight_color("purple"), alpha = 0.5, 
            stat = 'smooth', se = F) +
  theme_twoseventyeight +
  guides(size = "none") +
  labs(title = "Global CO₂ Concentration",
       subtitle = str_wrap("Montly Carbon Dioxide concentration measured in 
       parts per million at the Mauna Loa Observatory in Hawai'i", width = 50),
       caption = str_wrap("The carbon dioxide data on Mauna Loa constitute the 
                          longest record of direct measurements of CO₂ in the 
                          atmosphere. They were started by C. David Keeling of 
                          the Scripps Institution of Oceanography in March of 
                          1958 at a facility of the National Oceanic and 
                          Atmospheric Administration (NOAA). NOAA started 
                          its own CO₂ measurements in May of 1974, and 
                          they have run in parallel with those made by 
                          Scripps since then. The sinusoidal pattern observed
                          within a year is a decrese in local CO₂ concentration
                          during Northern Hemisphere summer, as the larger
                          landmass and tree cover of the hemisphere leads to a 
                          temporal increase in photosynthesis.", width = 120),
       tag = c("TWOSEVENTYEIGHT"))

ggsave(filename= "~/Documents/TwoSeventyEight/Figures/CO2.png",
       plot = co2, units=c("px"), width = 3200, height = 1800, dpi=300)
