library(otherworldspalettes)
e <- otherworlds_palette(8,"eclipse")
a <- otherworlds_palette(12,"afterglow")
d <- otherworlds_palette(20,"deepfield")
stopifnot(identical(e,a[1:8]),identical(a,d[1:12]),
          length(unique(unname(d)))==20L,
          all(grepl("^#[A-F0-9]{6}$",d)),
          identical(otherworlds_palette(20,"deepfield",-1),rev(d)),
          inherits(try(otherworlds_palette(21,"deepfield"),silent=TRUE),"try-error"))
relative_luminance <- function(hex) {
  rgb <- t(grDevices::col2rgb(hex))/255
  linear <- ifelse(rgb <= .04045,rgb/12.92,((rgb+.055)/1.055)^2.4)
  as.vector(linear %*% c(.2126,.7152,.0722))
}
for(bg in c("#081126","#101827","#000000")) {
  x <- relative_luminance(d);y <- relative_luminance(bg)
  stopifnot(all((pmax(x,y)+.05)/(pmin(x,y)+.05)>=5.2))
}
if(requireNamespace("ggplot2",quietly=TRUE)){
  df<-data.frame(x=1:20,y=1,cl=factor(1:20))
  p<-ggplot2::ggplot(df,ggplot2::aes(x,y,colour=cl))+
    ggplot2::geom_point()+scale_colour_otherworlds(palette="deepfield")
  stopifnot(length(unique(ggplot2::ggplot_build(p)$data[[1]]$colour))==20L)
}
