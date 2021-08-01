# Anotações: ------------------------------
# Sobre os dados:
# Baixar a base do SRAG antes. não deixei no github pois é pesada.
# renomeei para INFLUD.csv e deixei na pasta dados/


# https://opendatasus.saude.gov.br/dataset/bd-srag-2021

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

srag_brutos <- read_csv2("docs/dados/INFLUD.csv")

# Conceito importante: data.frames. É um formato
# tabular de dados, similar ao que estamos acostumadas
# a ver no excel.
# linhas e colunas: cada linha é uma observação (neste caso, paciente),
# e cada coluna é uma variável.

# Observar a base ----

# número de linhas
nrow(srag_brutos)

# número de colunas
ncol(srag_brutos)

# resumo: quais são as principais colunas/dados no nosso arquivo?
glimpse(srag_brutos)

# Breve limpeza de dados -----------

# Limpar o nome das variáveis
srag <- clean_names(srag_brutos)

# remover a base bruta da memória RAM
rm(srag_brutos)

# resumo
glimpse(srag)

# selecionar colunas interessantes para responder as perguntas
# evolucao, cs_sexo, sg_uf_not, id_municip


# Respondendo perguntas --------
# Conceito importante: pipe %>% - usamos isso para usar funções
# sequencialmente! Assim fica mais fácil de entender a ordem.

## Pergunta 1: -------
# Quantas mortes por Covid-19 no Brasil aparecem na nossa base
# de dados?
# Olhando o dicionário de dados, vemos que a coluna que ajuda a
# responder essa pergunta é a 'evolucao', e que o valor 2 representa
# óbito.
# NA são dados faltantes, informações que não sabemos!
# elas existem mas não temos acesso, então é importante considerar isso.


srag %>%
  count(evolucao) %>% # faz uma contagem por grupos
  filter(evolucao == 2) # filtrar valores de alguma variável


## Pergunta 2: ---
# Morreram mais mulheres ou mais homens de Covid-19?

srag %>%
  count(evolucao, cs_sexo) %>% # faz uma contagem por grupos
  filter(evolucao == 2) %>%  # filtrar valores de alguma variável
  arrange(n) # ordenar por alguma variável

## Pergunta 3: ---
# Quais estados têm o maior e o menor número de mortes,
# em números absolutos? E nas cidades?

# estados!
mortes_estados <- srag %>%
  count(evolucao, sg_uf_not) %>% # faz uma contagem por grupos
  filter(evolucao == 2) %>%  # filtrar valores de alguma variável
  arrange(n) # ordenar por alguma variável

View(mortes_estados) # função View() é útil para visualizar
# os dados como tabela. mas NUNCA use com uma tabela
# muito grande, pois pode travar sua sessão do RStudio.

head(mortes_estados) # head é a função pra mostrar as primeiras
# linhas de uma base

tail(mortes_estados) # tail é a função pra mostrar as últimas
# linhas de uma base

# municipios

mortes_municipios <- srag %>%
  count(evolucao, sg_uf_not, id_municip) %>% # faz uma contagem por grupos
  filter(evolucao == 2) %>%  # filtrar valores de alguma variável
  arrange(desc(n)) # ordenar por alguma variável

head(mortes_municipios) # head é a função pra mostrar as primeiras
# linhas de uma base

tail(mortes_municipios) # tail é a função pra mostrar as últimas
# linhas de uma base

