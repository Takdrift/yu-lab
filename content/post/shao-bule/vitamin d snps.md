---
title: "孟德尔随机"  # 文章标题，同时为博客页中显示的标题
date: 2019-04-26T21:43:48+08:00  # 创建日期
lastmod: 2019-04-26T21:43:48+08:00  # 最后修改日期
draft: true  # =true为草稿，不会生成相应的网页，!!!需要改为false才能生成相应网页!!!
# slug: ""  # 所生成网页的地址后缀，若未设置，会根据文件名生成地址

# keywords, tags, categories都可以设置多个，中间需要用英文逗号(,)隔开
keywords: [孟德尔随机]  # 关键字
tags: [孟德尔随机, 邵布勒]  # 标签，会将此文章添加到相应的标签下（建议查看既往的标签，防止相同含义的不同标签）
categories: [邵布勒]  # 分类，会将此文章添加到指定的分类下（建议使用各自的姓名，且只设置一个分类）
author: "邵布勒"  # 作者，会显示在文末
---
# 孟德尔随机分析

## Vitamin D相关SNPs

**title**: Circulating vitamin D concentration and risk of seven cancers: Mendelian randomisation study [BMJ 2017](https://www.bmj.com/content/359/bmj.j4761)

结果较稳健 (P <5×10-8) :** 

rs2282679 (GC), rs10741657 (CYP2R1), rs12785878 (DHCR7), rs6013897 (CYP24A1). 

每个SNP大概能解释1%的VitD变异，4个SNP解释了大概3-5%的VitD变异（数据来自欧洲人群）。([ref 1](http://dx.doi.org/10.1093/hmg/ddq155)，[ref 2](http://dx.doi.org/10.1016/S0140-6736(10)60588-0))

关于这4个SNPs与25(OH)D水平更详细的内容见[ref 3](http://dx.doi.org/10.1371/journal.pmed.1001383)

**Table 2 Characteristics of genetic variants associated with 25(OH)D concentration in published genome-wide association studies***

| Single nucleotide polymorphism | Chromosome |     Locus     | Risk allele | β estimate† |   P value   |
| :----------------------------- | :--------: | :-----------: | :---------: | :---------: | :---------: |
| rs2282679                      |     4      |      GC       |      G      |    −4.67    | <3.4×10−302 |
| rs10741657                     |     11     |    CYP2R1     |      G      |    −1.72    |  6.5×10−81  |
| rs12785878                     |     11     | DHCR7/NADSYN1 |      G      |    −2.11    | 6.4×10−129  |
| rs6013897                      |     20     |    CYP24A1    |      A      |    −0.98    |  3.4×10−17  |

*Source: Vimaleswaran, et al, 2013.28

†Reported per unit change in nmol/L in natural scale per effect allele.

## **Instrumental variable (IV) assumptions**

1. the genetic markers are strongly associated with **exposure**
2. the markers affect outcome **only** through their effect on **exposure** 
3. the markers are **independent** of any confounders of the association between **exposure** and **outcome**

> 即基因型**只通过**表型（暴露）来影响结局

**MR methods** using summary genetic data:

- [inverse variance weighted method (IVW)](http://www.ncbi.nlm.nih.gov/pubmed/?term=24114802)
- [likelihood based method](http://www.ncbi.nlm.nih.gov/pubmed/?term=22479202)

**Methods to assess potential violation of these assumptions:**

- [MR-Egger](http://www.ncbi.nlm.nih.gov/pubmed/?term=26050253)([详细介绍](#mr-egger method))
- [weighted median approach](http://www.ncbi.nlm.nih.gov/pubmed/?term=27061298)
- [over-identification tests](http://www.ncbi.nlm.nih.gov/pubmed/?term=22247045)

# MR Base platform

**What:** a platform that integrates a curated database of complete GWAS results (no restrictions according to statistical significance) with an application programming interface, web app and R packages that automate 2SMR (2-sample Mendelian randomization).

**Where:** http://www.mrbase.org/

**How:**

Figure 1. The practical steps for performing 2-sample Mendelian randomization (2SMR), as described in the Model section of the paper.

![](https://iiif.elifesciences.org/lax:34408%2Felife-34408-fig2-v1.tif/full/1500,/0/default.jpg)



Figure 2. The data available through MR-Base and the possible exposure-outcome analyses that can be performed.

![](https://iiif.elifesciences.org/lax:34408%2Felife-34408-fig3-v1.tif/full/full/0/default.jpg)



## Other accessible data resource

[ARIES dataset](http://mqtldb.org/): SNPs and methylation

[GTEx](https://www.gtexportal.org/home/): a catalog of SNPs influencing up to 27,094 unique gene identifiers across 44 tissues

# VitD相关SNPs

**表1 MR-Base里NHGRI-EBI GWAS catalog中查询到与VitD相关的SNPs**

| SNP         | gene.exposure | effect_allele.exposure | other_allele.exposure | beta.exposure | se.exposure | pval.exposure | units.exposure  | eaf.exposure | units.exposure_dat |
| ----------- | ------------- | ---------------------- | --------------------- | ------------- | ----------- | ------------- | --------------- | ------------ | ------------------ |
| rs4588      | intergenic    | T                      | NA                    | -0.25         | 0.0102041   | 1.00E-200     | nmol/L decrease | 0.283        | nmol/L decrease    |
| rs116970203 | CYP2R1        | A                      | G                     | -0.43         | 0.0204082   | 2.00E-90      | nmol/L decrease | 0.025        | nmol/L decrease    |
| rs1607741   | intergenic    | C                      | G                     | 0.12          | 0.0102041   | 1.00E-58      | nmol/L increase | 0.684        | nmol/L increase    |
| rs2282679   | GC            | C                      | A                     | -0.38         | 0.0306122   | 2.00E-49      | unit decrease   | 0.26         | unit decrease      |
| rs4423214   | intergenic    | T                      | C                     | 0.1           | 0.0102041   | 1.00E-40      | nmol/L increase | 0.697        | nmol/L increase    |
| rs182244780 | intergenic    | A                      | G                     | -0.39         | 0.0306122   | 7.00E-33      | nmol/L decrease | 0.013        | nmol/L decrease    |
| rs117300835 | intergenic    | A                      | G                     | -0.36         | 0.0306122   | 3.00E-32      | nmol/L decrease | 0.015        | nmol/L decrease    |
| rs55665837  | intergenic    | T                      | C                     | -0.08         | 0.0102041   | 8.00E-31      | nmol/L decrease | 0.373        | nmol/L decrease    |
| rs79761689  | intergenic    | C                      | T                     | -0.19         | 0.0204082   | 3.00E-30      | nmol/L decrease | 0.049        | nmol/L decrease    |
| rs148189294 | intergenic    | A                      | G                     | -0.22         | 0.0204082   | 2.00E-28      | nmol/L decrease | 0.038        | nmol/L decrease    |
| rs117865811 | intergenic    | G                      | A                     | -0.35         | 0.0306122   | 2.00E-27      | nmol/L decrease | 0.013        | nmol/L decrease    |
| rs138485827 | intergenic    | T                      | C                     | -0.13         | 0.0102041   | 2.00E-21      | nmol/L decrease | 0.072        | nmol/L decrease    |
| rs78862524  | intergenic    | A                      | C                     | -0.16         | 0.0204082   | 5.00E-20      | nmol/L decrease | 0.053        | nmol/L decrease    |
| rs6127099   | intergenic    | T                      | A                     | -0.06         | 0.0102041   | 2.00E-17      | nmol/L decrease | 0.288        | nmol/L decrease    |
| rs2060793   | CYP2R1        | A                      | G                     | 0.25          | 0.0510204   | 3.00E-17      | unit increase   | 0.41         | unit increase      |
| rs11023332  | PDE3B         | C                      | G                     | 0.94          | 0.0102041   | 2.00E-10      | unit increase   | 0.42         | unit increase      |
| rs3819817   | HAL           | T                      | C                     | 0.04          | 0.0102041   | 3.00E-10      | nmol/L increase | 0.21         | nmol/L increase    |
| rs185378533 | intergenic    | G                      | A                     | 0.07          | 0.0102041   | 2.00E-09      | nmol/L increase | 0.461        | nmol/L increase    |
| rs3829251   | NADSYN1       | A                      | G                     | -0.18         | 0.0306122   | 3.00E-09      | unit decrease   | 0.19         | unit decrease      |
| rs1155563   | GC            | C                      | T                     | 0.94          | 0.0102041   | 4.00E-09      | unit increase   | 0.28         | unit increase      |
| rs17467825  | GC            | A                      | G                     | 1.07          | 0.0102041   | 4.00E-09      | unit increase   | 0.7          | unit increase      |
| rs2207173   | SSTR4         | G                      | A                     | -0.13         | 0.0229592   | 4.00E-09      | unit decrease   | 0.29         | unit decrease      |
| rs2277458   | GEMIN2        | G                      | A                     | -0.05         | 0.0102041   | 6.00E-09      | nmol/L decrease | 0.786        | nmol/L decrease    |
| rs12287212  | RNU7-49P      | A                      | C                     | 0.94          | 0.0102041   | 2.00E-08      | unit increase   | 0.35         | unit increase      |
| rs1007392   | CYP2R1        | A                      | G                     | 1.06          | 0.0102041   | 4.00E-08      | unit increase   | 0.59         | unit increase      |
| rs12868495  | VDAC1P12      | A                      | G                     | 1.22          | 0.0484694   | 6.00E-07      | unit increase   | 0.03         | unit increase      |
| rs11586313  | IVL           | G                      | NA                    | 0.09          | 0.0204082   | 1.00E-06      | unit increase   | 0.55         | unit increase      |
| rs156299    | NPY           | G                      | T                     | 0.95          | 0.0102041   | 1.00E-06      | unit increase   | 0.43         | unit increase      |
| rs2302190   | HSF5          | C                      | T                     | 0.94          | 0.0102041   | 1.00E-06      | unit increase   | 0.2          | unit increase      |
| rs6730714   | PAX3          | A                      | G                     | 1.18          | 0.0408163   | 1.00E-06      | unit increase   | 0.04         | unit increase      |
| rs10508196  | FAM155A       | A                      | G                     | 1.08          | 0.0178571   | 2.00E-06      | unit increase   | 0.11         | unit increase      |
| rs4751058   | MKLN1         | A                      | G                     | 1.06          | 0.0127551   | 5.00E-06      | unit increase   | 0.16         | unit increase      |

# MR-Egger method

**MR-Egger包含三个部分：**

1. a test that indicates both violations of the instrumental variable assumptions and bias in conventional instrumental variable analysis methods
2. a test for a causal effect
3. an estimate of the causal effect. 

**假设前提：**

- 基因与暴露，以及基因与结局之间的关系是线性的，且不存在交互作用
- 基因之间相互独立（无LD）

**公式：**

<div align=center>_β_Yj = _αj_ + _θβXj_</div>

_aj_是基因不通过暴露而作用于结局的部分，_θ_是暴露作用于结局的部分

一个基因如果与影响结局的多个不同通路的暴露相关的话，则具有多效性（pleiotropic ），即_aj_ ≠ 0，这样的基因不是一个理想的IV。

Inverse variance weighted method

如果一个SNP _Gj_满足了IV的3个假设，则暴露与结局之间的因果关系可以表示为<math xmlns:mml="http://www.w3.org/1998/Math/MathML" id="M26" overflow="scroll"><mrow><msub><mover accent="true"><mi mathvariant="italic">θ</mi><mo stretchy="false">^</mo></mover><mi>j</mi></msub><mo>=</mo><mfrac><msub><mover accent="true"><mi mathvariant="italic">β</mi><mo stretchy="false">^</mo></mover><mrow><mi>Y</mi><mi>j</mi></mrow></msub><msub><mover accent="true"><mi mathvariant="italic">β</mi><mo stretchy="false">^</mo></mover><mrow><mi>X</mi><mi>j</mi></mrow></msub></mfrac></mrow></math>

