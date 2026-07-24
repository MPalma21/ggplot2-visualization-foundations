suppressWarnings(suppressPackageStartupMessages({
  library(dplyr)
  library(ggplot2)
}))

portfolio_theme <- function() {
  theme_minimal(base_size = 12) +
    theme(
      plot.title.position = "plot",
      plot.title = element_text(face = "bold"),
      panel.grid.minor = element_blank(),
      legend.position = "bottom"
    )
}

prepare_mtcars <- function(data = datasets::mtcars) {
  required <- c("mpg", "cyl", "hp", "wt", "am", "gear")
  missing_columns <- setdiff(required, names(data))
  if (length(missing_columns) > 0) {
    stop("Missing required columns: ", paste(missing_columns, collapse = ", "))
  }

  data |>
    tibble::rownames_to_column("model") |>
    mutate(
      cylinders = factor(cyl, levels = c(4, 6, 8)),
      transmission = factor(
        am,
        levels = c(0, 1),
        labels = c("Automatic", "Manual")
      ),
      gears = factor(gear)
    )
}

plot_cylinder_counts <- function(data, language = c("en", "es")) {
  language <- match.arg(language)
  labels <- if (language == "en") {
    c(title = "Cars by cylinder count", x = "Cylinders", y = "Cars")
  } else {
    c(title = "Automóviles por número de cilindros", x = "Cilindros", y = "Automóviles")
  }

  ggplot(data, aes(cylinders, fill = cylinders)) +
    geom_bar(show.legend = FALSE) +
    scale_fill_viridis_d(end = 0.85) +
    labs(title = labels[["title"]], x = labels[["x"]], y = labels[["y"]]) +
    portfolio_theme()
}

plot_efficiency_weight <- function(data, language = c("en", "es")) {
  language <- match.arg(language)
  labels <- if (language == "en") {
    c(
      title = "Fuel efficiency falls as vehicle weight rises",
      subtitle = "Point shape identifies transmission type",
      x = "Weight (1,000 lb)",
      y = "Fuel efficiency (mpg)",
      color = "Cylinders",
      shape = "Transmission"
    )
  } else {
    c(
      title = "La eficiencia disminuye cuando aumenta el peso",
      subtitle = "La forma identifica el tipo de transmisión",
      x = "Peso (miles de libras)",
      y = "Eficiencia (millas por galón)",
      color = "Cilindros",
      shape = "Transmisión"
    )
  }

  ggplot(data, aes(wt, mpg, color = cylinders, shape = transmission)) +
    geom_point(size = 3, alpha = 0.85) +
    geom_smooth(aes(group = 1), method = "lm", se = TRUE, color = "#333333") +
    scale_color_viridis_d(end = 0.85) +
    labs(
      title = labels[["title"]],
      subtitle = labels[["subtitle"]],
      x = labels[["x"]],
      y = labels[["y"]],
      color = labels[["color"]],
      shape = labels[["shape"]]
    ) +
    portfolio_theme()
}

plot_horsepower_distribution <- function(data, language = c("en", "es")) {
  language <- match.arg(language)
  labels <- if (language == "en") {
    c(title = "Horsepower distribution", x = "Horsepower", y = "Cars")
  } else {
    c(title = "Distribución de potencia", x = "Caballos de fuerza", y = "Automóviles")
  }

  ggplot(data, aes(hp)) +
    geom_histogram(binwidth = 25, boundary = 0, fill = "#2A9D8F", color = "white") +
    labs(title = labels[["title"]], x = labels[["x"]], y = labels[["y"]]) +
    portfolio_theme()
}

plot_efficiency_boxplot <- function(data, language = c("en", "es")) {
  language <- match.arg(language)
  labels <- if (language == "en") {
    c(title = "Fuel efficiency by transmission", x = "Transmission", y = "Fuel efficiency (mpg)")
  } else {
    c(title = "Eficiencia por transmisión", x = "Transmisión", y = "Eficiencia (millas por galón)")
  }

  ggplot(data, aes(transmission, mpg, fill = transmission)) +
    geom_boxplot(width = 0.6, show.legend = FALSE) +
    geom_jitter(width = 0.08, alpha = 0.65) +
    scale_fill_viridis_d(end = 0.85) +
    labs(title = labels[["title"]], x = labels[["x"]], y = labels[["y"]]) +
    portfolio_theme()
}
