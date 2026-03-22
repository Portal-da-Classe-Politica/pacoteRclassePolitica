#' Lista todos os indicadores disponíveis e seus cargos válidos
#'
#' Consulta o endpoint `/noauth/indicadores/discovery` e retorna um
#' `data.frame` com os indicadores, seus grupos e os cargos permitidos.
#' Útil para descobrir quais combinações de indicador + cargo são válidas
#' antes de fazer uma consulta.
#'
#' @return `data.frame` com colunas `id`, `nome`, `grupo`, `cargo_id`,
#'   `cargo_nome` e `filtros_requeridos`
#' @export
#' @examples
#' \dontrun{
#' pdc_discovery()
#' }
pdc_discovery <- function() {
  resp <- pdc_get_json("noauth/indicadores/discovery")

  if (!isTRUE(resp$success)) {
    stop("Erro ao consultar indicadores disponíveis.", call. = FALSE)
  }

  # Achata a lista aninhada (indicador -> cargos) em um data.frame plano
  resultado <- do.call(rbind, lapply(resp$data, function(ind) {
    if (length(ind$cargos) == 0) {
      return(data.frame(
        id               = ind$id,
        nome             = ind$nome,
        grupo            = ind$grupo,
        cargo_id         = NA_integer_,
        cargo_nome       = NA_character_,
        filtros_requeridos = NA_character_,
        stringsAsFactors = FALSE
      ))
    }

    do.call(rbind, lapply(ind$cargos, function(cargo) {
      filtros <- paste(cargo$filtros_requeridos %||% character(0), collapse = ", ")
      data.frame(
        id                 = ind$id,
        nome               = ind$nome,
        grupo              = ind$grupo,
        cargo_id           = cargo$id,
        cargo_nome         = cargo$nome,
        filtros_requeridos = filtros,
        stringsAsFactors   = FALSE
      )
    }))
  }))

  rownames(resultado) <- NULL
  resultado
}
