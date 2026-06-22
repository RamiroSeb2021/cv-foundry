# AGENTS.md

Guia operativa para agentes de codigo que trabajen en este repositorio.

## Proposito y Realidad Actual

- Este repositorio contiene el CV de Juan Sebastian Ramirez Ayala en LaTeX, con scripts R para instalar dependencias TeX y compilar `resume.tex`.
- La entrada principal del documento es `resume.tex`; el contenido editable del CV vive en archivos `cv/*.tex`.
- La compilacion esta automatizada desde R mediante `Compilar_Archivos.R`, que usa `tinytex::latexmk()` con engine `xelatex`.
- No se encontro `README.md` en la raiz al crear este archivo.
- `git ls-files` no devolvio archivos versionados en la revision inspeccionada; `git status --short` mostro los archivos del proyecto como no trackeados.

## Archivos Clave

| Ruta | Uso |
| --- | --- |
| `resume.tex` | Documento LaTeX principal; importa las secciones de `cv/`. |
| `cv/summary.tex` | Resumen del CV. |
| `cv/skills.tex` | Habilidades. |
| `cv/experience.tex` | Experiencia. |
| `cv/education.tex` | Educacion. |
| `cv/languages.tex` | Idiomas. |
| `cv/interests.tex` | Intereses; se importa despues de `\newpage`. |
| `cv/references.bib` | Bibliografia configurada con `\addbibresource`. |
| `russell.cls` | Clase LaTeX personalizada usada por `resume.tex`. |
| `fonts/` | Fuentes locales Roboto y FontAwesome usadas por la clase/documento. |
| `Compilar_Archivos.R` | Funcion `compilar_cv()` y llamada final para compilar el PDF. |
| `paquetes_Necesarios.R` | Instalacion/verificacion de TinyTeX y paquetes TeX. |
| `RamirezCV.Rproj` | Proyecto RStudio; configura UTF-8 y 2 espacios por tab. |
| `.gitignore` | Ignora archivos locales de R/RStudio (`.Rproj.user`, `.Rhistory`, `.RData`, `.Ruserdata`). |
| `.atl/skill-registry.md` | Registro generado de skills; no es documentacion funcional del CV. |

## Comandos Verificados

Comandos seguros y de solo lectura verificados durante la creacion de este archivo:

```bash
git status --short
git ls-files
Rscript -e "parse(file = 'Compilar_Archivos.R'); parse(file = 'paquetes_Necesarios.R')"
```

Resultado relevante:

- Los scripts R parsean correctamente sin ejecutarse.
- `git ls-files` no mostro archivos trackeados.
- `git status --short` mostro los archivos del proyecto como no trackeados.

## Comandos No Verificados

No ejecutes estos comandos como verificacion automatica sin aprobacion o sin desactivar efectos secundarios:

```r
source("Compilar_Archivos.R")
source("paquetes_Necesarios.R")
```

Motivo:

- `Compilar_Archivos.R` termina llamando `compilar_cv(path_ = "/storage/backups/backup-d-antes-linux/PPP/Sebastian/RamirezCV")`, lo que compila `resume.tex` y puede abrir el PDF.
- `paquetes_Necesarios.R` ejecuta `verificar_e_instalar_tinytex()` y `tinytex::tlmgr_install(pkgs)` en nivel superior; puede instalar TinyTeX o paquetes TeX.

## Flujo de Trabajo Seguro

- Antes de afirmar que existe un archivo, comando o salida generada, inspecciona el arbol actual.
- Para editar contenido del CV, modifica los archivos `cv/*.tex` o la seccion correspondiente en `resume.tex`; evita tocar `russell.cls` salvo que el cambio sea de plantilla/estilo global.
- No ejecutes instalaciones, compilaciones, aperturas de PDF ni limpieza de artefactos sin entender los efectos secundarios del script.
- No borres PDFs, logs, fuentes ni archivos `.tex` generados/actuales sin pedido explicito del usuario.
- No hagas commits salvo que el usuario lo pida explicitamente.
- Si una solicitud es ambigua, aclara si el usuario quiere cambiar contenido del CV, estilo LaTeX, dependencias o flujo de compilacion.

## Verificacion y Compilacion

- Verificacion barata recomendada para cambios en R:

```bash
Rscript -e "parse(file = 'Compilar_Archivos.R'); parse(file = 'paquetes_Necesarios.R')"
```

- Compilacion del CV: existe la funcion `compilar_cv()` en `Compilar_Archivos.R`, pero la ejecucion del archivo tambien compila por la llamada final. No fue verificada durante la creacion de este `AGENTS.md`.
- El script de compilacion valida que existan `resume.tex`, `russell.cls`, `fonts/` y `cv/` antes de llamar `tinytex::latexmk()`.
- En Linux, el script usa `Path_Linux <- "/storage/backups/backup-d-antes-linux/PPP/Sebastian/RamirezCV"` y abre el PDF con `xdg-open` si esta disponible.

## Gotchas

- `RamirezCV.Rproj` declara `LaTeX: pdfLaTeX`, pero `Compilar_Archivos.R` compila con `xelatex`; respeta `xelatex` para soportar las fuentes locales configuradas.
- `paquetes_Necesarios.R` agrega paquetes `.win32` solo en Windows; no vuelvas a mezclar paquetes Windows-only en Linux.
- `resume.tex` contiene datos personales; no los publiques, reemplaces ni normalices sin pedido explicito.
- Hay PDFs y `resume.log` presentes en la raiz; tratalos como artefactos existentes y no como prueba de que la compilacion actual fue verificada.
- `.Rproj.user/` y `.Rhistory` pueden existir localmente aunque esten ignorados por `.gitignore`; no los uses como fuente de verdad del proyecto.
