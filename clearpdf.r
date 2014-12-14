if ("silent" %in% ls() && silent) {
  fish <- function (...) {}
} else {
  fish <- cat
}
if ("noask" %in% ls() && noask) {
  dog <- fish
} else {
  dog <- cat
  noask <- FALSE
}

delete <- dir(pattern = "\\.pdf$", recursive = TRUE, ignore.case = TRUE)
if (length(delete) > 0) {
  dog("Pobrisane bodo sledeče datoteke:\n", delete, "\n")
  if(noask || readline("Nadaljujem? [da/NE] ") == 'da') {
    success <- file.remove(delete)
    if (any(!success)) {
      if (any(success)) {
        dog("Sledeče datoteke so pobrisane:\n", delete[success], "\n")
      }
      cat("Sledeče datoteke NISO pobrisane:\n", delete[!success], "\n")
    } else {
      dog("Datoteke so pobrisane.\n")
    }
  } else {
    dog("Datoteke niso pobrisane.\n")
  }
} else {
  fish("Ne najdem nobene datoteke PDF.\n")
}
fish("Brišem delovno okolje.\n")
rm(list = ls())
