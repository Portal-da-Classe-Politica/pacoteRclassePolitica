#' Número Efetivo de Partidos (NEPP)
#'
#' Calcula o Número Efetivo de Partidos Parlamentares (Laakso & Taagepera, 1979)
#' para o cargo e período informados. O NEPP mede a fragmentação partidária na
#' casa legislativa ponderando o número de partidos pela proporção de assentos.
#'
#' **Cargos válidos:** `"deputado_estadual"`, `"deputado_federal"`,
#' `"senador"`, `"vereador"`
#'
#' @param cargo Label do cargo (ver [pdc_listar_cargos()]) ou ID inteiro.
#' @param ano_inicial Ano inicial do intervalo (ex: `1998`).
#' @param ano_final Ano final do intervalo (ex: `2022`).
#' @param uf Sigla da UF para filtrar (ex: `"SP"`). Obrigatório para
#'   `"deputado_estadual"` e `"deputado_federal"`. Para `"vereador"`, use
#'   em conjunto com `municipio`.
#' @param municipio Nome do município (apenas para `"vereador"`).
#' @param turno Inteiro: `1` (primeiro turno, padrão) ou `2` (segundo turno).
#'
#' @return `data.frame` com colunas `ano` e `nepp`.
#' @export
#'
#' @references
#' Laakso, M., & Taagepera, R. (1979). "Effective" Number of Parties:
#' A Measure with Application to West Europe. *Comparative Political Studies*, 12(1), 3–27.
#'
#' @examples
#' \dontrun{
#' # NEPP na Câmara dos Deputados, 1998-2022
#' get_nepp("deputado_federal", 1998, 2022)
#'
#' # NEPP nas Assembleias Estaduais de São Paulo
#' get_nepp("deputado_estadual", 1998, 2022, uf = "SP")
#'
#' # NEPP nas Câmaras Municipais de Belo Horizonte
#' get_nepp("vereador", 2000, 2024, uf = "MG", municipio = "Belo Horizonte")
#' }
get_nepp <- function(cargo, ano_inicial, ano_final,
                     uf = NULL, municipio = NULL, turno = 1) {
  pdc_validar_anos(ano_inicial, ano_final)
  cargo_id <- pdc_cargo_id(cargo)
  unidades <- pdc_resolver_unidades(cargo_id, uf, municipio)

  pdc_get(
    "noauth/indicadores/eleitorais/1",
    cargoId           = cargo_id,
    initialYear       = ano_inicial,
    finalYear         = ano_final,
    unidadesEleitorais = unidades,
    round             = turno
  )
}
