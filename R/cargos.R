# Tabela de cargos e funções auxiliares de lookup

#' Tabela de cargos disponíveis
#'
#' @format data.frame com colunas:
#' \describe{
#'   \item{label}{Nome do cargo para uso nas funções do pacote}
#'   \item{id}{ID interno do cargo na API}
#'   \item{abrangencia}{Nível de abrangência: 1 = estadual/federal, 2 = municipal}
#'   \item{segundo_turno}{Logical — cargo possui segundo turno}
#' }
#' @export
pdc_cargos <- data.frame(
  label = c(
    "deputado_estadual",
    "deputado_federal",
    "senador",
    "governador",
    "presidente",
    "vereador",
    "prefeito"
  ),
  id = c(1L, 2L, 4L, 8L, 9L, 11L, 12L),
  abrangencia = c(1L, 1L, 1L, 1L, 1L, 2L, 2L),
  segundo_turno = c(FALSE, FALSE, FALSE, TRUE, TRUE, FALSE, TRUE),
  stringsAsFactors = FALSE
)

#' Lista os cargos disponíveis
#'
#' Exibe a tabela de cargos aceitos pelas funções de indicadores.
#'
#' @return `data.frame` com colunas `label`, `id`, `abrangencia` e `segundo_turno`
#' @export
#' @examples
#' pdc_listar_cargos()
pdc_listar_cargos <- function() {
  pdc_cargos
}

#' Converte label ou ID de cargo para o ID interno da API
#' @param cargo String com o label do cargo (ex: `"deputado_federal"`) ou inteiro com o ID
#' @return Inteiro com o ID do cargo
#' @keywords internal
pdc_cargo_id <- function(cargo) {
  if (is.numeric(cargo) || is.integer(cargo)) return(as.integer(cargo))

  match_row <- pdc_cargos[pdc_cargos$label == tolower(trimws(cargo)), ]

  if (nrow(match_row) == 0) {
    stop(
      sprintf(
        "Cargo '%s' não reconhecido. Use pdc_listar_cargos() para ver as opções.",
        cargo
      ),
      call. = FALSE
    )
  }

  match_row$id
}

#' Retorna a abrangência de um cargo pelo seu ID
#' @keywords internal
pdc_cargo_abrangencia <- function(cargo_id) {
  pdc_cargos[pdc_cargos$id == as.integer(cargo_id), "abrangencia"]
}
