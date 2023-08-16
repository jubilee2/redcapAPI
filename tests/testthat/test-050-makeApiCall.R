context("makeApiCall Argument Validation")

# Note: This file will only test that arguments fail appropriately, or
# that submethods perform as expected. the makeApiCall function 
# is ubiquitous throughout the package. If we break it, it's bound
# to pop up in other tests.

# Test .makeApiCall_validateResponse

test_that(
  ".makeApiCall_isRetryEligible returns appropriate logical values", 
  {
    response <- makeApiCall(rcon, 
                            body = list(content = "metadata", 
                                        format = "csv"))
    
    # list of codes from   https://developer.mozilla.org/en-US/docs/Web/HTTP/Status
    all_codes <- c(100, 101, 102, 103, 
                   200, 201, 202, 203, 304, 205, 206, 207, 208, 226, 
                   300, 301, 302, 303, 304, 305, 306, 307, 308, 
                   400, 401, 402, 403, 404, 405, 406, 407, 408, 409, 410, 411, 412, 413, 414, 415, 
                   416, 417, 418, 421, 422, 423, 424, 425, 426, 428, 429, 431, 451, 
                   500, 501, 502, 503, 504, 505, 506, 507, 508, 510, 511)
    
    eligible_codes <- c(408, 500, 502, 503, 504)
    
    ideal <- all_codes %in% eligible_codes
    
    actual <- rep(FALSE, length(all_codes))
    
    for (i in seq_along(all_codes)){
      response$status_code <- all_codes[i]
      actual[i] <- .makeApiCall_isRetryEligible(response)
    }
    
    expect_equal(ideal, actual)
  }
)

test_that(
  ".makeApiCall_retryMessage gives appropriate messages", 
  {
    response <- makeApiCall(rcon, 
                            body = list(content = "invalid-content", 
                                        format = "csv"))
    
    expect_message(.makeApiCall_retryMessage(rcon, response, 1), 
                   "API attempt 1 of 5 failed. Trying again in 2 seconds. ERROR: The value of the parameter \"content\" is not valid")
    
    expect_message(.makeApiCall_retryMessage(rcon, response, rcon$retries()), 
                   sprintf("API attempt %s of %s failed. ERROR: The value of the parameter \"content\" is not valid", 
                           rcon$retries(), rcon$retries()))
  }
)

test_that(
  "Return custom error message when reset by peer (Issue 181)", 
  {
    response <- makeApiCall(rcon, 
                            body = list(content = "arm", 
                                        format = "csv", 
                                        returnFormat = "csv"))
    response$status_code <- 502
    response$content <- charToRaw("Recv failure: Connection reset by peer")
    
    expect_error(redcapError(response, "null"), 
                 "A network error has occurred. This can happen when too much data is")
  
    
    response$content <- charToRaw("Timeout was reached: [redcap.vanderbilt.edu] SSL connection timeout")
    
    expect_error(redcapError(response, "null"), 
                 "A network error has occurred. This can happen when too much data is")
    
  }
)

#####################################################################
# Argument Validation

test_that(
  "Return an error if rcon is not of class redcapApiConnection", 
  {
    local_reproducible_output(width = 200)
    expect_error(makeApiCall(mtcars), 
                 "'rcon': Must inherit from class 'redcapApiConnection'")
  }
)

test_that(
  "Return an error if body is not a named list", 
  {
    local_reproducible_output(width = 200)
    expect_error(makeApiCall(rcon, 
                             letters), 
                 "'body': Must be of type 'list'")
    
    expect_error(makeApiCall(rcon, 
                             list(1, 2, 3)), 
                 "'body': Must have names")
  }
)

test_that(
  "Return an error if config is not a named list", 
  {
    local_reproducible_output(width = 200)
    expect_error(makeApiCall(rcon, 
                             config = letters), 
                 "'config': Must be of type 'list'")
    
    expect_error(makeApiCall(rcon, 
                             config = list(1, 2, 3)), 
                 "'config': Must have names")
  }
)