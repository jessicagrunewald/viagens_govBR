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

# GASTOS COM PASSAGENS
# Criando um dataframe com os 15 principais órgãos com maiores valores de gastos
gastos_passagens <- viagens %>%
  group_by(`Nome do órgão superior`) %>%
  summarise(n = sum(`Valor passagens`)) %>%
  arrange(desc(n)) %>%
  head(15)

names(gastos_passagens) <- c("orgao","valor")

gastos_passagens

library(ggplot2)

# Gráfico de barras horizontais com ggplot2 dos valores gastos em passagens
ggplot(gastos_passagens, aes(x = reorder(orgao, valor), y = valor))+
  geom_bar(stat = "identity", fill = "pink")+
  geom_text(aes(label=valor), vjust=0.3, size=3)+
  coord_flip()+
  labs(x="Órgãos", y="Valor")

# Os 15 destinos com maiores valores de passagens, quando
# o nome do órgão estiver indicado como "Sem Informação"
viagens_sem_info <- viagens %>%
  filter(`Nome do órgão superior` == "Sem informação") %>%
  group_by(`Destinos`) %>%
  summarise(n = sum(`Valor passagens`)) %>%
  arrange(desc(n)) %>%
  head(15)

print(viagens_sem_info)

library(scales)

# Gráfico de pizza mostrando apenas os 3 itens com maior valor de passagem
# quando a categoria do órgão é igual a "Sem informação"
ggplot(data = viagens_sem_info %>% slice(1:3), aes(x = "", y = "", fill = Destinos)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar("y", start = 0) +
  scale_fill_brewer(palette = "Set2") +
  labs(title = "Top 3 Destinos com maiores Valores de Passagens - Órgão Sem Informação") +
  theme_minimal() +
  geom_text(aes(label = percent(round(n / sum(viagens$`Valor passagens`), 4))), position = position_stack(vjust = 0.5))

# Os 15 destinos com maiores valores de passagens, quando
# o nome do órgão estiver indicado como "Ministério das Relações Exteriores"
viagens_min_rela_ext <- viagens %>%
  filter(`Nome do órgão superior` == "Ministério das Relações Exteriores") %>%
  group_by(Destinos) %>%
  summarise(n = n()) %>%
  arrange(desc(n)) %>%
  head(15)

print(viagens_min_rela_ext)

