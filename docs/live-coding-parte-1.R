# Anotações: ------------------------------
# Sobre os dados:
# Baixar a base do SRAG antes. não deixei no github pois é pesada.


# DADOS DE 2020
# https://opendatasus.saude.gov.br/dataset/bd-srag-2020
# Baixei, renomeei para INFLUD-2020.csv e deixei na pasta dados/


# DADOS DE 2021
# https://opendatasus.saude.gov.br/dataset/bd-srag-2021
# Baixei, renomeei para INFLUD-2021.csv e deixei na pasta dados/



# Dicionário de dados: https://opendatasus.saude.gov.br/dataset/9f76e80f-a2f1-4662-9e37-71084eae23e3/resource/b3321e55-24e9-49ab-8651-29cf5c8f3179/download/dicionario_de_dados_srag_hospitalizado_23.03.2021.pdf

# Live coding --------------------------

# Podemos escrever comentários no nosso código, usando o hashtag!
# tudo que é escrito em alguma linha após o hashtag não será considerado.

# Pacotes --------------
# Conceito importante: pacotes.
# Podemos pensar nos pacotes conjuntos de ferramentas!
# Essas "ferramentas" nós chamamos de funções.
# Para usar essas ferramentas, precisamos instalar
# os pacotes uma vez, e cada vez que quisermos usar precisamos
# carregar eles.

# Para instalar os pacotes usamos a função
# install.packages("nome_do_pacote")
# e para carregar o pacote usamos a função library(nome_do_pacote).

# Exemplo:

# install.packages("tidyverse")
# install.packages("janitor")
# install.packages("naniar")


library(tidyverse) # este pacote oferece uma GRANDE quantidade
# de ferramentas para análise de dados!

library(janitor) # limpeza de dados


# Importar os dados ---------
# Conceito importante: objetos!

srag_brutos_2020 <- read_csv2("docs/dados/INFLUD-2020.csv")

# Conceito importante: data.frames. É um formato
# tabular de dados, similar ao que estamos acostumadas
# a ver no excel.
# linhas e colunas: cada linha é uma observação (neste caso, paciente),
# e cada coluna é uma variável.

# Observar a base ----

# número de linhas
nrow(srag_brutos_2020)

# número de colunas
ncol(srag_brutos_2020)

# resumo: quais são as principais colunas/dados no nosso arquivo?
glimpse(srag_brutos_2020)


# selecionar colunas interessantes para responder as perguntas

srag_2020_selecionado <- srag_brutos_2020 %>%
  select(CLASSI_FIN, DT_ENCERRA, EVOLUCAO, CS_SEXO, SG_UF_NOT, ID_MUNICIP)

# ver novamente o resumo
glimpse(srag_2020_selecionado)

# remover a base bruta
rm(srag_brutos_2020)

# Para 2021 (de uma forma mais curta, sem objetos intermediários) -------
srag_2021_selecionado <- read_csv2("docs/dados/INFLUD-2021.csv") %>%
  # selecionar algumas colunas interessantes para responder as perguntas
  select(CLASSI_FIN, DT_ENCERRA, EVOLUCAO, CS_SEXO, SG_UF_NOT, ID_MUNICIP)

# Juntar os dados! ------------------

srag <- bind_rows(srag_2020_selecionado, srag_2021_selecionado) %>%
  clean_names() # Limpar o nome das variáveis

# remover as bases intermediárias
rm(srag_2020_selecionado, srag_2021_selecionado)


# Exportar a base criada em um arquivo .Rds
write_rds(srag, "docs/dados-output/srag.Rds")

