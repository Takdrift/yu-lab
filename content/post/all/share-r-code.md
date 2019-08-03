---
title: "R code分享"  # 文章标题，在网也中显示的标题
date: 2019-04-13  # 创建日期
lastmod: 2019-04-14  # 最后修改日期
draft: false  # =true为草稿，不会生成相应的网页
#slug: ""  # 所生成网页的地址后缀，若未设置，会根据文件名生成地址
keywords: [R, 学习资料]  # 关键字
tags: [R, 学习资料]  # 标签，会将此文章添加到指定的标签下
categories: [R, 学习资料]  # 分类，会将此文章添加到指定的分类下
author: "Yu Group"  # 作者
---

# 前言

在这里，你可以分享你认为实用的R code，可以涉及**数据处理**、**数据可视化**、**统计模型**等。这样在为自己做笔记的同时也可以帮助到新人，同时大家也能互相学习。

下面会介绍R code的书写规范，如果你还不知道怎么使用这个博客系统，:point_right:[戳这里](/post/all/about-the-site)。

**R code示例书写规范：**

1. 先用二级标题注明代码用途`## 代码用途`

2. 如下输入**```R**开始代码书写，第一行用注释说明R code的**用途**及**作者**

   - ```markdown
     ​```R
     # 代码用途 by Author---- 
     ​```
     ```

   - **注：第一行注释完后输入4个**`-`**（这样复制到Rstudio中可以生成标题）**

3. 第二行开始具体代码的书写，尽量选择R**自带数据**(如`mtcars`)进行演示，若数据格式不同，需提供具体演示数据（目的是为了让别人可重复结果）

4. 对每一步进行注释，注释若是独立的一行则在**行首**输入`#`后**空1格**，然后开始注释，若注释紧接代码后面，**先空2格**，`#`，然后**空1格**进行注释。推荐阅读：[R代码书写规范](<https://google.github.io/styleguide/Rguide.xml>)）

目前分为**数据处理**、**统计模型**、**数据可视化**和**其他设置**四个板块（为**一级标题**），后续可逐渐增加  

- 每个示例可添加相应的**二级标题**，以便于通过目录查看

**Markdown语言如下：**

```markdown
## 代码用途
​```R
# 代码用途 by Author----
R code
# 注释为独立一行时，输入#后空1格再进行注释
R code  # 紧接代码的注释在代码后空2格，输入#后空1格再进行注释
​```
```


# 数据处理

## 删除重复值

```R
# 删除重复值 by Si Shuting----
baseold<-baseold[!duplicated(baseold[,c(7)]),]  # 按某列相同删除
```
## 分组计算均值 

```R
# 分组计算均值 by Si Shuting---- 
library(psych)  
myvars <- c("CA", "CU", "FE","MG","ZN","NL")
describeBy(NEBWL120[myvars], list(NEBWL120$性别)) #按性别分组描述myvars
```

# 数据可视化

## [画地图](/post/si-shuting/用r绘制地图/)

# 统计模型

# 其他设置

## 代理设置

某些需要用到google服务的包需要**科学上网**才能正常使用，故可通过以下方式在**Rstudio**中设置代理

```R
# 代理设置 by Shao Bule----
file.edit('~/.Renviron')  # 打开并编辑环境配置文件

# 打开后粘贴以下文本设置代理 line 5-line 12
options(internet.info = 0)

http_proxy="http://your_proxy:your_port"  # 输入代理IP和端口
# http_proxy_user=user:passwd  # 如果没有用户名和密码将这行注释掉

# 注意：https_proxy里不能写https://...仍然用http://
https_proxy="http://your_proxy:your_port"  # 输入代理IP和端口
# http_proxy_user=user:passwd  # 如果没有用户名和密码将这行注释掉

Sys.getenv("http_proxy")  # 查看代理信息
Sys.getenv("https_proxy")  # 查看代理信息
```

