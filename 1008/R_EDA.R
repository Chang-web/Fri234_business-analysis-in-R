
#### 1008: visualizing data
#### reference: teacher's lecture notes

# frequency table:
# pie(), barplot()放入table
pie(table(iris$Species))
barplot(table(iris$Sepal.Length)) 

# histogram, plot() 直接指定變數資料
hist(iris$Sepal.Length, xlab = "Sepal Length", main = "histogram")
plot(iris$Sepal.Length, iris$Sepal.Width)

# R pch: 查詢顏色代碼、圖像

# continuous & continuous
library(lattice)
xyplot(Sepal.Width ~ Sepal.Length, iris, groups = Species, pch= 20)

# continuous & discrete
# boxplot(formula, data = NULL, xlab, ylab, ...)
# formula:such as "y ~ grp", where y is a numeric vector of data values to be split into groups according to the grouping variable grp (usually a factor). 
boxplot(iris$Sepal.Length~iris$Species)

# tapply(X, INDEX, FUN = NULL, ...)
length.means = tapply(
  iris$Sepal.Length, 
  iris$Species, 
  mean)
barplot(length.means, 
        xlab = "Species", 
        ylab = "Mean of Sepal.Length")

# discrete and discrete
# create dummies column
mean.index <- ifelse(iris$Sepal.Length > mean(iris$Sepal.Length),1,0)
# mosaicplot()
# Formula interface for raw data: visualize cross-tabulation of numbers
# the left-hand side of formula should be empty and the variables on the right-hand side should be taken from dimnames
mosaicplot(~mean.index + iris$Species, color=T)

# multivariables
plot(iris) # 5*5 plots

# cloud():3D scatter plot; wireframe():3D surface
# z~x*y；| :given group variable
cloud(iris$Sepal.Length ~ iris$Sepal.Width*iris$Petal.Length|iris$Species, main="3D Scatterplot by Species")

# rotation plot
colors <- c("darkorange", "hotpink", "limegreen")
colors <- colors[as.numeric(iris$Species)]
library(rgl)
plot3d(iris[,1:3], col=colors)


# save as a gif
install.packages("animation")
library(animation)
install.packages("scatterplot3d")
library("scatterplot3d")
saveGIF({
  for(i in 1:30){
    scatterplot3d(iris[,1:3], color=colors, pch=20,
                  xlab="Sepal.Length", ylab="Sepal.width", zlab="Petal.Length",
                  angle=90 + 3.6 * 3 * i
    )
  }
}, movie.name="iris.gif")

#### ggplot2

# save image
png(file = "scatter.png", width = 3840, height = 2160, units = "px", res = 72*4) #export the plot
ggdraw() + # 空白的圖
  draw_image("flower.jpeg", scale = 0.5) + # the background for the plot
  draw_plot(ii)
dev.off() #done, close the "png" devise

# arrange plots
# ggplot合併圖函數:plot_grid()
p <- ggplot(iris, aes(x = Sepal.Length, fill = Species)) + geom_density(alpha = 0.7)
p2 <- ggdraw() + draw_image("flower.jpeg", scale = 0.5)
plot_grid(p, p2, labels = "AUTO")
plot_grid(p, ii, labels = c("1","2"), ncol = 1, align = 'v')
plot_grid(p, p2, p2,ii, labels = "AUTO", ncol =  2, align = 'h')

# 一般合併圖函數:par(mfrow = c(a,b))

# correlation plot
install.packages("corrgram")
library(corrgram)
corr <-  cor(iris[,1:4]) #corr is a correlation matrix
corrgram(iris)

install.packages("corrplot")
library(corrplot)
corrplot(corr, method = "circle") # 比較清楚的相關性圖


# heatmap
library(gplots)
heatmap.2(as.matrix(t(iris[,1:4])),
          dendrogram ="none", 
          trace="none",
          Rowv = F, cexRow = 0.8,
          Colv = F)

heatmap.2(as.matrix(t(iris[,1:4])),
          dendrogram ="column", # 樹狀圖
          cexRow = 0.8,
          trace="none")

symnum(corr)

# 根據相關係數矩陣畫出熱圖
heatmap.2(corr, Rowv=FALSE, symm=TRUE, trace="none",
          cexRow=0.8, cexCol=0.8,srtCol=45,srtRow =0 )

# RColorBrewer 
library(RColorBrewer)
# brewer.pal(色階數,"顏色")(切割數)；rev():colorkey由深到淺
cols = colorRampPalette(rev(brewer.pal(9, "Reds")))(1000) 
# cols = colorRampPalette(brewer.pal(9, "Reds"))(1000)
# matrix: 距離越短，關係越近 -> rev():顏色越深，距離越接近
heatmap.2(as.matrix(t(iris[,1:4])),dendrogram ="column",trace="none",
          cexRow=0.8, cexCol=0.8,srtCol=45,srtRow =0,
          col=cols,key=TRUE)

#### Plotly:interative graph








