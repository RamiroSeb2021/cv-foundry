# Compilación CV (resume.tex) ---------------------------------------------

compilar_cv <- function(path_ = "", main_tex = "resume.tex", open_pdf = TRUE) {
  # Detectar OS
  os <- Sys.info()[["sysname"]]
  
  # Paths por sistema operativo
  Path_IOS   <- "/Users/juansebastiabramirezayala/Library/CloudStorage/GoogleDrive-juanrayala12@gmail.com/Mi unidad/RSTUDIO_/SIET/ProyectoSIET/Documento_Proyecto"
  Path_Win   <- "D:/PPP/Sebastian/RamirezCV"
  Path_Linux <- "/storage/backups/backup-d-antes-linux/PPP/Sebastian/RamirezCV"
  
  # Resolver path base
  base_path <- if (nzchar(path_)) {
    path_
  } else if (os == "Darwin") {
    Path_IOS
  } else if (os == "Windows") {
    Path_Win
  } else if (os == "Linux") {
    Path_Linux
  } else {
    stop("Sistema operativo no soportado: ", os,
         "\nPasa el directorio manualmente con compilar_cv(path_ = '...')")
  }

  if (!dir.exists(base_path)) {
    stop("No existe el directorio base: ", base_path,
         "\nActualiza Path_Linux/Path_Win/Path_IOS o usa compilar_cv(path_ = '...')")
  }
  
  # Guardar wd actual y restaurarlo al final
  old_wd <- getwd()
  on.exit(setwd(old_wd), add = TRUE)
  setwd(base_path)
  
  # Guardar todo en RStudio (si aplica)
  if (requireNamespace("rstudioapi", quietly = TRUE) && rstudioapi::isAvailable()) {
    try(rstudioapi::documentSaveAll(), silent = TRUE)
  }
  
  # Chequeos mínimos de estructura
  must_exist <- c(main_tex, "russell.cls", "fonts", "cv")
  missing <- must_exist[!file.exists(must_exist)]
  if (length(missing) > 0) {
    stop("Faltan archivos/carpetas en el directorio base: ", paste(missing, collapse = ", "))
  }
  
  # Paquetes requeridos
  if (!requireNamespace("tinytex", quietly = TRUE)) {
    stop("Instala tinytex: install.packages('tinytex')")
  }
  
  # (Opcional) si NO tienes LaTeX instalado o TinyTeX, descomenta:
  # tinytex::install_tinytex()
  
  # Compilar con XeLaTeX (recomendado por las fuentes Roboto/FontAwesome)
  # latexmk deja todo bien resuelto (refs, multiple passes, etc.)
  out_pdf <- sub("\\.tex$", ".pdf", main_tex)
  
  tinytex::latexmk(
    file = main_tex,
    engine = "xelatex",
    clean = TRUE
  )
  
  if (!file.exists(out_pdf)) {
    stop("No se generó el PDF esperado: ", out_pdf,
         "\nRevisa el log .log en el directorio para ver el error exacto.")
  }
  
  if (open_pdf) {
    pdf_path <- normalizePath(out_pdf)

    if (os == "Linux" && nzchar(Sys.which("xdg-open"))) {
      system2("xdg-open", pdf_path, wait = FALSE)
    } else {
      browseURL(pdf_path)
    }
  }
  
  message("✅ Compilado correctamente: ", normalizePath(out_pdf))
  invisible(normalizePath(out_pdf))
}

# Ejemplos:
# compilar_cv(path_ = "/storage/backups/backup-d-antes-linux/PPP/Sebastian/RamirezCV")
# compilar_cv()
compilar_cv(path_ = "/storage/backups/backup-d-antes-linux/PPP/Sebastian/RamirezCV")
