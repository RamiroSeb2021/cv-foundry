# tinytex::uninstall_tinytex()
tinytex::is_tinytex()
verificar_e_instalar_tinytex <- function() {
  if (!tinytex::is_tinytex()) {
    message("TinyTeX no está instalado. Instalando...")
    tinytex::install_tinytex()
    
    if (tinytex::is_tinytex()) {
      message("TinyTeX se instaló correctamente. Reiniciando R...")
      if (rstudioapi::isAvailable()) {
        rstudioapi::restartSession()
      } else {
        message("No se puede reiniciar automáticamente fuera de RStudio. Reinicia R manualmente.")
      }
    } else {
      warning("Hubo un problema instalando TinyTeX. Por favor revisa los mensajes anteriores.")
    }
  } else {
    message("TinyTeX ya está instalado.")
  }
}

verificar_e_instalar_tinytex()

pkgs <- c("amscls", "amsfonts", "amsmath", "atbegshi", "atveryend", "auxhook", "babel",
          "bibtex", "bigintcalc", "bitset", "booktabs", "cm", "colortbl",
          "ctablestack", "dehyph", "dvipdfmx", "dvips",
          "ec", "environ", "epstopdf-pkg", "etex", "etexcmds", "etoolbox", "euenc", 
          "everyshi", "fancyvrb", "filehook", "firstaid", "float", "fontspec", "framed",
          "geometry", "gettitlestring", "glyphlist", "graphics", "graphics-cfg", 
          "graphics-def", "helvetic", "hycolor", "hyperref", "hyph-utf8", "hyphen-base", 
          "iftex", "inconsolata", "infwarerr", "intcalc", "knuth-lib", "kpathsea", 
          "kvdefinekeys", "kvoptions", "kvsetkeys", "l3backend", 
          "l3kernel", "l3packages", "latex", "latex-amsmath-dev", "latex-bin", 
          "latex-fonts", "latex-tools-dev", "latexconfig", "latexmk", 
          "letltxmacro", "lm", "lm-math", "ltxcmds", "lua-alt-getopt", 
          "lua-uni-algos", "luahbtex", "lualatex-math", "lualibs", 
          "luaotfload", "luatex", "luatexbase", 
          "makecell", "mdwtools", "metafont", "mfware",
          "modes", "multirow", "natbib", "pdfescape", "pdflscape", "pdftex", 
          "pdftexcmds", "plain", "psnfss", "refcount", "rerunfilecheck",
          "scheme-infraonly", "selnolig", "stringenc", "symbol", "tabu", "tex", 
          "tex-ini-files", "texlive-scripts", 
          "texlive.infra", "threeparttable", "threeparttablex",
          "times", "tipa", "tools", "trimspaces", "ulem", 
          "unicode-data", "unicode-math", "uniquecounter", "url", "varwidth", "wrapfig", 
          "xcolor", "xetex", "xetexconfig", "xkeyval", "xunicode", "zapfding",
          "microtype")

pkgs_windows <- c("bibtex.win32", "dvipdfmx.win32", "dvips.win32", "kpathsea.win32",
                  "latex-bin.win32", "latexmk.win32", "luahbtex.win32",
                  "luaotfload.win32", "luatex.win32", "metafont.win32",
                  "mfware.win32", "pdftex.win32", "tex.win32",
                  "texlive-scripts.win32", "texlive.infra.win32", "tlgs.win32",
                  "tlperl.win32", "xetex.win32")

if (.Platform$OS.type == "windows") {
  pkgs <- c(pkgs, pkgs_windows)
}

pkgs <- unique(pkgs)

tinytex::tlmgr_install(pkgs)
# 

