# pacoteRclassePolitica

Acesso programático aos indicadores políticos e eleitorais do **Portal da Classe Política** (INCT ReDem) diretamente no R.

## Instalação

```r
# Via r-universe (recomendado)
install.packages("pacoteRclassePolitica", repos = c(
  "https://portal-da-classe-politica.r-universe.dev",
  "https://cloud.r-project.org"
))

# Ou diretamente do GitHub
remotes::install_github("Portal-da-Classe-Politica/pacoteRclassePolitica")
```

## Indicadores disponíveis

| Função | Indicador | `indicator_id` |
|---|---|:---:|
| `get_nepp()` | Número Efetivo de Partidos (Laakso & Taagepera) | 1 |
| `get_volatilidade_eleitoral()` | Índice de Volatilidade Eleitoral (Pedersen) | 2 |
| `get_taxa_renovacao()` | Taxa de Renovação Líquida | 5 |
| `get_taxa_reeleicao()` | Taxa de Reeleição | 6 |
| `get_desigualdade_recursos()` | Índice de Desigualdade de Acesso a Recursos | 14 |
| `get_concentracao_patrimonio()` | Índice de Concentração de Patrimônio | 15 |

## Uso rápido

```r
library(pacoteRclassePolitica)

# NEPP na Câmara dos Deputados, 1998-2022
get_nepp("deputado_federal", 1998, 2022)

# Concentração de patrimônio de vereadores brasileiros, 2000-2024
get_concentracao_patrimonio("vereador", 2000, 2024)

# Taxa de reeleição de prefeitos em MG
get_taxa_reeleicao("prefeito", 2000, 2024, uf = "MG")

# Volatilidade com filtro de município
get_volatilidade_eleitoral("vereador", 2000, 2024, uf = "SP", municipio = "Campinas")

# Listar cargos disponíveis
pdc_listar_cargos()

# Descobrir todos os indicadores e cargos válidos
pdc_discovery()
```

## Configuração da URL da API

```r
# Ambiente de desenvolvimento local
options(portalclasse.api_url = "http://redem.c3sl.ufpr.br/v1/api/")

# Ou via variável de ambiente no .Renviron:
# PORTALCLASSE_API_URL=http://redem.c3sl.ufpr.br/v1/api/
```

## Fonte

Portal da Classe Política — INCT ReDem (2025). Disponível em: <https://redem.c3sl.ufpr.br/>
