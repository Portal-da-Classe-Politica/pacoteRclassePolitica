test_that("pdc_cargo_id converte label para id corretamente", {
  expect_equal(pdc_cargo_id("deputado_federal"), 2L)
  expect_equal(pdc_cargo_id("vereador"), 11L)
  expect_equal(pdc_cargo_id("presidente"), 9L)
})

test_that("pdc_cargo_id aceita ID numérico diretamente", {
  expect_equal(pdc_cargo_id(2), 2L)
  expect_equal(pdc_cargo_id(11L), 11L)
})

test_that("pdc_cargo_id é case-insensitive", {
  expect_equal(pdc_cargo_id("Deputado_Federal"), 2L)
  expect_equal(pdc_cargo_id("VEREADOR"), 11L)
})

test_that("pdc_cargo_id lança erro para cargo desconhecido", {
  expect_error(pdc_cargo_id("parlamentar"), "não reconhecido")
  expect_error(pdc_cargo_id(""), "não reconhecido")
})

test_that("pdc_listar_cargos retorna data.frame com 7 linhas", {
  cargos <- pdc_listar_cargos()
  expect_s3_class(cargos, "data.frame")
  expect_equal(nrow(cargos), 7L)
  expect_true(all(c("label", "id", "abrangencia") %in% names(cargos)))
})

test_that("pdc_validar_anos lança erro para anos invertidos", {
  expect_error(pdc_validar_anos(2022, 1998), "menor ou igual")
})

test_that("pdc_validar_anos lança erro para tipos não numéricos", {
  expect_error(pdc_validar_anos("1998", 2022), "numéricos")
})

test_that("pdc_validar_anos avisa para anos fora do esperado", {
  expect_warning(pdc_validar_anos(1900, 1950), "fora do esperado")
})

test_that("pdc_discovery retorna data.frame com colunas esperadas", {
  with_mock_api(
    {
      result <- pdc_discovery()
      expect_s3_class(result, "data.frame")
      expect_true(all(c("id", "nome", "grupo", "cargo_id", "cargo_nome") %in% names(result)))
    }
  )
})
