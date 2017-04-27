library(ggvis)
library(shiny)
library(parcoords)
library(pairsD3)

server <- function(input, output) {
  df <- read.csv("dataset_Facebook.csv", sep=";", header=TRUE)
  
  df_b <- df[df$Type=="Status",]
  df_b$Paid <- factor(df_b$Paid)
  df_b$Post.Weekday <- factor(df_b$Post.Weekday)
  df_b$id <- 1:nrow(df_b)
  
  df_s <- df[df$like < 3000, 16:19]
  
  df_p <- df[df$like < 3000 & df$Paid == 1,c(3,16:19)]
  
  show_comments <- function(x) {
    if(is.null(x)) return(NULL)
    row <- df_b[df_b$id == x$id, ]
    return(paste("Comments: ", row$comment, sep=""))
  }
  
  df_b %>% 
    ggvis(~Post.Weekday, ~like, size := ~comment*10, key := ~id, fill = ~Paid) %>%
    add_axis("x", title="Weekday") %>%
    add_axis("y", title="Likes") %>%
    add_tooltip(show_comments, "hover") %>%
    add_tooltip(show_comments, "click") %>%
    layer_points() %>%
    bind_shiny("ggvis", "ggvis_ui")
  
  output$pd3plot <- renderUI({pairsD3Output("pd3", width=700, height=700)})
  output$pd3 <- renderPairsD3({pairsD3(df_s)})  
  
  output$pcplot <- renderUI({parcoordsOutput("pc", width=800, height=500)})
  output$pc <- renderParcoords({
    parcoords(df_p, rownames = F, brushMode = "2D-strums", color = list(
      colorBy="Category"
      ,colorScale=htmlwidgets::JS('d3.scale.category10()')
    ))
  })  
}