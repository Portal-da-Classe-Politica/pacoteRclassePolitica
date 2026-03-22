test_that("get_volatilidade_eleitoral retorna data.frame com colunas corretas", {
  with_mock_api(
    {
      result <- get_volatilidade_eleitoral("deputado_federal", 1998, 2022)
      expect_s3_class(result, "data.frame")
      expect_true("ano" %in% names(result))
      expect_true("volatilidade" %in% names(result))
      expect_true(nrow(result) > 0)
    }
  )
})

test_that("get_taxa_renovacao retorna data.frame com colunas corretas", {
  with_mock_api(
    {
      result <- get_taxa_renovacao("deputado_federal", 1998, 2022)
      expect_s3_class(result, "data.frame")
      expect_true("ano" %in% names(result))
      expect_true("taxa_renovacao_liquida" %in% names(result))
    }
  )
})

test_that("get_taxa_reeleicao retorna data.frame com colunas corretas", {
  with_mock_api(
    {
      result <- get_taxa_reeleicao("deputado_federal", 1998, 2022)
      expect_s3_class(result, "data.frame")
      expect_true("ano" %in% names(result))
      expect_true("taxa_reeleicao" %in% names(result))
    }
  )
})

test_that("get_desigualdade_recursos retorna data.frame com colunas corretas", {
  with_mock_api(
    {
      result <- get_desigualdade_recursos("deputado_federal", 2006, 2022)
      expect_s3_class(result, "data.frame")
      expect_true("ano" %in% names(result))
      expect_true("IDAR" %in% names(result))
    }
  )
})

test_that("get_concentracao_patrimonio retorna data.frame com colunas corretas", {
  with_mock_api(
    {
      result <- get_concentracao_patrimonio("vereador", 2000, 2024, uf = "SP")
      expect_s3_class(result, "data.frame")
      expect_true("ano_eleicao" %in% names(result))
      expect_true("indice_concentracao_patrimonio" %in% names(result))
    }
  )
})
