---
title: "R Code分享"
date: 2019-04-13
lastmod: 2019-04-13
draft: false
#slug: ""
keywords: [R, 学习资料]
tags: [R, 学习资料]
categories: [R, 学习资料]
author: "Yu Group"
---

```R
memory.limit(102400)
#删除重复
baseold<-baseold[!duplicated(baseold[,c(7)]),]#按某列相同删除

#排序
attach(coji)
cocj <- cocj[order(xh, kcmc,-cj),] #按学号、课程名称和成绩降序排序
detach(cocj)
cocj<-cocj[!duplicated(cocj[,c(1,4)]),]#学号和课程名称相同取成绩高的一次



#筛选
library(dplyr)
jxjpxhs<-filter(jxjpxhs, jxjpxhs$xm!="金丹"&jxjpxhs$xm!="李莉"&jxjpxhs$xm!="王敏"&jxjpxhs$xm!="杨帆"&jxjpxhs$xm!="张波"&jxjpxhs$xh!="20718143")



#读取SAS文件
library(haven)
oldfb<-read_sas("E:/舟山数据汇总/2017舟山数据/FB/fb_scsfjl.sas7bdat")
#添加行合计
DOCTCk10$rycj<-rowSums(DOCTCk10[,c("jxjzf","ryf")],na.rm ="TRUE")

options (scipen =200)
#读取xlsx的数据
install.packages("openxlsx")
library(openxlsx)#读取xlsx的数据
a1<-read.xlsx("E:/YIWU/T12018.xlsx",sheet=1)
#读取xlsx数据要记得excel编码更改为UTF-8

#重命名
library(reshape)
qfe2<- rename(qfe2,c(id1="ID1"))
qfe2<- rename(qfe2,c(ID1="id1"))


# 字符串查询 -------------------------------------------------------------------
grepl("实习", c("s实习","g实"), ignore.case = FALSE, perl = FALSE,
      
      fixed = FALSE, useBytes = FALSE)

#转日期格式
install.packages("lubridate")
library(lubridate)
fb$YCQ1<- sub('月','',fb$YCQ)#将中文去除
fb$YCQ1<-dmy(fb$YCQ1)#用dmy函数直接转换日期

vitd$sampleDate<- as.Date(vitd$sampleDate,origin = "1960-01-01")#origin = "1960-01-01"这样导入的数据就不是数值了

#构建卡方检验的函数
## using sapply function
multi.xtabs <- function(df, vars, group.var, ...) {
  sapply(simplify = FALSE,
         vars,                                                        # Loop for each element of vars
         function(var) {
           formula <- as.formula(paste("~", var, "+", group.var))   # Create formula
           xtabs(data = df, formula, ...)                           # Give formula to xtabs
         }
  )
}

## Create a list of cross tables
table <- multi.xtabs(df = mtcars, 
                     vars = c("am","cyl","gear"), 
                     group.var = "vs")



## Construct column percentage table (use margin = 2)
table.p <- lapply(table, prop.table, margin = 2)

## Perform Fisher's exact test
chisq.result <- lapply(table, chisq.test)

## Extract p-values
table.pvalue <- sapply(chisq.result, "[[", "
```

