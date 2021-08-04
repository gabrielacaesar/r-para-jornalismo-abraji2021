
srag <- read_rds("docs/dados-output/srag.Rds")

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
  count(classi_fin, evolucao) %>% # faz uma contagem por grupos
  filter(evolucao == 2, classi_fin == 5) # filtrar valores de alguma variável


## Pergunta 2: ---
# Morreram mais mulheres ou mais homens de Covid-19?

srag %>%
  count(classi_fin, evolucao, cs_sexo) %>% # faz uma contagem por grupos
  filter(evolucao == 2, classi_fin == 5) %>%  # filtrar valores de alguma variável
  arrange(n) # ordenar por alguma variável

## Pergunta 3: ---
# Quais estados têm o maior e o menor número de mortes,
# em números absolutos? E nas cidades?

# estados!
mortes_estados <- srag %>%
  count(classi_fin, evolucao, sg_uf_not) %>% # faz uma contagem por grupos
  filter(evolucao == 2, classi_fin == 5) %>%  # filtrar valores de alguma variável
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
  count(classi_fin, evolucao, sg_uf_not, id_municip) %>% # faz uma contagem por grupos
  filter(evolucao == 2, classi_fin == 5) %>%  # filtrar valores de alguma variável
  arrange(desc(n)) # ordenar por alguma variável

head(mortes_municipios) # head é a função pra mostrar as primeiras
# linhas de uma base

tail(mortes_municipios) # tail é a função pra mostrar as últimas
# linhas de uma base

## Pergunta 4: ---
# E se considerarmos os dados dos estados por mês em 2021?
# Todos os estados tiveram um pico de mortes no mesmo mês?
