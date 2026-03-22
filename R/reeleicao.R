#' Taxa de Reeleição
#'
#' Calcula a Taxa de Reeleição (TR), que mede a proporção de candidatos
#' que tentaram a reeleição e foram bem-sucedidos. Fórmula:
#' `TR = Reeleitos / Total que tentou reeleição × 100`.
#'
#' **Cargos válidos:** `"deputado_estadual"`, `"deputado_federal"`,
#' `"senador"`, `"governador"`, `"vereador"`, `"prefeito"`
#'
#' @inheritParams get_nepp
#'
#' @return `data.frame` com colunas `ano` e `taxa_reeleicao`.
#' @export
#'
#' @examples
#' \dontrun{
#' # Taxa de reeleição de deputados federais, 1998-2022
#' get_taxa_reeleicao("deputado_federal", 1998, 2022)
#'
#' # Taxa de reeleição de prefeitos em São Paulo
#' get_taxa_reeleicao("prefeito", 2000, 2024, uf = "SP", municipio = "São Paulo")
#'
#' # Taxa de reeleição de vereadores brasileiros (filtrando por UF)
#' get_taxa_reeleicao("vereador", 2000, 2024, uf = "MG")
#' }
get_taxa_reeleicao <- function(cargo, ano_inicial, ano_final,
                               uf = NULL, municipio = NULL, turno = 1) {
  pdc_validar_anos(ano_inicial, ano_final)
  cargo_id <- pdc_cargo_id(cargo)
  unidades <- pdc_resolver_unidades(cargo_id, uf, municipio)

  pdc_get(
    "noauth/indicadores/partidarios/6",
    cargoId            = cargo_id,
    initialYear        = ano_inicial,
    finalYear          = ano_final,
    unidadesEleitorais = unidades,
    round              = turno
  )
}
