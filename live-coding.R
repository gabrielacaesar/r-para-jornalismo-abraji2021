# Comentários: ------------------------------
# Sobre os dados:
# Baixar a base do SRAG antes. não deixei no github pois é pesada.
# renomeei para SRAG_2021.csv e deixei na pasta dados/

# Perguntas: --------------------------
# Ainda não elencamos!


# Live coding --------------------------
# Carregar pacotes
library(tidyverse)
library(janitor)
library(naniar)

# Importar os dados
srag_brutos <- read_csv2("docs/dados/SRAG_2021.csv")


# Observar a base

# número de linhas
nrow(srag_brutos)

# número de colunas
ncol(srag_brutos)

# resumo
glimpse(srag_brutos)


# Limpar o nome das variáveis
srag <- clean_names(srag_brutos)

# remover a base bruta da memória RAM
rm(srag_brutos)

# resumo
glimpse(srag)

# visualizar um resumo dos dados faltantes (NAs)
na_srag <- miss_var_summary(srag)

View(na_srag)

# selecionar colunas interessantes - depende da pergunta!

