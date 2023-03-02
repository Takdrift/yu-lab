---
title: "Quantile Regression"  # 文章标题，同时为博客页显示的标题
date: 2023-03-01  # 创建日期
lastmod: 2023-03-01  # 最后修改日期
draft: false  # true为草稿，不会生成网页，!!!需改为false才能生成网页!!!
# slug: ""  # 所生成网页的地址后缀，若未设置，会根据文件名生成地址
mathjax: true
# keywords, tags, categories都可以设置多个，中间需要用英文逗号隔开
keywords: [R]  # 关键字
tags: [R]  # 标签，会将此文章添加到相应的标签下（参考已有标签，防止相同含义的不同标签）
categories: [周海波]  # 分类，会将此文章添加到指定的分类下（建议使用各自的姓名，且只设置一个分类）
author: "周海波"  # 作者，会显示在文末
# math: true
# markup: 'mmark'
# !!!若文章有引用本地图片，则该markdown文件文件名中不能有空格也不能有大写字母（hugo编译时会自动将空格转为-，
# 并将大写字母转为小写导致图片引用路径出错）!!!
---

## 最小二乘法/线性回归
### 数据预处理
可以选择将结局变量二分，这样可能更具备临床意义，但是可能会掩盖掉前述中因素对不同分位数婴儿有不同影响的情况[^1]。

## 偏最小二乘法
首先要将所有变量进行[[数据标准化]]。

### 优缺点
偏最小二乘法可以解决小样本过多变量间存在多重共线性的问题，但是偏最小二乘的回归系数难以解释。

## 分位数回归
### 什么是分位数回归
对一个随机变量 $X$和任意$x$一个 $0$ 到 $1$ 之间的数 $\Gamma$， 如果 $X$ 的取值 $x$ 满足 $prob(X\le)=\Gamma$ ，则 $x$ 是 $X$ 的 $\Gamma$ 分位数。上述过程语言表述为，在某个样本集中，从小至大排列之后，小于某值的样本子集占总样本集的比例。
$$
d(\mu)=\sum_{i=1}^k\left(y_i-\mu\right)^2
$$

$$
d(\mu)=k \mu^2-2 \mu \sum_{i=1}^k\left(y_i\right)+\sum_{i=1}^k\left(y_i^2\right)
$$
其实我也看不懂这些破玩意，但是，我们只需要记住，线性回归最后计算出来的是条件**期望均值**，相应的，分位数回归计算的是**期望分位数值**（中位数，上四分位数，下四分位数等），分位数回归是线性回归的延伸。下面是分位数回归的示意图。
- 


### 何时可以考虑使用分位数回归

- 结局变量分布不符合正态分布时
- 当关注条件分位数结果的时候，比如劳动经济学家想要探究高收入女性是否更难获得升职机会，就需要关注女性群体收入的90%分位数的水平。
- 不同中心趋势和统计离散度的测量方法可以帮助获得对变量之间关系更全面的分析
- 画成长曲线[^2]

### 优缺点

- 不容易受到极端值的影响
- 可以发现更细致的关联，比如变量在结局的不同范围内有不同的影响

### stata 代码

```stata
net from http://www.stata.com/data/jwooldridge/
net describe eacsap
net get eacsap

ssc install  grqreg, replace
qreg tz_xse physical_exam_n # 拟合线性回归
grqreg, ci title(Fig.1a) # 作分位数回归图

webuse womenwk,clear
qreg wage age education i.married children i.county # 先拟合线性回归图
qregplot age education i.married children, q(5(2.5)95) ols # 这里一定要记住，不要比因变量写进去，如果写进去就会报错

```




### R代码


```R
library(quantreg)
data(mtcars)
rqfit <- rq(mpg ~ wt, data = mtcars)
summary(rqfit)

multi_rqfit <- rq(mpg ~ wt, data = mtcars, tau = seq(0, 1, by = 0.1))

plot(sumQR)

```
R语言可能的报错

