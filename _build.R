#! /usr/bin/env Rscript --no-init-file
# (1.1 Update source from git repository and)
# 1.2 clean up previous output
# 2. Build the project (HTML + PDF output)
# 3. Copy output to destination folder

# cat("1.1 Pulling from git repository\n")
# git2r::pull(credentials = git2r::cred_ssh_key())
library(cliapp)
start_app(theme = simple_theme(dark = TRUE))

t1 <- Sys.time()
cli_h1("{format(Sys.time(), '%b. %d, %T')}")

# Cleanup ----
cli_alert_info("Removing previously built output")
if (fs::dir_exists("poisson-regression"))  fs::dir_delete("poisson-regression")
if (fs::file_exists("poisson-regression.Rmd")) fs::file_delete("poisson-regression.Rmd")
if (fs::dir_exists("poisson-regression_files"))  fs::dir_delete("poisson-regression_files")

cli_h2("Rendering documents")
cli_div(id = "list", theme = list(ol = list("margin-left" = 1)))
cli_ol()

# Gitbook ----
cli_it("Rendering HTML site")
suppressWarnings(bookdown::render_book(
  "index.Rmd", output_format = "bookdown::gitbook", envir = new.env(), quiet = TRUE
)) -> tmp

# PDF ----
cli_it("Rendering PDF")
suppressWarnings(bookdown::render_book(
  "index.Rmd", output_format = "bookdown::pdf_book", envir = new.env(), quiet = TRUE
)) -> tmp

# EPUB ----
# cli_it("Rendering epub")
# bookdown::render_book(
#   "index.Rmd", output_format = "bookdown::epub_book", envir = new.env(), quiet = TRUE
# ) -> tmp

cli_end(id = "list")
cli_alert_success("Done rendering!")

# Copy things ----
if (all(Sys.info()[c("sysname", "login")] == c("Windows", "burk"))) {
  cli_h2("Copying to G:\\EVERYONE\\Burk...")
  fs::dir_copy("poisson-regression", "G:/EVERYONE/Burk/poisson-regression", overwrite = TRUE)
}

if (all(Sys.info()[c("sysname", "login")] == c("Darwin", "Lukas"))) {
  cli_h2("Copying to lukas.tadaa-data.de/poisson/")
  fs::dir_copy("poisson-regression", "~/Sync/lukas.tadaa-data.de/poisson/", overwrite = TRUE)
}

t2 <- Sys.time()
difft <- round(as.numeric(difftime(t2, t1, units = 'secs')), 1)

cli_alert_success("Done! Took {difft} seconds.")
cli_h1("{format(Sys.time(), '%b. %d, %T')}")
