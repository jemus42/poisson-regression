#! /usr/bin/env Rscript
# Build things

# Gitbook
bookdown::render_book("index.Rmd", output_format = "bookdown::gitbook")

# PDF
bookdown::render_book("index.Rmd", output_format = "bookdown::pdf_book")

