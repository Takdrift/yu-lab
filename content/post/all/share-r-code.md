---
title: "R code分享"  # 文章标题，在网也中显示的标题
date: 2019-04-13  # 创建日期
lastmod: 2019-11-22  # 最后修改日期
draft: false  # =true为草稿，不会生成相应的网页
#slug: ""  # 所生成网页的地址后缀，若未设置，会根据文件名生成地址
keywords: [R, 学习资料]  # 关键字
tags: [R, 学习资料]  # 标签，会将此文章添加到指定的标签下
categories: [R]  # 分类，会将此文章添加到指定的分类下
author: "Yu Group"  # 作者
---

## 前言

在这里，你可以分享你认为实用的R code，可涉及[数据处理](#数据处理)、[数据可视化](#数据可视化)、[统计模型](#统计模型)等，在为自己做笔记的同时也可以帮助到别人。

下面介绍R code的范例与代码书写规范，如果你还不知道怎么使用这个博客系统，:point_right:[戳这里](/post/all/about-the-site)。

**R code范例：**

1. 先用二级标题注明代码用途`## 代码用途`

2. 如下输入```R开始代码书写，第一行用注释说明R code的**用途**及**作者**  

   ~~~markdown
   ```R
   # 代码用途 by Author---- 
   ```
   ~~~

   **注：第一行注释完后输入4个或以上**`-`**（这样复制到Rstudio中可以生成标题）**

3. 第二行开始具体代码的书写，尽量选择R**自带数据**(如`mtcars`)进行演示，或提供具体演示数据（目的是为了让别人可重复结果） 

4. 对每一步进行注释



:bulb: 每个示例可添加相应的**二级标题**，便于在网页上通过目录查看。  



### 代码书写规范

下面总结几点比较重要的代码书写规范，具体见[Google's R Style Guide](https://google.github.io/styleguide/Rguide.xml)和 [Tidyverse Style Guide](https://style.tidyverse.org/)(推荐后者)

1. 变量名与函数名使用**小写字母**、数字与`_`（同文件命名），变量名使用**名词**，函数名使用**动词**。
2. 每行不超过**80**个字符。
3. 代码缩进时使用**2个空格**，**不**使用`Tab`键。
4. `=`, `+`, `-`, `<-`这些符号两边都需要有**1个空格**。
5. 用`<-`而**不要**使用`=`赋值
7. 注释若是独立的一行则在**行首**输入`#`后**空1格**，然后开始注释；若注释紧接代码后面，**先空2格**，`#`，然后**空1格**进行注释。

## 数据处理

### data mining with R

详见这篇文章（海波整理）：[Data mining with R](/post/zhou-haibo/data_mining_with_r)

### 删除重复值
```R
# 删除重复值 by Si Shuting----
baseold<-baseold[!duplicated(baseold[, c(7)]),]  # 按某列相同删除
```

### 分组计算均值 

```R
# 分组计算均值 by Si Shuting---- 
library(psych)  
myvars <- c("CA", "CU", "FE","MG","ZN","NL")
describeBy(NEBWL120[myvars], list(NEBWL120$性别))  # 按性别分组描述myvars
```

### list转data.frame

```R
# 将list转为data.frame By Shao----
library(dplyr)  # 转换用到的bind_rows函数属于dplyr包

# 生成list数据
list1 <- list(x = c('A', 'B', 'C', 'D'), y = c(1, 2, 3, 4))
list2 <- list(x = c('X', 'Y', 'Z'), y = c(24, 25, 26))

df <- bind_rows(list1, list2) # List转为数据框
```

## 数据可视化

### ggpubr

[ggpubr: Publication Ready Plots](http://www.sthda.com/english/articles/24-ggpubr-publication-ready-plots/)

ggpubr Key features:

- Wrapper around the **ggplot2** package with a **less opaque syntax** for beginners in R programming.
- Helps researchers, with non-advanced R programming skills, to create easily **publication-ready plots**.
- Makes it possible to automatically **add p-values and significance levels** to box plots, bar plots, line plots, and more.
- Makes it easy to **arrange and annotate multiple plots** on the same page.
- Makes it easy to **change grahical parameters** such as colors and labels.

### ggarrange拼图  

[ggplot2 - Easy Way to Mix Multiple Graphs on The Same Page](http://www.sthda.com/english/articles/24-ggpubr-publication-ready-plots/81-ggplot2-easy-way-to-mix-multiple-graphs-on-the-same-page/)

example:

<img src="https://raw.githubusercontent.com/Takdrift/pic-repo/master/arrange-multiple-ggplots.png" alt="ggarrange" style="zoom: 50%;" />

### Radar Chart（雷达图）

可以通过[`fmsb`](https://www.datanovia.com/en/blog/beautiful-radar-chart-in-r-using-fmsb-and-ggplot-packages/) 包绘制Radar Chart（雷达图）。

<img src="https://www.datanovia.com/en/wp-content/uploads/dn-tutorials/r-tutorial/figures/radar-chart-in-r-customized-fmstb-radar-chart-1.png" style="zoom: 50%;" />

### 静态地图

详见这篇文章：[用R绘制地图](/post/si-shuting/用r绘制地图/)

### 交互式地图

详见这篇文章：[用R绘制交互式地图](/post/shao-bule/用r绘制交互式地图/)

### GIF

详见这篇文章：[用gganimate制作动图](/post/shao-bule/用gganimate制作动图/)

## R Markdown

### HTML加密

若发可能布含有敏感信息的内容时，用[`fidelius`](https://github.com/mattwarkentin/fidelius)包对HTML加密是一个不错的选择。安装该包，并在R Markdown YAML信息中做相应设置即可输出加密的HTML。在正式发布前可以设置`preview: true`，这样在本地预览时会忽略密码。

> 注：如果发布了加密的HTML，源R Markdown文本请注意不要放在公开的网站

```R
---
title: "My Protected Document"
output:
  fidelius::html_password_protected:
    password: "password"  # the password
    hint: "Hint for password"  # hint for the password
    preview: true  # true: will generate the HTML without password
    output_format:  # use a customized format 
      rmarkdown::html_document:  
        toc: true
---
```

### 输出SVG图片格式

可在每个图片单独的`Chunk`里设置`dev`参数，也可以在文档开头进行全局设置。

~~~R
```{r setup, include=FALSE}
knitr::opts_chunk$set(dev = 'svg', echo = FALSE, warning = FALSE, message = FALSE)
```
~~~

### 图片中文乱码

当输出的图片设置了SVG格式时，会出现图片里中文不能显示的问题。[解决的方法](https://d.cosx.org/d/420903-r-markdown-svg/3)就是在图片代码的`Chunk`里设置`fig.showtext = TRUE`。

~~~R
```{r plot, fig.width = 8, fig.height = 8, fig.align = 'center', fig.showtext = TRUE}
~~~

### 中文字体

想要在输出的图片中设置不同的字体，需要导入系统中的字体，具体代码如下。

```R
# 载入系统字体
windowsFonts(               # define fonts, Mac: quartzFonts()  
  caiyun = windowsFont("华文彩云"),  
  fangsong = windowsFont("华文仿宋"),  
  xingkai = windowsFont("华文行楷"),  
  kaishu = windowsFont("华文楷体"),  
  lishu = windowsFont("华文隶书"),  
  zhongsong = windowsFont("华文中宋"),  
  xihei = windowsFont("华文细黑"),  
  yahei = windowsFont("微软雅黑"),  
  xinwei = windowsFont("华文新魏"),  
  youyuan = windowsFont("幼圆")  
)   

# 设置字体函数theme_font，默认为微软雅黑，方便ggplot2作图时快速统一修改图片中的字体
theme_font <- function(font_family = 'yahei') {
  theme(
    title = element_text(family = font_family),
    text = element_text(family = font_family),
    plot.title = element_text(family = font_family),
    strip.text = element_text(family = font_family),
    axis.title = element_text(family = font_family),
    axis.text = element_text(family = font_family),
    legend.text = element_text(family = font_family),
    legend.title = element_text(family = font_family)
  )
}

# p为ggplot作图数据，只需要加上theme_font()函数即可修改图片字体
p + theme_font()  # 默认为微软雅黑

# 修改字体
p + theme_font('kaishu')  # 华文行楷
```



## 统计模型

## 其他

### 代码整理

自动整理R代码的包`formatR`，可以将不规范的代码转换为规范的书写格式，formatR:point_right:[主页](https://yihui.name/formatR)

```R
tidy_source(width.cutoff = 50)  # 将剪切板上的代码自动整理， width.cutoff为每行字符数
```

Two applications of `tidy_source()`:

- `tidy_dir()` can reformat all R scripts under a directory
- `usage()` can reformat the usage of a function, e.g. compare `usage()` with the default output of `args()`:

`usage()`相较于`args()`可以更多样化地输出函数的完整语句同参数，见下面的例子

```R
library(formatR)
usage(glm, width = 40)  # can set arbitrary width here
## glm(formula, family = gaussian, data,
##     weights, subset, na.action,
##     start = NULL, etastart, mustart,
##     offset, control = list(...),
##     model = TRUE, method = "glm.fit",
##     x = FALSE, y = TRUE,
##     singular.ok = TRUE,
##     contrasts = NULL, ...)
args(glm)
## function (formula, family = gaussian, data, weights, subset, 
##     na.action, start = NULL, etastart, mustart, offset, control = list(...), 
##     model = TRUE, method = "glm.fit", x = FALSE, y = TRUE, singular.ok = TRUE, 
##     contrasts = NULL, ...) 
## NULL
```

### 代理设置

某些需要**科学上网**才能正常使用的包可通过以下方式在**Rstudio**中设置代理（设置完后需重启`R`）

```R
# 代理设置 by Shao Bule----
file.edit('~/.Renviron')  # 打开并编辑环境配置文件

# 打开后粘贴以下文本设置代理 line 5-line 12
options(internet.info = 0)

http_proxy = "http://your_proxy:your_port"  # 输入代理IP和端口
# http_proxy_user = user:passwd  # 如果没有用户名和密码将这行注释掉

# 注意：https_proxy里不能写https://...仍然用http://
https_proxy = "http://your_proxy:your_port"  # 输入代理IP和端口
# http_proxy_user = user:passwd  # 如果没有用户名和密码将这行注释掉

Sys.getenv("http_proxy")  # 查看代理信息
Sys.getenv("https_proxy")  # 查看代理信息
```

### 中文乱码

若RStudio中出现中文乱码，可尝试运行Sys.setlocale("LC_ALL","Chinese")，或在.\etc\Rprofile.site加一行`Sys.setlocale("LC_ALL","Chinese")`
