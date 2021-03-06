test_that("An uninterrupted time series checks ok", {
  dat <- data.frame(station = 1234,
                    year = 2020,
                    month = c(rep(4, 30), rep(5, 31), rep(6, 30)),
                    day = c(1:30, 1:31, 1:30))

  check <- bom_db_check_datetimes(dat, daily = TRUE)[[1]]

  expect_true(check$ok)
  expect_null(check$err)
  expect_null(check$gaps)
})


test_that("Multi-station data produces the correct list structure", {
  stns <- 1001:1004

  dat <- data.frame(station = rep(stns, each = 10),
                    year = 2020,
                    month = 4,
                    day = rep(1:10, length(stns)))

  check <- bom_db_check_datetimes(dat, daily = TRUE)

  expect_length(check, length(stns))

  for (i in 1:4) expect_equal(check[[i]]$station, stns[i])
})


test_that("Presence of sub-daily data is checked properly", {
  dat <- data.frame(station = 1234,
                    year = 2020,
                    month = 4,
                    day = rep(1:10, each = 3),
                    hour = rep(c(9, 12, 15), 10))

  check <- bom_db_check_datetimes(dat, daily = TRUE)[[1]]
  expect_false(check$ok)

  check <- bom_db_check_datetimes(dat, daily = FALSE)[[1]]
  expect_true(check$ok)
})


test_that("Gaps in a time series are identified", {
  dat <- data.frame(station = 1234,
                    year = 2020,
                    month = rep(1:3, each = 10),
                    day = rep(11:20, 3))

  check <- bom_db_check_datetimes(dat, daily = TRUE)[[1]]

  expect_false(check$ok)
  expect_match(check$err, "[Gg]ap")
  expect_equal(check$gaps, c(as.Date("2020-02-11"), as.Date("2020-03-11")))
})


