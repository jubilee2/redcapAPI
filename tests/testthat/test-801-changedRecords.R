context("changedRecords Functionality")

test_that(
  "Return an error when rcon is not a redcapConnection object", 
  {
    local_reproducible_output(width = 200)
    expect_error(
      changedRecords(rcon = "not an rcon"), 
      "no applicable method for 'exportLogging'"
    )
  }
)

test_that(
  "Returns records known to change in prior tests", 
  {
    recs <- as.character(1:20)
    x <- changedRecords(rcon, beginTime=as.POSIXct(Sys.time()-86400))
    
    expect_true(1 %in% x$created)
    expect_true(2 %in% x$created)
    expect_true(3 %in% x$created)
    expect_true(4 %in% x$created)
    expect_true(5 %in% x$created)
    expect_true(6 %in% x$created)
    expect_true(7 %in% x$created)
    expect_true(8 %in% x$created)
    expect_true(9 %in% x$created)
    expect_true(10 %in% x$created)
    expect_true(11 %in% x$created)
    expect_true(12 %in% x$created)
    expect_true(13 %in% x$created)
    expect_true(14 %in% x$created)
    expect_true(15 %in% x$created)
    expect_true(16 %in% x$created)
    expect_true(17 %in% x$created)
    expect_true(18 %in% x$created)
    expect_true(19 %in% x$created)
    expect_true(20 %in% x$created)

    expect_true(1 %in% x$updated)
    expect_true(2 %in% x$updated)
    expect_true(3 %in% x$updated)
    expect_true(4 %in% x$updated)
    expect_true(5 %in% x$updated)
    expect_true(6 %in% x$updated)
    expect_true(7 %in% x$updated)
    expect_true(8 %in% x$updated)
    expect_true(9 %in% x$updated)
    expect_true(10 %in% x$updated)
    expect_true(11 %in% x$updated)
    expect_true(12 %in% x$updated)
    expect_true(13 %in% x$updated)
    expect_true(14 %in% x$updated)
    expect_true(15 %in% x$updated)
    expect_true(16 %in% x$updated)
    expect_true(17 %in% x$updated)
    expect_true(18 %in% x$updated)
    expect_true(19 %in% x$updated)
    expect_true(20 %in% x$updated)

    expect_true(1 %in% x$deleted)
    expect_true(2 %in% x$deleted)
    expect_true(3 %in% x$deleted)
    expect_true(4 %in% x$deleted)
    expect_true(5 %in% x$deleted)
    expect_true(6 %in% x$deleted)
    expect_true(7 %in% x$deleted)
    expect_true(8 %in% x$deleted)
    expect_true(9 %in% x$deleted)
    expect_true(10 %in% x$deleted)
    expect_true(11 %in% x$deleted)
    expect_true(12 %in% x$deleted)
    expect_true(13 %in% x$deleted)
    expect_true(14 %in% x$deleted)
    expect_true(15 %in% x$deleted)
    expect_true(16 %in% x$deleted)
    expect_true(17 %in% x$deleted)
    expect_true(18 %in% x$deleted)
    expect_true(19 %in% x$deleted)
    expect_true(20 %in% x$deleted)
  }
)
