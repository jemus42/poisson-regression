#! /usr/bin/env Rscript
# (1.1 Update source from git repository and)
# 1.2 clean up previous output
# 2. Build the project (HTML + PDF output)
# 3. Copy output to destination folder

# cat("1.1 Pulling from git repository\n")
# git2r::pull(credentials = git2r::cred_ssh_key())
library(cliapp)

timestamp()

cli_h2("1.2 Removing previously built output")
if (fs::dir_exists("poisson-regression"))  fs::dir_delete("poisson-regression")
if (fs::file_exists("poisson-regression.Rmd")) fs::file_delete("poisson-regression.Rmd")
if (fs::dir_exists("poisson-regression_files"))  fs::dir_delete("poisson-regression_files")

# Gitbook
cli_h2("2.1 Rendering HTML site")
bookdown::render_book(
  "index.Rmd", output_format = "bookdown::gitbook", envir = new.env(), quiet = TRUE
)

# PDF
cli_h2("2.2 Rendering PDF")
bookdown::render_book(
  "index.Rmd", output_format = "bookdown::pdf_book", envir = new.env(), quiet = TRUE
)

cli_alert_success("Done rendering!")

if (all(Sys.info()[c("sysname", "login")] == c("Windows", "burk"))) {
  cli_h2("Copying to G:\\EVERYONE\\Burk...")
  fs::dir_copy("poisson-regression", "G:/EVERYONE/Burk/poisson-regression", overwrite = TRUE)
}

if (all(Sys.info()[c("sysname", "login")] == c("Darwin", "Lukas"))) {
  cli_h2("Copying to lukas.tadaa-data.de/poisson/")
  fs::dir_copy("poisson-regression", "~/Sync/lukas.tadaa-data.de/poisson/", overwrite = TRUE)
}

cli_alert_success("Done!")
timestamp()
