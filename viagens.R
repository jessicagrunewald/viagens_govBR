# Importando a base de dados
viagens <- read.csv2(
  file = "2023_Viagem.csv",
  header=TRUE,
  sep = ";",
  dec = ",",
  fileEncoding = "Latin1",
  check.names = F
)

library(dplyr)
# Verificar informação sobre cada coluna
glimpse(viagens)

# Criando uma nova coluna com os dados da coluna Período - Data de início
# no formato Date
viagens$data.inicio <- as.Date(viajens$`Período - Data de início`,
                               format = "%d/%m/%Y")

