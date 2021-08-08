# Carregando os pacotes necessários

library(tidyverse) # este pacote oferece uma GRANDE quantidade
# de ferramentas para análise de dados!

# Importando a base filtrada
mortes_covid <- read_rds("dados-output/mortes_covid.Rds")

# Respondendo perguntas --------

## Pergunta 1: -------
# Quantas mortes por Covid-19 no Brasil aparecem na nossa base
# de dados?

# NA são dados faltantes, informações que não sabemos!
# elas existem mas não temos acesso, então é importante considerar isso.


mortes_covid %>%
  count()  # faz uma contagem


## Pergunta 2: ---
# Morreram mais mulheres ou mais homens de Covid-19?

mortes_covid %>%
  count(cs_sexo) %>% # faz uma contagem por grupos
  arrange(desc(n)) # ordenar por alguma variável

## Pergunta 3: ---
# Quais estados têm o maior e o menor número de mortes,
# em números absolutos? E nas cidades?

# estados!
mortes_estados <- mortes_covid %>%
  count(sg_uf_not) %>% # faz uma contagem por grupos
  arrange(desc(n)) # ordenar por alguma variável

View(mortes_estados) # função View() é útil para visualizar
# os dados como tabela. mas NUNCA use com uma tabela
# muito grande, pois pode travar sua sessão do RStudio.

head(mortes_estados) # head é a função pra mostrar as primeiras
# linhas de uma base

tail(mortes_estados) # tail é a função pra mostrar as últimas
# linhas de uma base

# municipios

mortes_municipios <- mortes_covid %>%
  count(sg_uf_not, id_municip) %>% # faz uma contagem por grupos
  arrange(desc(n)) # ordenar por alguma variável

head(mortes_municipios) # head é a função pra mostrar as primeiras
# linhas de uma base

tail(mortes_municipios) # tail é a função pra mostrar as últimas
# linhas de uma base
