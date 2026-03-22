#' Índice de Desigualdade de Acesso a Recursos
#'
#' Calcula o Índice de Desigualdade no Acesso a Recursos (IDAR), baseado no
#' coeficiente de Gini aplicado à distribuição de recursos financeiros de
#' campanha entre candidatos ao mesmo cargo. Valores próximos de 0 indicam
#' distribuição equilibrada; valores próximos de 1 indicam alta concentração
#' financeira em poucos candidatos.
#'
#' **Cargos válidos:** `"deputado_estadual"`, `"deputado_federal"`,
#' `"senador"`, `"governador"`, `"presidente"`, `"vereador"`, `"prefeito"`
#'
#' @inheritParams get_nepp
#'
#' @return `data.frame` com colunas `ano` e `IDAR`.
#' @export
#'
#' @examples
#' \dontrun{
#' # Desigualdade de acesso a recursos na Câmara Federal, 2006-2022
#' get_desigualdade_recursos("deputado_federal", 2006, 2022)
#'
#' # Desigualdade de financiamento para vereadores em SP
#' get_desigualdade_recursos("vereador", 2008, 2024, uf = "SP")
#' }
get_desigualdade_recursos <- function(cargo, ano_inicial, ano_final,
                                      uf = NULL, municipio = NULL, turno = 1) {
  pdc_validar_anos(ano_inicial, ano_final)
  cargo_id <- pdc_cargo_id(cargo)
  unidades <- pdc_resolver_unidades(cargo_id, uf, municipio)

  pdc_get(
    "noauth/indicadores/financeiros/14",
    cargoId            = cargo_id,
    initialYear        = ano_inicial,
    finalYear          = ano_final,
    unidadesEleitorais = unidades,
    round              = turno
  )
}
