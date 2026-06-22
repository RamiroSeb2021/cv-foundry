# CV Foundry

Este repo es mi herramienta personal para mantener mi CV en español e inglés sin volverme loco entre archivos sueltos, PDFs generados y versiones desactualizadas.

La idea nació de un flujo bastante común: tomar una plantilla bonita de LaTeX tipo Overleaf, adaptarla a mi perfil, renderizarla desde RStudio/R y mantener una versión en inglés con ayuda de una skill local. No es solo “un CV en LaTeX”; es un flujo reproducible para editar, traducir y generar ambos PDFs de forma ordenada.

El proyecto mantiene dos versiones del mismo CV:

- Español: `resume-es.tex` + contenido en `cv/es/`
- Inglés: `resume-en.tex` + contenido en `cv/en/`

`resume.tex` se conserva como wrapper compatible para la versión en español.

## Qué problema resuelve

- El contenido no queda mezclado entre español e inglés.
- Los PDFs generados no ensucian la raíz del proyecto.
- El render se puede repetir desde RStudio/R con comandos claros.
- La traducción al inglés tiene reglas explícitas para no inventar logros ni romper comandos LaTeX.
- `resume.tex` sigue existiendo como compatibilidad para la versión en español.

## Estructura

```text
.
├── cv/
│   ├── es/                 # contenido editable en español
│   ├── en/                 # contenido editable en inglés
│   └── references.bib
├── fonts/                  # fuentes usadas por la clase LaTeX
├── outputs/
│   ├── es/                 # PDF generado en español
│   ├── en/                 # PDF generado en inglés
│   └── legacy/             # artefactos históricos
├── scripts/
│   ├── Compilar_Archivos.R
│   └── paquetes_Necesarios.R
├── resume-es.tex
├── resume-en.tex
├── resume.tex
└── russell.cls
```

## Dónde editar el CV

El contenido editable vive en `cv/`, separado por idioma.

Para cambiar la versión en español:

```text
cv/es/summary.tex
cv/es/skills.tex
cv/es/experience.tex
cv/es/education.tex
cv/es/languages.tex
cv/es/interests.tex
```

Para cambiar la versión en inglés:

```text
cv/en/summary.tex
cv/en/skills.tex
cv/en/experience.tex
cv/en/education.tex
cv/en/languages.tex
cv/en/interests.tex
```

Si actualizo algo importante en español, normalmente también debería revisar la versión en inglés para que ambos CVs sigan contando la misma historia.

Para traducciones, seguí el criterio de la skill local:

```text
.opencode/skills/cv-latino-english-translator/
```

La regla principal: traducir con naturalidad profesional, pero sin inventar logros, cambiar fechas, alterar nombres de empresas o romper comandos LaTeX.

## Cómo generar los PDFs

Desde la raíz del repositorio:

```r
source("scripts/Compilar_Archivos.R")

render_es(open_pdf = FALSE)
render_en(open_pdf = FALSE)
render_all(open_pdf = FALSE)
```

Los PDFs quedan organizados acá:

```text
outputs/es/resume-es.pdf
outputs/en/resume-en.pdf
```

Por defecto `open_pdf = FALSE`, así que el script genera los archivos sin abrir visores automáticamente.

## Verificación rápida para no romper nada

Antes de tocar dependencias o compilar, puedo validar que los scripts R al menos parsean bien:

```bash
Rscript -e "parse(file = 'scripts/Compilar_Archivos.R'); parse(file = 'scripts/paquetes_Necesarios.R')"
```

Y para comprobar el flujo completo de render:

```bash
Rscript -e 'source("scripts/Compilar_Archivos.R"); render_all(open_pdf = FALSE)'
```

## Dependencias y cuidado con instalaciones

El render usa `tinytex::latexmk()` con engine `xelatex` para soportar las fuentes locales.

Este archivo existe para gestionar paquetes TeX, pero no conviene ejecutarlo por accidente:

```r
source("scripts/paquetes_Necesarios.R")
```

Ese script puede instalar TinyTeX o paquetes TeX. Mejor usarlo solo cuando realmente quiera preparar o reparar el entorno.

## Notas útiles

- Los PDFs y artefactos generados van en `outputs/` y están ignorados por Git.
- `RamirezCV.Rproj` puede declarar `pdfLaTeX`, pero el flujo del repo usa `xelatex`.
- La skill local `cv-latino-english-translator` documenta el criterio de traducción para mantener una versión en inglés profesional sin inventar logros.
