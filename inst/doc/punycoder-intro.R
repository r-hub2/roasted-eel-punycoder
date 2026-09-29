## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----basic-usage, eval=FALSE--------------------------------------------------
# library(punycoder)
# 
# # Encode Unicode domains to ASCII
# puny_encode("café.com")
# # Returns: "xn--caf-dma.com"
# 
# puny_encode("москва.рф")
# # Returns: "xn--80adxhks.xn--p1ai"
# 
# # Decode ASCII domains back to Unicode
# puny_decode("xn--caf-dma.com")
# # Returns: "café.com"
# 
# # Vectorized operations
# domains <- c("café.com", "москва.рф", "北京.中国")
# encoded <- puny_encode(domains)
# print(encoded)

## ----validation, eval=FALSE---------------------------------------------------
# # Check if domain is already punycode
# is_punycode("xn--caf-dma.com") # TRUE
# is_punycode("café.com") # FALSE
# 
# # Check if domain contains Unicode characters
# is_idn("café.com") # TRUE
# is_idn("example.com") # FALSE
# 
# # Comprehensive domain validation
# result <- validate_domain(c("café.com", "invalid..domain", "valid.org"))
# print(result)

## ----normalize----------------------------------------------------------------
library(punycoder)

# Mapped, case-folded, validated, then encoded
host_normalize("Café.Example.COM")

# The codec transforms what it is given, and leaves case alone
puny_encode("Café.Example.COM")

## ----normalize-na-------------------------------------------------------------
host_normalize(c("valid.example", "example..com", "-bad-.example"))

## ----normalize-profile--------------------------------------------------------
normalization_profile_info()

## ----unicode-versions---------------------------------------------------------
unicode_versions()

## ----unicode-version-select---------------------------------------------------
host <- paste0(intToUtf8(0xA7CF), ".example")

host_normalize(host, unicode_version = "16.0.0")
host_normalize(host, unicode_version = "17.0.0")

## ----unicode-version-profile--------------------------------------------------
normalization_profile_info(unicode_version = "16.0.0")$profile

## ----bulk-processing, eval=FALSE----------------------------------------------
# # Example: Processing large datasets
# set.seed(123)
# sample_domains <- c(
#   rep("example.com", 1000),
#   rep("café.com", 1000),
#   rep("test.org", 1000)
# )
# 
# # Efficient vectorized encoding
# system.time({
#   encoded_domains <- puny_encode(sample_domains)
# })
# 
# # Check results
# table(is_punycode(encoded_domains))

## ----error-handling, eval=FALSE-----------------------------------------------
# # Strict validation (default)
# try({
#   puny_encode(c("valid.com", "")) # Empty string causes error
# })
# 
# # Non-strict mode returns NA for invalid input
# result <- puny_encode(c("valid.com", ""), strict = FALSE)
# print(result)
# 
# # Validation provides detailed error information
# validation <- validate_domain(c("valid.com", "invalid..domain", ""))
# print(validation)

## ----performance, eval=FALSE--------------------------------------------------
# # Benchmark with large dataset
# large_domains <- rep(c("example.com", "café.com"), 5000)
# 
# system.time({
#   encoded <- puny_encode(large_domains)
# })
# 
# # Should process 10,000+ domains per second

## ----options, eval=FALSE------------------------------------------------------
# # Set global strict validation
# options(punycoder.strict = FALSE)
# 
# # Check current setting
# getOption("punycoder.strict")
# 
# # Set encoding preference
# options(punycoder.encoding = "UTF-8")

## ----integration, eval=FALSE--------------------------------------------------
# # With data.table
# library(data.table)
# dt <- data.table(
#   original = c("café.com", "москва.рф"),
#   encoded = puny_encode(c("café.com", "москва.рф"))
# )
# 
# # With dplyr
# library(dplyr)
# domains_df <- data.frame(
#   unicode_domain = c("café.com", "москва.рф")
# ) |>
#   mutate(
#     ascii_domain = puny_encode(unicode_domain),
#     is_international = is_idn(unicode_domain)
#   )

