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

# Criando uma nova coluna com os dados da coluna Período - Data de início
# no formato Date
viagens$data.inicio <- as.Date(viagens$`Período - Data de início`,
                               format = "%d/%m/%Y")

# Criando coluna com o mês do inicio da viagem
viagens$data.inicio.mes <- format(viagens$data.inicio, format = "%m")

# Verificando medidas da coluna Valor passagens
summary(viagens$`Valor passagens`)
sd(viagens$`Valor passagens`)

# Verificando a porcentagem de viagens realizadas
prop.table(table(viagens$Situação))*100

