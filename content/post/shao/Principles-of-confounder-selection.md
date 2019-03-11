---
date: 2019-03-10
title: "Principles of confounder selection"
#author: Shao
tags: [混杂,流行病,偏倚]
categories: [文献笔记]
comment: true
draft: false

#weight: 1 #是否置顶

#menu:
  #main:
    #parent: "邵"
    #weight: 1

typora-root-url: ..\..\..\static #定义图片根目录，后退三级
---


# Principles of confounder selection

[Tyler J. VanderWeele1](tvanderw@hsph.harvard.edu)
Received: 25 October 2018 / Accepted: 8 February 2019

*European Journal of Epidemiology* [full text](https://doi.org/10.1007/s10654-019-00494-6)

---

## 引言

> Epidemiologic analyses are often criticized on the grounds that some third factor might be responsible for the relationship between the exposure and the outcome under study i.e., that the groups receiving and not receiving the exposure are different from one another in some other important variable that is also related to the outcome.

流行病学研究中暴露与结局之间的关系经常会被质疑是由其他因素（混杂）介导的，如因素X在暴露组与非暴露组中的分布不同，且因素X与所研究的结局相关，因此所研究的暴露与结局之间的关联很可能是由因素X介导的。

因此，在研究设计时，需要充分考虑可能的混杂因素并收集相关资料，并在统计分析时对这些混杂因素进行调整（暴露组与非暴露组根据混杂因素分层后两组间具有可比性）。**但是，关键的问题是如何选择相应的混杂因素**。

> Principles that are sometimes put forward for making these decisions when knowledge of a causal diagram is unavailable include, for example, (i) control for all pre-exposure measured variables or (ii) control for all common causes of the exposure and the outcome. While these principles are often helpful, it has been noted that in certain settings they can lead to controlling for a covariate that in fact introduces bias.

在大多数情况下，当研究中的混杂因素较多，且混杂与混杂之间的因果关系不明确时，通常会使用如下原则：

- 控制所有在暴露因素之前测量的变量
- 控制所有与暴露和结局相关的变量

**这些方法在大多数情况下是有效的，但是有研究也发现这样可能会导致偏倚的产生（调整其中的某个变量可能会引入偏倚）。**

有时混杂因素的选择单纯基于统计的结果，比如某个协变量的加入是否会使暴露的参数估计改变超过10%，或者使用前进或者后退法，或者使用更加现代的机器学习法。然而，目前单纯基于统计分析的结果来确定混杂因素并不可靠，因为统计分析并不能确定**时间**的**先后**顺序。

**单纯基于统计并不能区分是“混杂”还是“ 中介变量”（若是 中介变量，则会引入偏倚）**

- 所以需要在统计结果的基础上，根据专业知识来帮助鉴别混杂和中介变量。





