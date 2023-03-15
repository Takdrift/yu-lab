---
title: "用R绘制交互式地图"  # 文章标题，在网也中显示的标题
date: 2019-08-03  # 创建日期
lastmod: 2019-08-03  # 最后修改日期
draft: false  # =true为草稿，不会生成相应的网页
slug: "interactive-map-r"  # 所生成网页的地址后缀，若未设置，会根据文件名生成地址
keywords: [R, 学习资料, Leaflet]  # 关键字
tags: [R, 地图, Leaflet]  # 标签，会将此文章添加到指定的标签下
categories: [Shao Bule, R]  # 分类，会将此文章添加到指定的分类下
author: "Shao Bule"  # 作者
---

# 前言

> [Leaflet](http://leafletjs.com/) is one of the most popular open-source JavaScript libraries for interactive maps. It’s used by websites ranging from [The New York Times](http://www.nytimes.com/projects/elections/2013/nyc-primary/mayor/map.html) and [The Washington Post](http://www.washingtonpost.com/sf/local/2013/11/09/washington-a-world-apart/) to [GitHub](https://github.com/blog/1528-there-s-a-map-for-that) and [Flickr](https://www.flickr.com/map), as well as GIS specialists like [OpenStreetMap](http://www.openstreetmap.org/), [Mapbox](http://www.mapbox.com/), and [CartoDB](http://cartodb.com/). This R package makes it easy to integrate and control Leaflet maps in R.



交互式地图是通过`Leaflet`这个包完成的，上面这段`Leaflet`的介绍摘自`Leaflet`的[GitHub主页](https://rstudio.github.io/leaflet/)，该包的详细介绍及更详细的参数设置可查看该主页。

# 地图数据

地图绘制需要用到`GIS`的数据，具体见[斯斯](/categories/斯淑婷/)同学写的[《用R绘制静态地图》](/post/si-shuting/用r绘制地图/)的文章，或[点击下载GIS数据](https://uploads.cosx.org/2009/07/chinaprovinceborderdata_tar_gz.zip)。

下载完毕后解压出bou2_4p.dbf、**bou2_4p.shp** 和 bou2_4p.shx三个文件（后续会用到bou2_4p.shp文件）

下面的例子将使用各省的气温数据做演示

# R代码

```R
# 绘制交互式地图 --------------------------------------------------------------------

# 下载并载入leaflet包
install.packages("leaflet") 
library(leaflet)

# 读取GIS数据
map <- readOGR("C:/bou2_4p.shp")  # 导入GIS数据

# 读取需要绘制的数据并合并至map
tp <- read.csv("https://raw.githubusercontent.com/Takdrift/pic-repo/master/temperature.csv")
map2 <- merge(map, tp, by = "NAME") 

# 设置鼠标点击后显示的内容
i_popup <- paste0("<strong>省份: </strong>", map2$NAME, 
                  "<br>", "<strong>气温: </strong>", map2$Temparature, "°C") 

# 设置legend颜色范围 
pal <- colorBin(c("#7acfdf", "#fde3d9", "#f47645" ),  # 选择渐变的颜色范围
                map2@data$Temparature, na.color = "#FFFFFF",  # 选择对应的变量以及数据缺失区域颜色
                bins = c(28, 30, 32, 33, 35, 37, 39, 42))  # 设置legend的范围
# 绘制地图 
leaflet(map2) %>% 
  addTiles() %>% 
  setView(103.842773, 34.597042, zoom = 4) %>%  # 设置地图的中心点与缩放比例
  addPolygons(fillColor = ~pal(map2$Temparature), fillOpacity = 0.8,  # 绘制地图并根据所选变量填充对应区域
              color = "#000000", weight = 1, popup = i_popup) %>%  # color为边界线颜色，weight为粗细
  addLegend(pal = pal, values = map2@data$Temparature, position="bottomright",  # 添加图例
            labFormat = labelFormat(suffix = "°C"), title = "气温")  # 增加图例后缀与title
```



<div align=center><b>:point_down:最终效果:point_down:</b></div>
<div align=center><sub>鼠标点击会显示具体数据</sub></div>
 <Iframe src="/webpage/map-temperature.html"; 
        width="620" height="650" scrolling="no" frameborder="0"></iframe>
