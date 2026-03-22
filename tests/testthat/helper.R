# Helpers compartilhados pelos testes
# Carregado automaticamente pelo testthat antes de cada arquivo de teste

library(pacoteRclassePolitica)
library(httptest2)

# Resposta CSV simulada para o NEPP (indicator_id = 1)
mock_nepp_csv <- "ano;nepp\n1998;8.45\n2002;9.32\n2006;10.07\n2010;10.36\n2014;13.18\n2018;16.45\n2022;13.97\n"

# Resposta CSV simulada para volatilidade (indicator_id = 2)
mock_volatilidade_csv <- "ano;volatilidade\n2002;21.34\n2006;14.22\n2010;12.45\n2014;18.90\n2018;34.21\n2022;22.10\n"

# Resposta CSV simulada para renovação (indicator_id = 5)
mock_renovacao_csv <- "ano;taxa_renovacao_liquida\n1998;48.2\n2002;60.1\n2006;55.3\n2010;51.8\n2014;53.0\n2018;62.4\n2022;56.7\n"

# Resposta CSV simulada para reeleição (indicator_id = 6)
mock_reeleicao_csv <- "ano;taxa_reeleicao\n1998;51.8\n2002;39.9\n2006;44.7\n2010;48.2\n2014;47.0\n2018;37.6\n2022;43.3\n"

# Resposta CSV simulada para IDAR (indicator_id = 14)
mock_recursos_csv <- "ano;IDAR\n2006;0.72\n2010;0.68\n2014;0.75\n2018;0.79\n2022;0.71\n"

# Resposta CSV simulada para concentração de patrimônio (indicator_id = 15)
mock_patrimonio_csv <- "ano_eleicao;indice_concentracao_patrimonio\n2000;0.81\n2004;0.79\n2008;0.82\n2012;0.85\n2016;0.83\n2020;0.87\n2024;0.88\n"

# Resposta JSON simulada para discovery
mock_discovery_json <- list(
  success = TRUE,
  data = list(
    list(
      id = "1", nome = "Número Efetivo de Partidos (Legislativo)",
      grupo = "eleitoral",
      cargos = list(
        list(id = 2L, nome = "DEPUTADO FEDERAL", abrangencia = 1L,
             filtros_requeridos = list("UF"))
      )
    )
  ),
  message = "Indicadores e cargos disponíveis"
)

# Resposta JSON simulada para unidades eleitorais
mock_unidades_json <- list(
  success = TRUE,
  data = data.frame(
    id = c(1L, 2L, 3L),
    nome = c("SAO PAULO", "CAMPINAS", "GUARULHOS"),
    sigla_unidade_federacao = c("SP", "SP", "SP"),
    stringsAsFactors = FALSE
  ),
  message = "Unidades eleitorais encontradas."
)