>
Error in base::backsolve(r, x, k = k, upper.tri = upper.tri, transpose = transpose,  : 
  singular matrix in 'backsolve'. First zero in diagonal [1]
In addition: Warning message:
In summary.rq(xi, U = U, ...) : 2216 non-positive fis


首先，看这个矩阵是不是方阵（即行数和列数相等的矩阵。若行数和列数不相等，那就谈不上奇异矩阵和[非奇异矩阵](https://baike.baidu.com/item/%E9%9D%9E%E5%A5%87%E5%BC%82%E7%9F%A9%E9%98%B5?fromModule=lemma_inlink)）。 然后，再看此矩阵的行列式|A|是否等于0，若等于0，称矩阵A为奇异矩阵；若不等于0，称矩阵A为非奇异矩阵。 同时，由|A|≠0可知矩阵A可逆，这样可以得出另外一个重要结论:[可逆矩阵](https://baike.baidu.com/item/%E5%8F%AF%E9%80%86%E7%9F%A9%E9%98%B5?fromModule=lemma_inlink)就是非奇异矩阵，非奇异矩阵也是可逆矩阵。　如果A为奇异矩阵，则AX=0有无穷解，AX=b有无穷解或者无解。如果A为非奇异矩阵，则AX=0有且只有唯一[零解](https://baike.baidu.com/item/%E9%9B%B6%E8%A7%A3?fromModule=lemma_inlink)，AX=b有唯一解。
而在线性回归中如果自变量数目大于样本数，也会出现奇异矩阵导致无法求解。[^3]

### 文献分享
#### Purpose
本研究的目的是利用分位数回归（quantile regression, QR）方法，确定父母养育子女在人机关系敏感性（interpersonal sensitivity, IS）的各个量化水平上可能存在的差异。因此，本研究利用几十年来的四个横断面数据，重新审视了父母抚养和IS之间的既定关联。本研究假设，在不同的IS水平上，父母的抚养方式的影响程度不一样
。


#### data processing


![](https://s2.loli.net/2023/03/01/iljmfa2syXADdBL.jpg)


#### Definition

人际敏感（IS）是一种心理特征，其定义是个体在人际交往中对缺乏自我的感觉过度敏感

#### sampling 

本文介绍的研究结果来自1999年、2006年、2009年和2016年在中国哈尔滨进行的关于青少年IS的多项横断面研究。采用多阶段抽样方法（分层随机分组），从中国哈尔滨的一个地区选出四所学校。在这四所学校中，两所是重点学校，两所是普通学校。第二阶段是按年级进行整群抽样。在所选学校的每个年级（7、8、10、11年级）中，以两个班级为单位，抽取被调查者。这些学生的年龄从12岁到20岁不等，正从儿童的角色向成人的角色过渡。这四项调查是按照上述的调查程序进行的。
根据横断面调查的样本量公式$(N=μ2α2π(1-π)/δ2)$，在误差容限不超过3%的情况下，测量了约683名参与者的样本。为了避免无效的问卷，我们确定每次调查的样本量约为800人。因此，在四个调查时间点共发放了3441份问卷。

#### Measurement

_Symptom Checklist-90-Revision (SCL-90-R)_

> 该量表采用里克特五点量表，问题如下，该量表从以下九个方面询问过去一周受访者的烦恼
> somatization；obsessive-compulsive，IS，depression，anxiety，hostility，phobic anxiety，paranoid ideation，psychoticism
> 该量表还有抽取出来的九条简化版
> Feeling critical of others，Feeling shy opposite sex，Feeling easily hurt，Others are unsympathetic，People dislike you，Feeling inferior to others，Uneasy when people are watching you，Self-conscious with others，Uncomfortable eating/drinking in public
> 

 _Egna Minnen av. Barndoms Uppfostran (EMBU)_

> 用于评估对父母抚养的记忆，该量表从以下四个方面评估，rejection，emotional warmth，over-protection, favoritism.
> 初始量表包括十一个方面，father rearing| emotional warmth, F1; punishment, F2; overinvolvement, F3; favoritism, F4; rejection, F5; overprotection, F6;Mother rearing|emotional warmth, M1; overinvolvement and overprotection, M2; rejection, M3; punshment, M4; favoritism, M5). Meanwhile, t 


#### Table 1 Correlations between SCL-90 internal subscales and between items within the IS subscale (_n_ = 3345)
| SOM                                                           | O-C   | I-S   | DEP   | ANX   | HOS   | PHOB  | PAR   | PSY   | Other |
|---------------------------------------------------------------|-------|-------|-------|-------|-------|-------|-------|-------|-------|
| SOM                                                           | 1     |
| O-C                                                           | 0.65a | 1     |
| I-S                                                           | 0.6a  | 0.76a | 1     |
| DEP                                                           | 0.67a | 0.77a | 0.83a | 1     |
| ANX                                                           | 0.75a | 0.76a | 0.77a | 0.82a | 1     |
| HOS                                                           | 0.6a  | 0.65a | 0.69a | 0.69a | 0.71a | 1     |
| PHOB                                                          | 0.56a | 0.59a | 0.64a | 0.63a | 0.7a  | 0.52a | 1     |
| PAR                                                           | 0.61a | 0.72a | 0.8a  | 0.76a | 0.75a | 0.69a | 0.58a | 1     |
| PSY                                                           | 0.68a | 0.75a | 0.78a | 0.81a | 0.81a | 0.68a | 0.62a | 0.77a | 1     |
| Other                                                         | 0.65a | 0.67a | 0.66a | 0.70a | 0.71a | 0.63a | 0.54a | 0.63a | 0.71a | 1 |
| The correlation between the items (number) in the IS subscale |
| Feeling critical of others                                    | 1     |
| Feeling shy opposite sex                                      | 0.26b | 1     |
| Feeling easily hurt                                           | 0.31b | 0.37b | 1     |
| Others are unsympathetic                                      | 0.33b | 0.33b | 0.49b | 1     |
| People dislike you                                            | 0.33b | 0.31b | 0.48b | 0.64b | 1     |
| Feeling inferior to others                                    | 0.28b | 0.29b | 0.48b | 0.47b | 0.51b | 1     |
| Uneasy when people are watching you                           | 0.32b | 0.33b | 0.51b | 0.48b | 0.45b | 0.53b | 1     |
| Self-conscious with others                                    | 0.35b | 0.32b | 0.52b | 0.51b | 0.53b | 0.48b | 0.52b | 1     |
| Uncomfortable eating/drinking in public                       | 0.23b | 0.25b | 0.32b | 0.33b | 0.35b | 0.34b | 0.38b | 0.42b | 1     |
Note. SOM: somatization; O-C: obsessive-compulsive; I-S: interpersonal sensitivity; DEP: depression; ANX: anxiety; HOS: hostility; PHOB: phobic anxiety; PAR: paranoid ideation; PSY: psychoticism

<sup>a</sup> _P_ value < 0.00111 was regarded as significant after Bonferroni corrected

<sup>b</sup> _P_ value < 0.00138 was regarded as significant after Bonferroni corrected
 
Correlations (r) between subscales within the SCL-90 were measured using Pearson correlations, and internal correlations for the IS subscales were measured using Spearman rank correlation coefficients, both of which were checked for significance using t-tests

#### Table 2 Bivariate Correlations and Descriptive Statistics of parental rearing and IS (n = 3345)
| Variables | 1              | 2              | 3     | 4              | 5     | 6      | 7     | 8     | 9     | 10   |
|-----------|----------------|----------------|-------|----------------|-------|--------|-------|-------|-------|------|
| 1.F1      | 1              |
| 2.F2      | &#x02212;0.11c | 1              |
| 3.F3      | 0.17c          | 0.54c          | 1     |
| 4.F5      | &#x02212;0.08c | 0.68c          | 0.56c | 1              |
| 5.F6      | 0.24c          | 0.43c          | 0.58c | 0.49c          | 1     |
| 6.M1      | 0.75c          | &#x02212;0.15c | 0.05  | &#x02212;0.14c | 0.10c | 1      |
| 7.M2      | 0.03           | 0.38c          | 0.58c | 0.42c          | 0.52c | 0.13c  | 1     |
| 8.M3      | -0.22c         | 0.50c          | 0.37c | 0.61c          | 0.35c | -0.20c | 0.60c | 1     |
| 9.M4      | -0.16c         | 0.60c          | 0.31c | 0.44c          | 0.26c | -0.13c | 0.53c | 0.69c | 1     |
| 10.IS     | -0.16c         | 0.26c          | 0.22c | 0.31c          | 0.24c | -0.10c | 0.32c | 0.37c | 0.27c | 1    |
| Mean      | 45.95          | 15.40          | 18.77 | 8.47           | 10.17 | 50.24  | 33.48 | 12.32 | 12.16 | 1.99 |
| SD        | 11.06          | 5.00           | 4.60  | 2.76           | 2.98  | 11.21  | 7.77  | 4.12  | 3.82  | 0.73 |

Note. Father rearing, emotional warmth = F1; punishment = F2; overinvolvement = F3; rejection = F5; overprotection = F6. Mother rearing, emotional warmth = M1; overinvolvement and overprotection = M2; rejection = M3; punishment = M4. IS = interpersonal sensitivity. SD = standard deviation

<sup>c</sup> P value < 0.00111 was regarded as significant after Bonferroni corrected

The correlation (r) between parental rearing and IS was measured using Pearson correlation, while significance was also checked using t-tests

#### Table 3 Marginal associations of IS with parental rearing at the mean levels of IS (_n_ = 3345)
| Variables | Coefficients   | 95% CI                         | t             | P value                  |
|-----------|----------------|--------------------------------|---------------|--------------------------|
| F1        | &#x02212;0.010 | &#x02212;0.014, &#x02212;0.007 | &#x02212;5.86 | &#x0003c;&#x02009; 0.001 |
| F2        | 0.011          | 0.002, 0.021                   | 2.46          | 0.014                    |
| F3        | &#x02212;0.009 | &#x02212;0.018, 0.001          | &#x02212;1.84 | 0.066                    |
| F5        | 0.019          | 0.001, 0.037                   | 2.11          | 0.035                    |
| F6        | 0.035          | 0.022, 0.048                   | 5.41          | &#x0003c;&#x02009; 0.001 |
| M1        | 0.001          | &#x02212;0.003, 0.004          | 0.38          | 0.707                    |
| M2        | 0.013          | 0.008, 0.019                   | 4.48          | &#x0003c;&#x02009; 0.001 |
| M3        | 0.039          | 0.027, 0.051                   | 6.40          | &#x0003c;&#x02009; 0.001 |
| M4        | &#x02212;0.01  | &#x02212;0.022, 0.002          | &#x02212;1.60 | 0.109                    |
Note. 95% CI, 95% confidence intervals. All estimations were adjusted for grade (senior/junior), sex (girls/boys), survey years (2016/other years)

#### Fig.2 

![](https://s2.loli.net/2023/03/01/yWF5IoG3pbvrkj4.png)

Quantile regressions predicting interpersonal sensitivity at the 0.05–0.95 quantile. Coefficients (β) for the associations of interpersonal sensitivity with parental rearing across 0.05–0.95 quantile. The black solid horizontal line represents β = 0, black dots represent the estimated coefficients and the grey area represents 95%CI of the corresponding parameters. All estimations were adjusted for grades, sex, survey years


#### 课题组数据集测试
产前随访次数和出生体重的分位数回归图
![](https://s2.loli.net/2023/03/01/bcVR3tX1x7yWQkL.jpg)


![](https://s2.loli.net/2023/03/01/Js6oL4GXzE87kMU.jpg)



### 拓展
- 贝叶斯算法的分位数回归
- 机器学习算法的分位数回归
- 生存分析的分位数回归
- Estimation of quantile treatment effects with Stata https://www.stata-journal.com/article.html?article=st0203
- 治疗结果评估 （Quantile treatment effect）
- 内生性治疗的治疗效果

#### 治疗结果评估

治疗效果评估代码[^4]

```stata
net from http://www.stata.com/data/jwooldridge/
net describe eacsap
net get eacsap
use card
qreg lwage exper black motheduc reg662 reg663 reg664 reg665 reg666 reg667 reg668 reg669, quantile(0.1)
use https://stats.idre.ucla.edu/stat/stata/notes/hsb2, clear
qreg write
qreg write, quantile(.75)
qreg write female
predict p50
tabulate p50

```

#### 内生性治疗效果评估

```stata
net from http://www.stata.com/data/jwooldridge/
net describe eacsap
net get eacsap
use card
qreg lwage exper black motheduc reg662 reg663 reg664 reg665 reg666 reg667 reg668 reg669, quantile(0.1)
ivqte lwage exper black motheduc reg662 reg663 reg664 reg665 reg666 reg667 reg668 reg669 (iq), quantiles(0.1) variance # 这里表示iq是内生变量 此处评估的是条件QTE
ivqte lwage (college=nearc4), quantiles(0.1) variance dummy(black) continuous(exper motheduc) unordered(region) aai # college 表示内生变量，后面的等于后跟着的表示工具变量 此外，控制变量需要根据变量类型依次放进dummy, continuous, unordered 里面 此外，一定要加aai选项 此处评估的是条件QTE

ivqte lwage (college), variance dummy(black) continuous(exper motheduc) unordered(region) # unconditional QTE 
ivqte lwage (college = nearc4), variance dummy(black) continuous(exper motheduc) unordered(region) # unconditional QTE with instrument
ivqte lwage (college = nearc4), variance dummy(black) continuous(exper motheduc) unordered(region) positive # 最后的positive是设置权重的一种方法，默认条件下是4式
```
- 针对可观察变量（selection on observables）的干预是外生性干预，针对不可观测变量（selection on unobservables）的干预是内生性干预
- 条件效应（conditional effect）表示估计的分位数期忘是根据自变量的和非条件效应（unconditional effect）表示估计的分位数期望是针对整个入群的
>
Depending on the type of endogeneity of the treatment and the definition of the estimand, we can define four different cases. We distinguish between conditional and unconditional effects and whether selection is on observables or on unobservables. Conditional QTEs are defined conditionally on the value of the regressors, whereas unconditional effects summarize the causal effect of a treatment for the entire population. Selection on observables is often referred to as a matching assumption or as exogenous treatment choice (that is, exogenous conditional on X). In contrast, we refer to selection on unobservables as endogenous treatment choice.

$$
\\begin{aligned}
\\left(\\widehat{\\alpha}\_{\\mathrm{IV}}, \\widehat{\\Delta}\_{\\mathrm{IV}}^\\tau\\right) & =\\underset{\\alpha, \\Delta}{\\arg \\min } \\sum W\_i^{\\mathrm{FM}} \\times \\rho\_\\tau\\left(Y\_i-\\alpha-D\_i \\Delta\\right) \\\\
W\_i^{\\mathrm{FM}} & =\\frac{Z\_i-\\operatorname{Pr}\\left(Z=1 \\mid X\_i\\right)}{\\operatorname{Pr}\\left(Z=1 \\mid X\_i\\right)\\left\\{1-\\operatorname{Pr}\\left(Z=1 \\mid X\_i\\right)\\right\\}}\\left(2 D\_i-1\\right)
\\end{aligned} \\tag 4
$$


$$
W_i^{FM+} = E(W^{FM}|Y_i,D_i) \tag 5
$$









## 广义分位数回归

### R 代码
```R
library(mquantreg) # https://r-project.ro/conference2020/presentations/Mquantreg_presentation.pdf

```

### stata 代码



# 模型评估
## 注意事项
- 模型的评估一般不能使用原始数据，而是要用原始数据的一部分作为测试集
- 可是使用重抽样技术和十倍交叉验证方法进行模型验证
- 模型中纳入二次项时，可能会在极端值条件下预测效果不佳，因为二次项在遭遇极大值和极小值时可能会给出不切实际的预测值
- 

[^1]: Wehby GL, Murray JC, Castilla EE, Lopez-Camelo JS, Ohsfeldt RL. Quantile Effects of Prenatal Care Utilization on Birth Weight in Argentina. _Health Econ_. 2009;18(11):1307-1321. doi:[10.1002/hec.1431](https://doi.org/10.1002/hec.1431)* [Local library](zotero://select/library/items/CX8KTUZA)
[^2]: Wei Y, Pere A, Koenker R, He X. Quantile regression methods for reference growth charts. _Statistics in Medicine_. 2006;25(8):1369-1382. doi:[10.1002/sim.2271](https://doi.org/10.1002/sim.2271)* [Local library](zotero://select/library/items/FXCX2MGN)
[^3]: Engelhardt B, Abzug Z, Gloudemans M, Gu Z, Song Z. 1 Why use linear regression? _Linear Regression_.
[^4]: Fröolich M, Melly B. Estimation of Quantile Treatment Effects with Stata. _The Stata Journal_. 2010;10(3):423-457. doi:[10.1177/1536867X1001000309](https://doi.org/10.1177/1536867X1001000309)

