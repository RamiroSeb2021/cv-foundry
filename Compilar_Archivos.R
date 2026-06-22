# Compilación CV -----------------------------------------------------------
# API explícita para renderizar el CV por idioma.
# Este archivo no debe compilar ni abrir PDFs al cargarse con source() o parse().
# Los efectos secundarios de instalación permanecen en paquetes_Necesarios.R y
# sólo deben ejecutarse de forma explícita por quien mantenga el proyecto.

resolver_path_base <- function(path_ = "") {
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
    stop(
      "Sistema operativo no soportado: ", os,
      "\nPasa el directorio manualmente con compilar_cv(path_ = '...', main_tex = '...')"
    )
  }

  if (!dir.exists(base_path)) {
    stop(
      "No existe el directorio base: ", base_path,
      "\nActualiza Path_Linux/Path_Win/Path_IOS o usa compilar_cv(path_ = '...', main_tex = '...')"
    )
  }

  normalizePath(base_path, mustWork = TRUE)
}

validar_entrada_cv <- function(base_path, main_tex) {
  if (missing(main_tex) || !nzchar(main_tex)) {
    stop("Debes indicar explícitamente el archivo .tex principal en main_tex.")
  }

  if (!grepl("\\.tex$", main_tex)) {
    stop("main_tex debe apuntar a un archivo .tex: ", main_tex)
  }

  # Chequeos mínimos de estructura
  must_exist <- c(main_tex, "russell.cls", "fonts", "cv")
  missing <- must_exist[!file.exists(file.path(base_path, must_exist))]
  if (length(missing) > 0) {
    stop("Faltan archivos/carpetas en el directorio base: ", paste(missing, collapse = ", "))
  }
}

compilar_cv <- function(path_ = "", main_tex, open_pdf = FALSE) {
  base_path <- resolver_path_base(path_)
  validar_entrada_cv(base_path, main_tex)

  # Guardar wd actual y restaurarlo al final
  old_wd <- getwd()
  on.exit(setwd(old_wd), add = TRUE)
  setwd(base_path)
  
  # Guardar todo en RStudio (si aplica)
  if (requireNamespace("rstudioapi", quietly = TRUE) && rstudioapi::isAvailable()) {
    try(rstudioapi::documentSaveAll(), silent = TRUE)
  }
  # Paquetes requeridos
  if (!requireNamespace("tinytex", quietly = TRUE)) {
    stop("Instala tinytex: install.packages('tinytex')")
  }
  
  # (Opcional) si NO tienes LaTeX instalado o TinyTeX, descomenta:
  # tinytex::install_tinytex()
  
  # Compilar con XeLaTeX (recomendado por las fuentes Roboto/FontAwesome)
  # latexmk deja todo bien resuelto (refs, multiple passes, etc.)
  out_pdf <- sub("\\.tex$", ".pdf", basename(main_tex))
  
  tinytex::latexmk(
    file = main_tex,
    engine = "xelatex",
    clean = TRUE
  )
  
  if (!file.exists(out_pdf)) {
    stop("No se generó el PDF esperado: ", out_pdf,
         "\nRevisa el log .log en el directorio para ver el error exacto.")
  }
  
  if (isTRUE(open_pdf)) {
    pdf_path <- normalizePath(out_pdf)
    os <- Sys.info()[["sysname"]]

    if (os == "Linux" && nzchar(Sys.which("xdg-open"))) {
      system2("xdg-open", pdf_path, wait = FALSE)
    } else {
      browseURL(pdf_path)
    }
  }
  
  message("✅ Compilado correctamente: ", normalizePath(out_pdf))
  invisible(normalizePath(out_pdf))
}

render_es <- function(path_ = "", open_pdf = FALSE) {
  compilar_cv(path_ = path_, main_tex = "resume-es.tex", open_pdf = open_pdf)
}

render_en <- function(path_ = "", open_pdf = FALSE) {
  compilar_cv(path_ = path_, main_tex = "resume-en.tex", open_pdf = open_pdf)
}

render_all <- function(path_ = "", open_pdf = FALSE) {
  c(
    es = render_es(path_ = path_, open_pdf = open_pdf),
    en = render_en(path_ = path_, open_pdf = open_pdf)
  )
}

# Ejemplos explícitos, sin ejecución automática:
# render_es(path_ = "/storage/backups/backup-d-antes-linux/PPP/Sebastian/RamirezCV")
# render_en(path_ = "/storage/backups/backup-d-antes-linux/PPP/Sebastian/RamirezCV")
# render_all(path_ = "/storage/backups/backup-d-antes-linux/PPP/Sebastian/RamirezCV", open_pdf = FALSE)
