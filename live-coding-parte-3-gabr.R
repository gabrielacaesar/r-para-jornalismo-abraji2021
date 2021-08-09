# instalar pacotes (se necessario)
#install.packages("tidyverse")
#install.packages("data.table")

# carregar pacotes
library(tidyverse)
library(data.table)

# importar o arquivo RDS
# ele está na pasta "dados-output"

mortes_covid <- readRDS("dados-output/mortes_covid.Rds")

## Pergunta 4: ---
# E se considerarmos os dados dos estados por mês em 2021?
# Todos os estados tiveram um pico de mortes no mesmo mês?

resposta_4 <- mortes_covid %>%
  mutate(dt_evoluca = case_when(dt_evoluca == "" ~ dt_encerra,
                                dt_evoluca != "" ~ dt_evoluca)) %>%
  separate(dt_evoluca, c("dia", "mes", "ano"), sep = "/") %>%
  select(-dt_encerra, -dia) %>%
  filter(ano == "2021" & !mes %in% c("07", "08")) %>%
  #unite(mes_ano, c("mes", "ano"), sep = "/") %>%
  group_by(mes, sg_uf_not) %>%
  summarise(n_mortes = n()) %>%
  arrange(desc(n_mortes)) %>%
  mutate(regiao = case_when(sg_uf_not %in% c("SP", "RJ", "ES", "MG") ~ "Sudeste",
                            sg_uf_not %in% c("RS", "SC", "PR") ~ "Sul",
                            sg_uf_not %in% c("GO", "DF", "MS", "MT") ~ "Centro-Oeste",
                            sg_uf_not %in% c("AM", "AP", "RO", "RR", "TO", "AC", "PA") ~ "Norte",
                            sg_uf_not %in% c("RN", "CE", "BA", "MA", "PB", "SE", "PI", "PE", "AL") ~ "Nordeste"))

resposta_4_reg <- resposta_4 %>%
  filter(regiao == "Norte")

resposta_4_reg %>%
  ggplot(aes(x = mes, y = n_mortes)) +
  geom_col() +
  facet_wrap(~sg_uf_not)

resposta_4_reg %>%
  ggplot(aes(x = mes, y = n_mortes, color = sg_uf_not)) +
  geom_point()

resposta_4_reg %>%
  ggplot(aes(x = mes, y = n_mortes, group = sg_uf_not, color = sg_uf_not)) +
  geom_line() +
  facet_wrap(~sg_uf_not)

# e considerando a populacao
# link: https://github.com/turicas/censo-ibge/blob/main/data/output/populacao-estimada-2020_2020-08-27.csv

pop_brasil <- fread("https://raw.githubusercontent.com/turicas/censo-ibge/main/data/output/populacao-estimada-2020_2020-08-27.csv")

pop_uf <- pop_brasil %>%
  group_by(state) %>%
  summarise(populacao = sum(estimated_population))

resposta_4_pop <- resposta_4 %>%
  left_join(pop_uf, by = c("sg_uf_not" = "state")) %>%
  mutate(taxa_100mil = (n_mortes / populacao) * 100000) %>%
  arrange(desc(taxa_100mil)) %>%
  filter(regiao == "Sul")

resposta_4_pop %>%
  ggplot(aes(x = mes, y = taxa_100mil, group = sg_uf_not, color = sg_uf_not)) +
  geom_line(position = "identity")

resposta_4_pop %>%
  ggplot(aes(x = mes, y = taxa_100mil, color = sg_uf_not)) +
  geom_point()

