library(bslib)
install.packages("htmlwidgets", type = "binary")
install.packages("DT", type = "binary")

theme <- bs_theme(
  bg = "#1E59B5", fg = "#ACC3E7", primary = "#FCC780",
  base_font = font_google("Space Mono"),
  code_font = font_google("Space Mono")
)
bs_theme_preview(theme)

