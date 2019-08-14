#! /usr/bin/env Rscript
# (1.1 Update source from git repository and)
# 1.2 clean up previous output
# 2. Build the project (HTML + PDF output)
# 3. Copy output to destination folder

#cat("1.1 Pulling from git repository\n")
# it2r::pull(credentials = git2r::cred_ssh_key())


cat("1.2 Removing previously build output\n")
if (fs::dir_exists("poisson-regression"))  fs::dir_delete("poisson-regression")

# Gitbook
cat("2.1 Rendering gitbook (HTML site)\n")
bookdown::render_book("index.Rmd", output_format = "bookdown::gitbook", envir = new.env())

# PDF
cat("2.2 Rendering PDF)\n")
bookdown::render_book("index.Rmd", output_format = "bookdown::pdf_book", envir = new.env())

