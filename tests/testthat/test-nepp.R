test_that("get_nepp retorna data.frame com colunas corretas", {
  with_mock_api(
    {
      result <- get_nepp("deputado_federal", 1998, 2022)
      expect_s3_class(result, "data.frame")
      expect_true("ano" %in% names(result))
      expect_true("nepp" %in% names(result))
      expect_true(nrow(result) > 0)
    }
  )
})

test_that("get_nepp valida cargo inválido", {
  expect_error(
    get_nepp("cargo_inexistente", 1998, 2022),
    regexp = "não reconhecido"
  )
})

test_that("get_nepp valida anos invertidos", {
  expect_error(
    get_nepp("deputado_federal", 2022, 1998),
    regexp = "menor ou igual"
  )
})

test_that("get_nepp aceita cargo como ID numérico", {
  with_mock_api(
    {
      result <- get_nepp(2L, 1998, 2022)
      expect_s3_class(result, "data.frame")
    }
  )
})

test_that("get_nepp repassa uf como unidadesEleitorais resolvido", {
  # Verifica que a função chama pdc_resolver_unidades sem erro para UF válida
  with_mock_api(
    {
      expect_no_error(get_nepp("deputado_estadual", 1998, 2022, uf = "SP"))
    }
  )
})
