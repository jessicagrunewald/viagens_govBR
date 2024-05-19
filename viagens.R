# Importando a base de dados
viagens <- read.csv2(
  file = "2023_Viagem.csv",
  header=TRUE,
  sep = ";",
  dec = ",",
  fileEncoding = "Latin1",
  check.names = F
)

