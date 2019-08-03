---
title: "用R绘制静态地图"  # 文章标题，在网也中显示的标题
date: 2019-08-03  # 创建日期
lastmod: 2019-08-03  # 最后修改日期
draft: false  # =true为草稿，不会生成相应的网页
#slug: ""  # 所生成网页的地址后缀，若未设置，会根据文件名生成地址
keywords: [R, 学习资料]  # 关键字
tags: [R, 学习资料]  # 标签，会将此文章添加到指定的标签下
categories: [R, 学习资料]  # 分类，会将此文章添加到指定的分类下
author: "Si Shuting"  # 作者
---



## Method 1. 使用`ggplot`绘制

准备工作，当然先得拥有绘制地图的数据啦，一般多采用`GIS`的数据~，还有在[GADM](<https://gadm.org/download_country_v3.html>)也有世界各地的地图数据（不过我下载后没能成功读入R中，大家可以再试试哈），本文绘图采用的`GIS`的数据。

首先，点击[GIS数据](https://uploads.cosx.org/2009/07/chinaprovinceborderdata_tar_gz.zip)下载压缩包（包含bou2_4p.dbf、bou2_4p.shp 和 bou2_4p.shx三个文件）

然后，就开始敲R代码啦

**# 载入GIS数据,有用`maptools`包中的`readShapePoly()`函数，但我又失败啦，是`rgdal`拯救了我**

```R
library(rgdal)   
shape<-readOGR("D:/R-3.5.2/bou2_4p.shp")  # 修改自己保存bou2_4p.shp时相应的路径
```

**# 提取GIS中的绘制地图数据**

```R
AD1 <- shape@data  # shape中包含了很多部分的内容，此处data中含有我们绘图的各省名称NAME
AD2 <- data.frame(id=rownames(AD1),AD1)  # 将AD1转换为data.frame并增加`id
```

**# 将shape数据转为`data.frame`，这里用`ggplot2`包中的` fortify`函数直接转化成的`data.frame`含有经纬度的信息，不含省份名称，但我们合并流行病学数据时一般通过省份名称，所以用到上文的AD2**

```R
library(ggplot2)
china_map1 <- fortify(shape)  
library(plyr)
china_map_data <- join(china_map1,AD2, type = "full")  # 将china_map1和AD2通过此前增加的id合并，得到含省份名称的经纬度数据
```

**# 获取需要呈现的流行病学数据**

```R
NAME<-c("北京市",  "重庆市", "福建省",  "广东省", "广西壮族自治区",  "黑龙江省",  "河南省",  "湖北省", "江西省",  "吉林省",  "上海市",  "天津市", "新疆维吾尔自治区", "浙江省", "安徽省",  "甘肃省",  "贵州省",  "海南省",  "河北省",  "湖南省", "江苏省",   "辽宁省", "内蒙古自治区", "宁夏回族自治区",  "青海省",   "山东省", "山西省",  "陕西省","四川省", "台湾省", "西藏自治区",  "香港特别行政区",  "云南省")
pre<-c(3.09, NA,2.96, 6.64,5.96,28.25,7.78, 0.11,5.86,1,0.63,12.7, 3.53,4.3,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA)
rate<-as.data.frame(cbind(NAME,pre))  
rate$pre<-as.numeric(as.character(rate$pre))
```

**# 通过省份`NAME`将`china_map_data`和流行病学数据`rate`合并**

```R
china_data <- join(china_map_data, rate, type="full")
```

**# 将rate分组，目的是后续画图时不同的rate呈现不同的颜色**

```R
china_data$rate_g<-ifelse(china_data$rate<2,"1(<2.0%)",ifelse(china_data$rate<4,"2(2.0-4.0%)",ifelse(china_data$rate<6,"3(4.0-6.0%)",ifelse(china_data$rate<8,"4(6.0-8.0%)",ifelse(china_data$rate<15,"5(8.0-15.0%)","6(15.0-50.0%)")))))
```

**# 获取各个省份标签的经纬度信息**

```R
midpos <- function(x) mean(range(x,na.rm=TRUE))  # 构建提取各省中间位置经纬度的函数
centres <- ddply(china_data,.(NAME),colwise(midpos,.(long,lat)))
```

**# 载入上步获取各个省份标签的经纬度**

```R
library(openxlsx)
dat<-read.xlsx("E:/地图/map.xlsx",sheet = "map2")  # `dat`是上一步`centres `中选取的要标签的省份名称的经纬度，并根据实际成图情况进行微调
```

**# 采用`ggplot2`绘制地图并呈现流行病学信息**

```R
ggplot(china_data, aes(long, lat)) +  
geom_polygon(aes(group = group, fill = rate_g),colour="grey40") +  # 多边形  
  scale_fill_brewer(palette="Blues",labels=c("<2.0", "2.0~", "4.0~", "6.0~", "8.0~", "15.0~","no data"),labs(fill="Detection rate,% "))+  
  coord_map("polyconic")+  # coord_map()函数解决地图绘制在笛卡尔坐标系中变扁平的问题
  geom_text(aes(x = jd,y = wd, label = 城市), cex=3,data =dat)+  # 添加省份名称标签
  theme(          panel.grid = element_blank(),         
                  panel.background = element_blank(),         
                  axis.text = element_blank(),         
                  axis.ticks = element_blank(),         
                  axis.title = element_blank(),legend.position = c(0.95,0.5))
```

<div align=center><b>这就绘制成功啦，上图:point_down:</b></div>

![rate](用r绘制地图.assets/rate.png)

##  Method 2. 使用`plot`绘制

```R
library(maps)
library(mapdata)

map("china")  # 用map直接就绘出地图轮廓啦~ 

library(maptools)

library(rgdal)
x=readOGR("D:/R-3.5.2/bou2_4p.shp")  # 载入GIS数据
plot(x)
plot(x,col=gray(924:0/924))
```

```R
#编的一个函数，用来生成所需的col向量
getColor = function(mapdata, provname, provcol, othercol){
  f = function(x, y) ifelse(x %in% y, which(y == x), 0)
  colIndex = sapply(mapdata@data$NAME, f, provname)
  col = c(othercol, provcol)[colIndex + 1]
  return(col);
}
par(mar=rep(0,4))

provname = c("北京市", "重庆市", "福建省", "广东省","广西壮族自治区","黑龙江省","河南省","湖北省 ","江西省","吉林省","上海市","天津市","新疆维吾尔自治区","浙江省")
pop= c(3.09,   0.00,  2.96,   6.64, 5.96, 28.25,7.78, 0.11,5.86, 1.00, 0.63,12.70,  3.53,4.30)
provcol = rgb(red = 1 - pop/50/1, green = 1-pop/50/1, blue =1)#通过RGB根据本数据设置渐变色，其中50为各亚组中最大的值方便组建比较
```

```R
#设置图例位置并绘制地图
nf <- layout(matrix(c(1,1,1,1,1,2,1,1,1),3,3,byrow=TRUE), c(3,1), c(3,1), TRUE)
layout.show(nf)
plot(x, col = getColor(x, provname, provcol, "white"), xlab = "", ylab = "")

library(openxlsx)
dat<-read.xlsx("E:/地图/map.xlsx",sheet = "map2")##要标记的地点的经纬度
text(dat$jd, dat$wd, dat[, 1], cex = 1, col = rgb(0,
                                                    0, 0, 0.9), pos = c(2, 4, 4, 4, 3, 4, 2, 3, 4, 2, 4, 2, 2,
                                                                        4, 3, 2, 1, 3, 1, 1, 2, 3, 2, 2, 1, 2, 4, 3, 1, 2, 2, 4, 4, 2))
par(mar=c(1,1,2,0),cex=0.5)
barplot(as.matrix(rep(1,14)),col=sort(provcol,dec=T),horiz=T,axes=F,border = NA )
axis(1,seq(1,14,by=1),sort(pop[seq(1,14,by=1)]))
```



**总结：**

1. Method 2绘制出来的感觉略丑，且图例设置还不是很明白（┭┮﹏┭）

2. 最后本人较推荐采用Method 1的ggplot绘制，参数设置也较好理解  

**参考链接：**

1. [用 R 软件绘制中国分省市地图](<https://cosx.org/2009/07/drawing-china-map-using-r/>)
2. [用R语言复盘美国总统大选](<https://zhuanlan.zhihu.com/p/23615582>)
3. [怎么用R语言绘制英文中国地图，标注英文省名，以及在不同的省份填充指定的颜色？](<https://www.zhihu.com/question/41230152>)

 



