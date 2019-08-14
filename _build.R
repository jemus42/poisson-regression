#! /usr/bin/env Rscript
# 1. Update source from git repository and clean up previous output
# 2. Build the project (HTML + PDF output)
# 3. Copy output to destination folder

cat("1. Pulling from git repository\n")
git2r::pull()

cat("Removing previously build output\n")
if (fs::dir_exists("poisson-regression"))  fs::dir_delete("poisson-regression")


# Gitbook
cat("2.1 Rendering gitbook (HTML site)\n")
bookdown::render_book("index.Rmd", output_format = "bookdown::gitbook", envir = new.env())

# PDF
cat("2.2 Rendering PDF)\n")
bookdown::render_book("index.Rmd", output_format = "bookdown::pdf_book", envir = new.env())

