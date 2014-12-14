if ("silent" %in% ls() && silent) {
  dog <- function (...) {}
} else {
  dog <- cat
}

delete <- dir(pattern = "\\.pdf$", recursive = TRUE, ignore.case = TRUE)
if (length(delete) > 0) {
  dog("Pobrisane bodo sledeče datoteke:\n", delete, "\n")
  if(readline("Nadaljujem? [da/NE]") == 'da') {
    success <- file.remove(delete)
    if (any(!success)) {
      dog("Sledeče datoteke so pobrisane:\n", delete[success], "\n")
      dog("Sledeče datoteke NISO pobrisane:\n", delete[!success], "\n")
    } else {
      dog("Datoteke so pobrisane.\n")
    }
  } else {
    dog("Datoteke niso pobrisane.\n")
  }
} else {
  dog("Ne najdem nobene datoteke PDF.\n")
}
dog("Brišem delovno okolje.\n")
rm(list = ls())
