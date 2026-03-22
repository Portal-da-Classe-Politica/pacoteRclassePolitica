# Funções internas de comunicação com a API do Portal da Classe Política

#' Retorna a URL base da API
#'
#' A URL é lida, em ordem de prioridade, de:
#' 1. `options("portalclasse.api_url")`
#' 2. Variável de ambiente `PORTALCLASSE_API_URL`
#' 3. URL padrão de produção
#'
#' @keywords internal
pdc_api_url <- function() {
  getOption(
    "pacoteRclassePolitica.api_url",
    default = Sys.getenv(
      "PACOTECLASSEPOLITICA_API_URL",
      unset = "http://redem.c3sl.ufpr.br/v1/api/"
    )
  )
}

#' Operador de coalescência nula
#' @keywords internal
`%||%` <- function(x, y) if (!is.null(x) && length(x) > 0) x else y

#' Realiza uma requisição GET à API e retorna um data.frame
#'
#' Adiciona automaticamente `exportcsv=true` para obter dados tabulares.
#' Remove o rodapé de fonte inserido pela API antes de parsear o CSV.
#'
#' @param path Caminho relativo da API (ex: `"noauth/indicadores/eleitorais/1"`)
#' @param ... Parâmetros de query string (valores NULL são ignorados)
#' @return `data.frame` com os dados retornados
#' @keywords internal
pdc_get <- function(path, ...) {
  params <- list(...)
  params <- Filter(Negate(is.null), params)

  req <- httr2::request(pdc_api_url()) |>
    httr2::req_url_path_append(path) |>
    httr2::req_error(is_error = function(resp) FALSE)

  req <- do.call(
    httr2::req_url_query,
    c(list(req), params, list(exportcsv = "true"))
  )

  resp <- httr2::req_perform(req)
  status <- httr2::resp_status(resp)

  if (status != 200) {
    body <- tryCatch(
      httr2::resp_body_json(resp),
      error = function(e) list(message = paste("Erro HTTP", status))
    )
    stop(body$message %||% paste("Erro na API:", status), call. = FALSE)
  }

  csv_text <- httr2::resp_body_string(resp)

  # Remove o rodapé "Fonte: ..." que a API anexa ao CSV
  csv_text <- sub("\nFonte:.*$", "", csv_text)

  readr::read_csv2(csv_text, show_col_types = FALSE)
}

#' Realiza uma requisição GET à API e retorna JSON como lista R
#' @param simplify Se TRUE (padrão), simplifica vetores JSON para vetores R.
#'   Use FALSE para preservar a estrutura aninhada completa.
#' @keywords internal
pdc_get_json <- function(path, ..., simplify = TRUE) {
  params <- list(...)
  params <- Filter(Negate(is.null), params)

  req <- httr2::request(pdc_api_url()) |>
    httr2::req_url_path_append(path) |>
    httr2::req_error(is_error = function(resp) FALSE)

  if (length(params) > 0) {
    req <- do.call(httr2::req_url_query, c(list(req), params))
  }

  resp <- httr2::req_perform(req)
  status <- httr2::resp_status(resp)

  if (status != 200) {
    stop(paste("Erro na API:", status), call. = FALSE)
  }

  httr2::resp_body_json(resp, simplifyVector = simplify)
}
