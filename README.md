# ggplot2 Visualization Foundations / Fundamentos de visualización con ggplot2

A bilingual Quarto tutorial that rebuilds and improves the original RPubs project with visible notebook code, explicit `ggplot2` grammar, accessible colors, semantic data types, tests, and reproducible deployment.

Tutorial bilingüe en Quarto que reconstruye y mejora el proyecto original de RPubs mediante código visible, gramática explícita de `ggplot2`, colores accesibles, tipos de datos semánticos y pruebas.

## Reproduce / Reproducir

```r
renv::restore()
testthat::test_dir("tests/testthat")
```

```bash
quarto render
```

## Source / Fuente

- Dataset: `mtcars`, included with R.
- Original publication: https://rpubs.com/MPalmaR19/1301016
- GitHub: https://github.com/MPalma21/ggplot2-visualization-foundations
- Posit Connect Cloud: added after the first deployment.

## License

Code is released under the MIT License.
