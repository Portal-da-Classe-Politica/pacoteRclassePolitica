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
  # simplify = FALSE preserva a estrutura aninhada: lista de indicadores,
  # cada um com uma lista de cargos — sem colapsar para data.frame
  resp <- pdc_get_json("noauth/indicadores/discovery", simplify = FALSE)

  if (!isTRUE(resp$success)) {
    stop("Erro ao consultar indicadores disponíveis.", call. = FALSE)
  }

  # Achata a lista aninhada (indicador -> cargos) em um data.frame plano
  resultado <- do.call(rbind, lapply(resp$data, function(ind) {
    cargos <- ind$cargos

    if (is.null(cargos) || length(cargos) == 0) {
      return(data.frame(
        id                 = as.character(ind$id),
        nome               = as.character(ind$nome),
        grupo              = as.character(ind$grupo),
        cargo_id           = NA_integer_,
        cargo_nome         = NA_character_,
        filtros_requeridos = NA_character_,
        stringsAsFactors   = FALSE
      ))
    }

    do.call(rbind, lapply(cargos, function(cargo) {
      filtros <- paste(
        unlist(cargo$filtros_requeridos %||% list()),
        collapse = ", "
      )
      data.frame(
        id                 = as.character(ind$id),
        nome               = as.character(ind$nome),
        grupo              = as.character(ind$grupo),
        cargo_id           = as.integer(cargo$id),
        cargo_nome         = as.character(cargo$nome),
        filtros_requeridos = filtros,
        stringsAsFactors   = FALSE
      )
    }))
  }))

  rownames(resultado) <- NULL
  resultado
}
