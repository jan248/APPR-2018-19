delete <- dir(pattern = "\\.pdf$", recursive = TRUE, ignore.case = TRUE)
if (length(delete) > 0) {
  cat("Pobrisane bodo sledeče datoteke:\n", delete, "\n")
  if(readline("Nadaljujem? [da/NE]") == 'da') {
    success <- file.remove(delete)
    if (any(!success)) {
      cat("Sledeče datoteke so pobrisane:\n", delete[success], "\n")
      cat("Sledeče datoteke NISO pobrisane:\n", delete[!success], "\n")
    } else {
      cat("Datoteke so pobrisane.\n")
    }
  } else {
    cat("Datoteke niso pobrisane.\n")
  }
} else {
  cat("Ne najdem nobene datoteke PDF.\n")
}
cat("Brišem delovno okolje.\n")
rm(list = ls())