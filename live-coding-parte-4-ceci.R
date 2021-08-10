



library(tidyverse) # este pacote oferece uma GRANDE quantidade
# de ferramentas para análise de dados!
library(janitor) # limpeza de dados
library(data.table) # funções para lidar com bases de dados GRANDES
library(lubridate) # funções para lidar com datas

# Importando a base filtrada
mortes_covid <- read_rds("dados-output/mortes_covid.Rds")

# Respondendo perguntas do nosso editor

# Nosso editor é um jornalista cheio de perguntas.
# Ele quer saber mais coisas sobre a pandemia de covid

# Ele mandou um repórter para Manaus contar histórias de pessoas que perderam parentes.
# O repórter conseguiu algumas informações com os hospitais locais.
# Mas ele precisa descobrir quanto tempo as pessoas ficam no hospital,
# e se temos um caso excepcionalmente longo para o repórter procurar a família


# ****PERGUNTA****
# Em quantidade de dias, quanto tempo as pessoas ficaram na UTI?

resposta_1 <- mortes_covid %>% #pegamos nossa base de dados
  mutate(dias_uti_morte = #criamos uma nova coluna para fazer um cálculo
           dmy(dt_evoluca)-dmy(dt_entuti)) %>% #Subtraímos uma data pela outra,
  #usando o lubridate para colocá-las num formato de data passível de cálculo
  group_by(dias_uti_morte) %>% #agrupamos pelo número de dias na UTI
  summarise(n_casos = n()) %>% # e fazemos uma contagem de mortes relacionadas
  arrange(dias_uti_morte) # ordenamos pelos dias passados em UTI

# Percebemos aqui que há alguns casos de mortes com muitos dias desde
# a entrada na UTI. Vamos repetir a pergunta à base, filtrando por Manaus
# para ajudar a reportagem local.
# ****PERGUNTA****
# E em Manaus?

resposta_2 <- mortes_covid %>%
  filter(id_municip == "MANAUS") %>% #Só as mortes em Manaus/AM
  mutate(dias_uti_morte = dmy(dt_evoluca)-dmy(dt_entuti)) %>%
  group_by(dias_uti_morte) %>%
  summarise(n_casos = n()) %>%
  arrange(dias_uti_morte)

# Há uma morte que ocorreu 159 dias depois da entrada na UTI.
# Passamos essa informação ao repórter que tentará localizar o caso e vai
# descobrir se é uma pessoa que passou todo esse tempo na UTI ou se saiu e voltou.

# Nossa resposta empolgou nosso editor a fazer mais perguntas
# Jornalismo é como uma hydra. Quando se mata uma cabeça surgem duas.
# ****PERGUNTA****
# Qual o tempo médio de tempo que a pessoa fica na UTI por idade?

resposta_3 <- mortes_covid %>%
  mutate(dias_uti_morte = as.numeric(dmy(dt_evoluca)-dmy(dt_entuti)),
         idade = round(as.numeric(today()-dmy(dt_nasc))/365)) %>%
  #determinamos a idade
  group_by(idade) %>%
  summarise(mediana_uti = median(dias_uti_morte, na.rm = TRUE)) %>%
  # determinamos a mediana dentro dos grupos por idade
  arrange(idade)

# ****PERGUNTA****
# Nosso editor quer saber se a covid distorceu a média de tempo na UTI para os homens

resposta_4 <- mortes_covid %>%
  mutate(dias_uti_morte = as.numeric(dmy(dt_evoluca)-dmy(dt_entuti))) %>%
  group_by(ano = year(dmy(dt_evoluca)), cs_sexo) %>%
  summarise(mediana_uti = median(dias_uti_morte, na.rm = TRUE)) %>%
  arrange(ano)

# Não houve aumento no tempo de UTI pelo gênero, mas houve aumento para ambos os sexos em 2021.

