CRANLIKE_REPO <- Sys.getenv('CRANLIKE_REPO')

# Use MRAN to enforce the version-locking of these dependencies
# https://mran.microsoft.com/documents/rro/reproducibility
devtools::install_cran(c(
  'lubridate'
), repos=CRANLIKE_REPO)

# where necessary, install packages from github
# but use the github commit hash to version-lock them
# for a reproducible docker build
devtools::install_github('jbkunst/highcharter@ae311b16d620f382b7f45ddf6316ccab362c6794')

print('Successfully installed packages')
