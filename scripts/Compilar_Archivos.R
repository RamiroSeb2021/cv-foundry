# Compilación CV -----------------------------------------------------------
# API explícita para renderizar el CV por idioma.
# Este archivo no debe compilar ni abrir PDFs al cargarse con source() o parse().
# Los efectos secundarios de instalación permanecen en scripts/paquetes_Necesarios.R
# y sólo deben ejecutarse de forma explícita por quien mantenga el proyecto.
#
# Estructura esperada:
# - cv/es/*.tex y cv/en/*.tex: contenido editable del CV.
# - resume-es.tex y resume-en.tex: entradas LaTeX por idioma.
# - outputs/es y outputs/en: PDFs finales generados por estas funciones.

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

validar_entrada_cv <- function(base_path, main_tex, output_dir) {
  if (missing(main_tex) || !nzchar(main_tex)) {
    stop("Debes indicar explícitamente el archivo .tex principal en main_tex.")
  }

  if (!grepl("\\.tex$", main_tex)) {
    stop("main_tex debe apuntar a un archivo .tex: ", main_tex)
  }

  if (missing(output_dir) || !nzchar(output_dir)) {
    stop("Debes indicar explícitamente la carpeta de salida en output_dir.")
  }

  # Chequeos mínimos de estructura
  must_exist <- c(main_tex, "russell.cls", "fonts", "cv")
  missing <- must_exist[!file.exists(file.path(base_path, must_exist))]
  if (length(missing) > 0) {
    stop("Faltan archivos/carpetas en el directorio base: ", paste(missing, collapse = ", "))
  }
}

limpiar_temporales_latex <- function(base_name) {
  extensiones <- c(
    "aux", "bbl", "bcf", "blg", "fdb_latexmk", "fls", "log", "out",
    "run.xml", "synctex.gz", "toc", "xdv"
  )

  archivos <- file.path(getwd(), paste0(base_name, ".", extensiones))
  unlink(archivos[file.exists(archivos)], force = TRUE)
}

compilar_cv <- function(path_ = "", main_tex, output_dir, open_pdf = FALSE) {
  base_path <- resolver_path_base(path_)
  validar_entrada_cv(base_path, main_tex, output_dir)

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
  base_name <- sub("\\.tex$", "", basename(main_tex))
  generated_pdf <- paste0(base_name, ".pdf")
  output_path <- file.path(output_dir, generated_pdf)
  dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)
  
  tinytex::latexmk(
    file = main_tex,
    engine = "xelatex",
    clean = TRUE
  )
  
  if (!file.exists(generated_pdf)) {
    stop("No se generó el PDF esperado: ", generated_pdf,
         "\nRevisa el log .log en el directorio para ver el error exacto.")
  }

  file.copy(generated_pdf, output_path, overwrite = TRUE)
  unlink(generated_pdf, force = TRUE)
  limpiar_temporales_latex(base_name)
  
  if (isTRUE(open_pdf)) {
    pdf_path <- normalizePath(output_path)
    os <- Sys.info()[["sysname"]]

    if (os == "Linux" && nzchar(Sys.which("xdg-open"))) {
      system2("xdg-open", pdf_path, wait = FALSE)
    } else {
      browseURL(pdf_path)
    }
  }
  
  message("✅ Compilado correctamente: ", normalizePath(output_path))
  invisible(normalizePath(output_path))
}

render_es <- function(path_ = "", open_pdf = FALSE) {
  compilar_cv(
    path_ = path_,
    main_tex = "resume-es.tex",
    output_dir = file.path("outputs", "es"),
    open_pdf = open_pdf
  )
}

render_en <- function(path_ = "", open_pdf = FALSE) {
  compilar_cv(
    path_ = path_,
    main_tex = "resume-en.tex",
    output_dir = file.path("outputs", "en"),
    open_pdf = open_pdf
  )
}

render_all <- function(path_ = "", open_pdf = FALSE) {
  c(
    es = render_es(path_ = path_, open_pdf = open_pdf),
    en = render_en(path_ = path_, open_pdf = open_pdf)
  )
}

# Ejemplos explícitos, sin ejecución automática:
# source("scripts/Compilar_Archivos.R")
# render_es(path_ = "/storage/backups/backup-d-antes-linux/PPP/Sebastian/RamirezCV")
# render_en(path_ = "/storage/backups/backup-d-antes-linux/PPP/Sebastian/RamirezCV")
# render_all(path_ = "/storage/backups/backup-d-antes-linux/PPP/Sebastian/RamirezCV", open_pdf = FALSE)
