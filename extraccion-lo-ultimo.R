# script para extraer las últimas noticias de La Tercera
# el enlace a Dropbox de este archivo es: https://www.dropbox.com/s/w3ooealankkaom5/extraccion-lo-ultimo.R?dl=0

library(rvest)
library(dplyr)
library(tidyr)
library(lubridate)

html_loultimo <- read_html("https://www.latercera.com/lo-ultimo/")

ultimos_titulares <- html_loultimo %>% 
  html_elements("h3 a") %>% 
  html_text(trim = TRUE)

ultimos_enlaces <- html_loultimo %>% 
  html_elements("h3 a") %>% 
  html_attr("href") %>% 
  paste0("https://www.latercera.com", .)

tabla_lo_ultimo <- tibble(titular = ultimos_titulares, enlace_noticia = ultimos_enlaces) %>% 
  separate(col = titular, 
           into = c("seccion", "titular"),
           sep = "  ",
           extra = "merge")


ahora <- Sys.time()


write.csv(tabla_lo_ultimo, paste0("datos/noticias-lo-ultimo_", Sys.Date(), "_", hour(ahora), "-", minute(ahora), ".csv"))
