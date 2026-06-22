# AGENTS.md

Guia operativa para agentes de codigo que trabajen en este repositorio.

## Proposito y Realidad Actual

- Este repositorio contiene el CV bilingue de Juan Sebastian Ramirez Ayala en LaTeX.
- El concepto del repo es un flujo tipo `Overleaf-to-RStudio bilingual CV`: plantilla LaTeX estilo Overleaf, render reproducible desde R/RStudio y traduccion asistida por skill local.
- Las entradas principales son `resume-es.tex` y `resume-en.tex`; `resume.tex` queda como wrapper compatible para la version en espanol.
- El contenido editable vive separado por idioma en `cv/es/*.tex` y `cv/en/*.tex`.
- La compilacion esta automatizada desde R mediante `scripts/Compilar_Archivos.R`, que usa `tinytex::latexmk()` con engine `xelatex`.
- Los PDFs generados deben quedar bajo `outputs/es/` y `outputs/en/`; `outputs/legacy/` contiene artefactos historicos movidos fuera de la raiz.

## Archivos Clave

| Ruta | Uso |
| --- | --- |
| `resume.tex` | Wrapper compatible que carga la version en espanol. |
| `resume-es.tex` | Entrada LaTeX para el CV en espanol. |
| `resume-en.tex` | Entrada LaTeX para el CV en ingles. |
| `cv/es/summary.tex` | Resumen/perfil en espanol. |
| `cv/es/skills.tex` | Habilidades en espanol. |
| `cv/es/experience.tex` | Experiencia en espanol. |
| `cv/es/education.tex` | Educacion en espanol. |
| `cv/es/languages.tex` | Idiomas en espanol. |
| `cv/es/interests.tex` | Proyectos/intereses en espanol; se importa despues de `\newpage`. |
| `cv/en/*.tex` | Versiones equivalentes en ingles, traducidas con la skill local del CV. |
| `cv/references.bib` | Bibliografia configurada con `\addbibresource`. |
| `russell.cls` | Clase LaTeX personalizada usada por `resume.tex`. |
| `fonts/` | Fuentes locales Roboto y FontAwesome usadas por la clase/documento. |
| `scripts/Compilar_Archivos.R` | API explicita `render_es()`, `render_en()` y `render_all()`; no compila al hacer `source()`. |
| `scripts/paquetes_Necesarios.R` | Instalacion/verificacion de TinyTeX y paquetes TeX; tiene efectos secundarios. |
| `outputs/` | Salidas generadas/ignoradas: PDFs finales por idioma y artefactos legacy. |
| `RamirezCV.Rproj` | Proyecto RStudio; configura UTF-8 y 2 espacios por tab. |
| `.gitignore` | Ignora archivos locales de R/RStudio (`.Rproj.user`, `.Rhistory`, `.RData`, `.Ruserdata`). |
| `.atl/skill-registry.md` | Registro generado de skills; no es documentacion funcional del CV. |
| `.opencode/skills/cv-latino-english-translator/` | Skill local para traducir contenido del CV de espanol a ingles profesional sin inventar hechos ni romper LaTeX. |
| `README.md` | Documentacion humana del flujo Overleaf/RStudio/bilingue. |

## Comandos Verificados

Comandos seguros y de solo lectura verificados durante la creacion de este archivo:

```bash
git status --short
git ls-files
Rscript -e "parse(file = 'scripts/Compilar_Archivos.R'); parse(file = 'scripts/paquetes_Necesarios.R')"
```

Resultado relevante:

- Los scripts R parsean correctamente sin ejecutarse.
- `scripts/Compilar_Archivos.R` puede cargarse con `source()` sin compilar ni abrir PDFs.

## Comandos No Verificados

No ejecutes estos comandos como verificacion automatica sin aprobacion o sin desactivar efectos secundarios:

```r
source("scripts/paquetes_Necesarios.R")
```

Motivo:

- `scripts/paquetes_Necesarios.R` ejecuta `verificar_e_instalar_tinytex()` y `tinytex::tlmgr_install(pkgs)` en nivel superior; puede instalar TinyTeX o paquetes TeX.
- No uses `source("scripts/paquetes_Necesarios.R")` como verificacion automatica.

## Flujo de Trabajo Seguro

- Antes de afirmar que existe un archivo, comando o salida generada, inspecciona el arbol actual.
- Para editar contenido del CV, modifica `cv/es/*.tex` y replica/traduce el cambio en `cv/en/*.tex` cuando corresponda; evita tocar `russell.cls` salvo que el cambio sea de plantilla/estilo global.
- Para traducir al ingles, usa la skill local `cv-latino-english-translator`; preserva hechos, fechas, empresas, instituciones, tecnologias, URLs y comandos LaTeX.
- No ejecutes instalaciones, compilaciones, aperturas de PDF ni limpieza de artefactos sin entender los efectos secundarios del script.
- No borres PDFs, logs, fuentes ni archivos `.tex` generados/actuales sin pedido explicito del usuario.
- No hagas commits salvo que el usuario lo pida explicitamente.
- Si una solicitud es ambigua, aclara si el usuario quiere cambiar contenido del CV, estilo LaTeX, dependencias o flujo de compilacion.

## Verificacion y Compilacion

- Verificacion barata recomendada para cambios en R:

```bash
Rscript -e "parse(file = 'scripts/Compilar_Archivos.R'); parse(file = 'scripts/paquetes_Necesarios.R')"
```

- Compilacion segura del CV:

```bash
Rscript -e 'source("scripts/Compilar_Archivos.R"); render_all(open_pdf = FALSE)'
```

- `render_es()` escribe `outputs/es/resume-es.pdf`.
- `render_en()` escribe `outputs/en/resume-en.pdf`.
- `render_all()` devuelve ambas rutas y no abre PDFs salvo que se pase `open_pdf = TRUE`.
- El script de compilacion valida que existan `resume-es.tex`/`resume-en.tex`, `russell.cls`, `fonts/` y `cv/` antes de llamar `tinytex::latexmk()`.

## Gotchas

- `RamirezCV.Rproj` declara `LaTeX: pdfLaTeX`, pero `scripts/Compilar_Archivos.R` compila con `xelatex`; respeta `xelatex` para soportar las fuentes locales configuradas.
- `scripts/paquetes_Necesarios.R` agrega paquetes `.win32` solo en Windows; no vuelvas a mezclar paquetes Windows-only en Linux.
- `resume.tex` contiene datos personales; no los publiques, reemplaces ni normalices sin pedido explicito.
- No dejes PDFs ni logs nuevos en la raiz; las salidas van en `outputs/` y esa carpeta esta ignorada por Git.
- `.Rproj.user/` y `.Rhistory` pueden existir localmente aunque esten ignorados por `.gitignore`; no los uses como fuente de verdad del proyecto.
