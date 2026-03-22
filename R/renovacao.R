#' Taxa de Renovação Líquida
#'
#' Calcula a Taxa de Renovação Líquida (TRL), que mede a proporção de
#' membros que tentaram a reeleição e foram derrotados em relação ao total
#' que tentou a reeleição. Fórmula: `TRL = D / (D + R) × 100`, onde
#' D = derrotados e R = reeleitos.
#'
#' **Cargos válidos:** `"deputado_estadual"`, `"deputado_federal"`,
#' `"senador"`, `"governador"`, `"vereador"`, `"prefeito"`
#'
#' @inheritParams get_nepp
#'
#' @return `data.frame` com colunas `ano` e `taxa_renovacao_liquida`.
#' @export
#'
#' @examples
#' \dontrun{
#' # Taxa de renovação na Câmara Federal, 1998-2022
#' get_taxa_renovacao("deputado_federal", 1998, 2022)
#'
#' # Taxa de renovação de vereadores no Rio de Janeiro
#' get_taxa_renovacao("vereador", 2000, 2024, uf = "RJ", municipio = "Rio de Janeiro")
#' }
get_taxa_renovacao <- function(cargo, ano_inicial, ano_final,
                               uf = NULL, municipio = NULL, turno = 1) {
  pdc_validar_anos(ano_inicial, ano_final)
  cargo_id <- pdc_cargo_id(cargo)
  unidades <- pdc_resolver_unidades(cargo_id, uf, municipio)

  pdc_get(
    "noauth/indicadores/partidarios/5",
    cargoId            = cargo_id,
    initialYear        = ano_inicial,
    finalYear          = ano_final,
    unidadesEleitorais = unidades,
    round              = turno
  )
}
