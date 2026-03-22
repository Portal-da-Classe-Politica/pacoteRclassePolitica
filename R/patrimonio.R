#' Índice de Concentração de Patrimônio
#'
#' Calcula o Índice de Diversidade Econômica entre Candidatos (IDEC), que
#' mede o grau de concentração de bens e patrimônio declarados entre os
#' candidatos ao cargo. Baseado no coeficiente de Gini aplicado sobre os
#' patrimônios declarados. Valores próximos de 0 indicam patrimônios
#' distribuídos uniformemente; valores próximos de 1 indicam alta
#' concentração de riqueza em poucos candidatos.
#'
#' **Cargos válidos:** `"deputado_estadual"`, `"deputado_federal"`,
#' `"senador"`, `"governador"`, `"presidente"`, `"vereador"`, `"prefeito"`
#'
#' @inheritParams get_nepp
#'
#' @return `data.frame` com colunas `ano_eleicao` e `indice_concentracao_patrimonio`.
#' @export
#'
#' @examples
#' \dontrun{
#' # Concentração de patrimônio de vereadores brasileiros, 2000-2024
#' get_concentracao_patrimonio("vereador", 2000, 2024)
#'
#' # Concentração de patrimônio de vereadores de SP
#' get_concentracao_patrimonio("vereador", 2000, 2024, uf = "SP")
#'
#' # Concentração de patrimônio de deputados federais, 1998-2022
#' get_concentracao_patrimonio("deputado_federal", 1998, 2022)
#' }
get_concentracao_patrimonio <- function(cargo, ano_inicial, ano_final,
                                        uf = NULL, municipio = NULL, turno = 1) {
  pdc_validar_anos(ano_inicial, ano_final)
  cargo_id <- pdc_cargo_id(cargo)
  unidades <- pdc_resolver_unidades(cargo_id, uf, municipio)

  pdc_get(
    "noauth/indicadores/financeiros/15",
    cargoId            = cargo_id,
    initialYear        = ano_inicial,
    finalYear          = ano_final,
    unidadesEleitorais = unidades,
    round              = turno
  )
}
