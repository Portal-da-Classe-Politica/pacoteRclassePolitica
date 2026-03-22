# Funções de resolução de filtros geográficos

#' Resolve UF e/ou município para IDs de unidade eleitoral da API
#'
#' Chama `GET /noauth/electoral-unit?abrangencyId=&UF=` e retorna os IDs
#' como string separada por vírgulas, pronta para passar à API de indicadores.
#'
#' Para cargos de abrangência estadual/federal (deputado, senador, governador,
#' presidente), basta informar a UF. Para cargos municipais (vereador, prefeito),
#' a UF é obrigatória e o municipio é opcional (filtra por nome parcial).
#'
#' @param cargo_id ID inteiro do cargo
#' @param uf Sigla da UF (ex: `"SP"`). NULL para cargos nacionais.
#' @param municipio Nome ou parte do nome do município. NULL para todos da UF.
#' @return String com IDs separados por vírgula, ou NULL se nenhum filtro informado
#' @keywords internal
pdc_resolver_unidades <- function(cargo_id, uf, municipio) {
  if (is.null(uf) && is.null(municipio)) return(NULL)

  abrangencia <- pdc_cargo_abrangencia(cargo_id)

  if (abrangencia == 2 && is.null(uf)) {
    stop(
      "Para cargos municipais (vereador, prefeito), o argumento 'uf' é obrigatório.",
      call. = FALSE
    )
  }

  resp <- pdc_get_json(
    "noauth/electoral-unit",
    abrangencyId = abrangencia,
    UF = if (!is.null(uf)) toupper(trimws(uf)) else NULL
  )

  if (!isTRUE(resp$success) || length(resp$data) == 0) {
    stop(
      sprintf(
        "Nenhuma unidade eleitoral encontrada para UF='%s'.",
        uf %||% ""
      ),
      call. = FALSE
    )
  }

  unidades <- resp$data

  # Filtro adicional por nome de município (busca parcial, case-insensitive)
  if (!is.null(municipio) && is.data.frame(unidades) && "nome" %in% names(unidades)) {
    pattern <- tolower(trimws(municipio))
    unidades <- unidades[grepl(pattern, tolower(unidades$nome), fixed = TRUE), ]

    if (nrow(unidades) == 0) {
      stop(
        sprintf(
          "Município '%s' não encontrado na UF '%s'. Verifique a grafia.",
          municipio, uf
        ),
        call. = FALSE
      )
    }
  }

  # Retorna IDs como string separada por vírgula
  ids <- if (is.data.frame(unidades)) unidades$id else unidades
  paste(ids, collapse = ",")
}

#' Valida e formata o intervalo de anos
#' @keywords internal
pdc_validar_anos <- function(ano_inicial, ano_final) {
  if (!is.numeric(ano_inicial) || !is.numeric(ano_final)) {
    stop("'ano_inicial' e 'ano_final' devem ser numéricos.", call. = FALSE)
  }
  if (ano_inicial > ano_final) {
    stop("'ano_inicial' deve ser menor ou igual a 'ano_final'.", call. = FALSE)
  }
  if (ano_inicial < 1994 || ano_final > 2030) {
    warning("Intervalo de anos fora do esperado (1994-2030). Verifique os valores.")
  }
  invisible(TRUE)
}
