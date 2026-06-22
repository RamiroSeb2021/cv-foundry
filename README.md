# RamirezCV

Repositorio del CV bilingüe de Juan Sebastián Ramírez Ayala, construido en LaTeX y renderizado desde R.

El proyecto mantiene dos versiones del mismo CV:

- Español: `resume-es.tex` + contenido en `cv/es/`
- Inglés: `resume-en.tex` + contenido en `cv/en/`

`resume.tex` se conserva como wrapper compatible para la versión en español.

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

## Editar contenido

Para cambiar el CV, editá las secciones por idioma:

```text
cv/es/summary.tex
cv/es/skills.tex
cv/es/experience.tex
cv/es/education.tex
cv/es/languages.tex
cv/es/interests.tex

cv/en/summary.tex
cv/en/skills.tex
cv/en/experience.tex
cv/en/education.tex
cv/en/languages.tex
cv/en/interests.tex
```

Si cambiás contenido en español, revisá si corresponde replicarlo o traducirlo en inglés.

## Renderizar PDFs

Desde la raíz del repositorio:

```r
source("scripts/Compilar_Archivos.R")

render_es(open_pdf = FALSE)
render_en(open_pdf = FALSE)
render_all(open_pdf = FALSE)
```

Las salidas quedan en:

```text
outputs/es/resume-es.pdf
outputs/en/resume-en.pdf
```

Por defecto `open_pdf = FALSE`, así que el script no abre visores automáticamente.

## Verificación rápida

Para validar que los scripts R parsean sin ejecutar instalaciones:

```bash
Rscript -e "parse(file = 'scripts/Compilar_Archivos.R'); parse(file = 'scripts/paquetes_Necesarios.R')"
```

Para renderizar ambos CVs sin abrir PDFs:

```bash
Rscript -e 'source("scripts/Compilar_Archivos.R"); render_all(open_pdf = FALSE)'
```

## Dependencias

El render usa `tinytex::latexmk()` con engine `xelatex` para soportar las fuentes locales.

No ejecutes automáticamente:

```r
source("scripts/paquetes_Necesarios.R")
```

Ese script puede instalar TinyTeX o paquetes TeX. Usalo solo cuando realmente quieras gestionar dependencias.

## Notas

- Los PDFs y artefactos generados van en `outputs/` y están ignorados por Git.
- `RamirezCV.Rproj` puede declarar `pdfLaTeX`, pero el flujo del repo usa `xelatex`.
- La skill local `cv-latino-english-translator` documenta el criterio de traducción para mantener una versión en inglés profesional sin inventar logros.
