#' Índice de Volatilidade Eleitoral (Pedersen)
#'
#' Calcula o Índice de Volatilidade Eleitoral de Pedersen (1979), que mede
#' a variação agregada na distribuição de votos entre partidos de uma eleição
#' para a seguinte. Valores mais altos indicam maior instabilidade eleitoral.
#'
#' **Cargos válidos:** `"deputado_estadual"`, `"deputado_federal"`,
#' `"senador"`, `"governador"`, `"presidente"`, `"vereador"`, `"prefeito"`
#'
#' @inheritParams get_nepp
#' @param turno Inteiro: `1` (primeiro turno, padrão), `2` (segundo turno)
#'   ou `"all"` (ambos).
#'
#' @return `data.frame` com colunas `ano` e `volatilidade`.
#' @export
#'
#' @references
#' Pedersen, M. N. (1979). The Dynamics of European Party Systems: Changing
#' Patterns of Electoral Volatility. *European Journal of Political Research*, 7(1), 1–26.
#'
#' @examples
#' \dontrun{
#' # Volatilidade nas eleições para Câmara Federal, 1998-2022
#' get_volatilidade_eleitoral("deputado_federal", 1998, 2022)
#'
#' # Volatilidade nas eleições para Governador em SP
#' get_volatilidade_eleitoral("governador", 1994, 2022, uf = "SP")
#'
#' # Volatilidade nas eleições para Presidente (nacional)
#' get_volatilidade_eleitoral("presidente", 1994, 2022)
#' }
get_volatilidade_eleitoral <- function(cargo, ano_inicial, ano_final,
                                       uf = NULL, municipio = NULL, turno = 1) {
  pdc_validar_anos(ano_inicial, ano_final)
  cargo_id <- pdc_cargo_id(cargo)
  unidades <- pdc_resolver_unidades(cargo_id, uf, municipio)

  pdc_get(
    "noauth/indicadores/eleitorais/2",
    cargoId            = cargo_id,
    initialYear        = ano_inicial,
    finalYear          = ano_final,
    unidadesEleitorais = unidades,
    round              = turno
  )
}
