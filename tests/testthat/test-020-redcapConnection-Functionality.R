context("redcapConnection Functionality")

# Look for a yaml config for automated environments
config_file <- file.path("..", paste0(basename(getwd()),".yml"))

API_KEY <- "foobar123"
url     <- rcon$url   # Should not be required but it is

test_that("redcapApiConnection can be created",
          expect_class(
            redcapConnection(url = url, token = API_KEY),
            classes = c("redcapApiConnection", "redcapConnection")
          )
)
