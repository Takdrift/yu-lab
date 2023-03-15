---
title: "用gganimate制作动图"  # 文章标题，在网也中显示的标题
date: 2019-08-05  # 创建日期
lastmod: 2019-08-05  # 最后修改日期
draft: false  # =true为草稿，不会生成相应的网页
slug: "gif-with-gganimate"  # 所生成网页的地址后缀，若未设置，会根据文件名生成地址
keywords: [R, 学习资料, gganimate, ggplot, 数据可视化]  # 关键字
tags: [R, 地图, gganimate, ggplot, 动图, 数据可视化]  # 标签，会将此文章添加到指定的标签下
categories: [Shao Bule]  # 分类，会将此文章添加到指定的分类下
author: "Shao Bule"  # 作者
---

# 前言

> `gganimate` extends the grammar of graphics as implemented by [`ggplot2`](https://github.com/tidyverse/ggplot2) to include the description of animation. It does this by providing a range of new grammar classes that can be added to the plot object in order to customise how it should change with time.

动图的制作主要用到`gganimate`跟`ggplot2`两个包，`gganimate`[GitHub主页](https://github.com/thomasp85/gganimate#an-example)上有两个简单例子可供参考。

**下面的例子将使用1993-2018年[全国各省GDP](http://data.stats.gov.cn/easyquery.htm?cn=E0103)数据分别绘制[条形图](#条形图gif)动图与[地图](#地图gif)动图。**

# 条形图GIF

```R
# 绘制各地区GDP条形图动图 ----------------------------------------------------
library(ggplot2)
library(gganimate)
library(plyr)
library(dplyr) 
library(transformr)

# 导入GDP数据
gdp <- read.csv("https://raw.githubusercontent.com/Takdrift/pic-repo/master/GDP.csv")

# 获取年份变量位置
var.n <- which(grepl("^X", names(gdp)))  

# 将作图数据放入list中
gdp.list <- list()
for (i in 1:length(var.n)) {
  gdp.list[[i]] <- data.frame(loc = gdp$loc, gdp = gdp[,var.n[i]], year = 2019-i)
}

gdp.all <- bind_rows(gdp.list) # List转为数据框
gdp.all <- rename(gdp.all, NAME = loc)  # 变量重命名

# 设置中文字体
windowsFonts(H = windowsFont("微软雅黑"))  

# 绘图
# 在运行过程中可能会提示缺少某些依赖包，根据提示安装对应的包即可
gdp.ani <- ggplot(gdp.all,aes(x = reorder(NAME, gdp), gdp, fill = gdp))+  # 使用reorder语句根据gdp对NAME进行排序
  geom_bar(stat = "identity", position = "dodge", width = 0.8)+
  scale_fill_gradientn(name = "GDP(亿)", colours = c("#ABDDA4", "#F46D43", "#D53E4F"),  # colours为渐变色
                       breaks = c(10000,50000,90000),
                       limits = c(100,100000))+  # limits统一渐变色对应的范围
  coord_flip()+
  theme_bw()+
  theme(legend.position = "bottom", text = element_text(family = 'H',size = 16),
        legend.key.width = unit(2,"line"), legend.text = element_text(size = 10),
        legend.title = element_text(size = 12), legend.title.align = 0)+  # 设置字体及大小
  
  # Here comes the gganimate specific bits
  labs(title = 'Year: {frame_time}', x = '', y = '') +
  transition_time(as.integer(year)) +
  ease_aes('linear')  

# 生成动图并保存
animate(gdp.ani, fps = 8, duration = 20, 
        height = 777, width = 1280)  # GIF参数设置
anim_save("C:/DATA/PhD/R/地图作图-数据/GDP-8fps-20s.gif")
```

<div align=center><b>:point_down:最终效果:point_down:</b></div>


![](https://raw.githubusercontent.com/Takdrift/pic-repo/master/GDP-8fps-20s.gif)

# 地图GIF

地图绘制需要用到`GIS`的数据，具体见[斯斯](/categories/斯淑婷/)同学写的[《用R绘制静态地图》](/post/si-shuting/用r绘制地图/)的文章，或[点击下载GIS数据](https://uploads.cosx.org/2009/07/chinaprovinceborderdata_tar_gz.zip)。

```R
# 绘制各地区GDP变化动图（地图） ----------------------------------------------------

library(ggplot2)
library(gganimate)
library(plyr)
library(dplyr)
library(rgdal) 
library(transformr)

# 导入GDP数据
gdp <- read.csv("https://raw.githubusercontent.com/Takdrift/pic-repo/master/GDP.csv")

# 获取年份变量位置
var.n <- which(grepl("^X", names(gdp)))  

# 将作图数据放入list中
gdp.list <- list()
for (i in 1:length(var.n)) {
  gdp.list[[i]] <- data.frame(loc = gdp$loc, gdp = gdp[,var.n[i]], year = 2019-i)
}

gdp.all <- bind_rows(gdp.list) # List转为数据框
gdp.all <- rename(gdp.all, NAME = loc)  # 变量重命名

# 导入GIS数据
shape <- readOGR("C:/DATA/PhD/R/地图作图-数据/bou2_4p.shp")  

# 提取GIS中的绘制地图数据
AD1 <- shape@data  # shape中包含了很多部分的内容，此处data中含有我们绘图的各省名称NAME
AD2 <- data.frame(id = rownames(AD1),AD1)  # 将AD1转换为data.frame并增加id

# 将shape数据转为data.frame，这里用ggplot2包中的fortify函数直接转化成的data.frame
# 含有经纬度的信息，不含省份名称，但我们合并绘图数据时一般通过省份名称，所以用到上文的AD2
china_map1 <- fortify(shape)  
china_map_data <- join(china_map1, AD2, type = "full")  # 将china_map1和AD2通过此前增加的id合并，得到含省份名称的经纬度数据

# 通过省份NAME将china_map_data和绘图数据合并
china_data <- join(china_map_data, gdp.all, type = "full")

# 绘图(若绘制全部数据耗时较长)
# 在运行过程中可能会提示缺少某些依赖包，根据提示安装对应的包即可
gdp.map.ani <- ggplot(filter(china_data, is.na(year) == 0), aes(long, lat)) +  
  geom_polygon(aes(group = group, fill = gdp), colour = "grey40") +  # 绘制地图的语句 
  scale_fill_gradientn(name = "GDP(亿)", colours = c("#ABDDA4", "#F46D43", "#D53E4F"),  # 设置渐变色
                       breaks = c(10000,30000,50000,70000,90000),
                       limits = c(100,100000))+  # limits统一渐变色对应的范围
  coord_map("polyconic")+  # coord_map()函数解决地图绘制在笛卡尔坐标系中变扁平的问题
  theme(panel.grid = element_blank(),         
        panel.background = element_blank(),         
        axis.text = element_blank(),         
        axis.ticks = element_blank(),         
        axis.title = element_blank(),legend.position = c(0.95,0.5))+
  
# gganimate动图设置
  labs(title = 'Year: {frame_time}') +  # 标题
    transition_time(as.integer(year)) +  # 
    ease_aes('linear')  

# 生成动图并保存
animate(gdp.map.ani, fps = 8, duration = 20, 
        height = 425, width = 714)  # GIF参数设置
anim_save("C:/DATA/PhD/R/地图作图-数据/GDP-map-8fps-20s.gif")
```



<div align=center><b>:point_down:最终效果:point_down:</b></div>


![](https://raw.githubusercontent.com/Takdrift/pic-repo/master/GDP-map-8fps-20s.gif)

 
