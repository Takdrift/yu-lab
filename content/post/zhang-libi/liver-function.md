---
title: "Liver Function Indicator"  # 文章标题，同时为博客页显示的标题
date: 2023-03-02  # 创建日期
lastmod: 2023-03-02  # 最后修改日期
draft: false  # true为草稿，不会生成网页，!!!需改为false才能生成网页!!!
# slug: ""  # 所生成网页的地址后缀，若未设置，会根据文件名生成地址
mathjax: false
# keywords, tags, categories都可以设置多个，中间需要用英文逗号隔开
keywords: [R]  # 关键字
tags: [R]  # 标签，会将此文章添加到相应的标签下（参考已有标签，防止相同含义的不同标签）
categories: [张李碧]  # 分类，会将此文章添加到指定的分类下（建议使用各自的姓名，且只设置一个分类）
author: "张李碧"  # 作者，会显示在文末
# math: true
# markup: 'mmark'
# !!!若文章有引用本地图片，则该markdown文件文件名中不能有空格也不能有大写字母（hugo编译时会自动将空格转为-，
# 并将大写字母转为小写导致图片引用路径出错）!!!
---




# 肝功能指标临床意义

1.  肝血检查异常管理指南 **29122851**
    1.  [丙氨酸]()**转氨酶(ALT)和天冬氨酸转氨酶(AST)：**
        1.  是存在于肝细胞中的酶，在肝细胞损伤或死亡（肝炎）时释放到血液中。
        2.  ALT被认为更具肝脏特异性，因为它在非肝组织中的浓度较低，并且非肝脏相关升高并不常见。
        3.  AST 大量存在于骨骼、心脏和平滑肌中，因此在心肌梗死或肌炎患者中可能升高。虽然ALT被认为是肝病的更特异性指标，但在酒精相关性肝病和某些自身免疫性肝炎（AIH）病例中，AST的浓度可能是肝损伤的更敏感的指标。
    2.  **γ-谷氨酰转移酶（GGT）**：
        1.  在肝脏中含量丰富，也存在于肾脏，肠道，前列腺和胰腺中，但不存在于骨骼中;因此，它可能有助于确认ALP升高是肝脏而不是骨源。
        2.  GGT 最常因肥胖、过量饮酒或药物诱发而升高。虽然GGT升高对肝脏疾病的特异性较低，但它是肝死亡的最佳预测指标之一。
    3.  **碱性磷酸酶（ALP）**：
        1.  主要在肝脏（来自胆道上皮）中产生，但在骨骼中也大量存在，在肠道，肾脏和白细胞中含量较少。
        2.  儿童期的生理水平较高，与骨骼生长有关，妊娠期ALP升高是由于胎盘生成。
        3.  病理性水平升高主要见于骨病（如转移性骨病和骨折）和胆汁淤积性肝病，例如原发性胆汁性胆管炎、原发性硬化性胆管炎、胆总管梗阻、肝内导管梗阻（转移）和药物性胆汁淤积。此外，继发于右侧心力衰竭的肝淤血也可导致胆汁淤积（ALP 水平和/或胆红素升高）。
    4.  **胆红素 (TBIL)：**
        1.  主要是网状内皮系统分解血红蛋白血红素成分的副产物。它以两种形式存在，非结合型和结合型。胆红素以其不溶性非结合形式运输到肝脏，在那里它被转化为可溶性结合胆红素以便排泄。非结合型高胆红素血症通常是由于溶血或结合受损，而结合型高胆红素血症通常是由于实质肝病或胆道系统梗阻。
        2.  单纯胆红素浓度升高的最常见原因是吉尔伯特综合征，这是一种遗传性代谢紊乱，通过葡萄糖醛酸转移酶活性降低导致结合受损。
    5.  **白蛋白（ALB）：**
        1.  是一种仅在肝脏中产生的蛋白质，具有多种生物学作用。由于白蛋白仅由肝脏产生，因此血清白蛋白浓度通常被认为是肝脏合成功能的标志物。
        2.  白蛋白合成不仅在肝病中受到影响，而且还受到营养状况、激素平衡和渗透压的影响。在许多临床情况下，白蛋白浓度降低，包括败血症、全身炎症性疾病、肾病综合征、吸收不良和胃肠道蛋白丢失。
    6.  **胆汁酸 (TBA)**:
        1.  在肝脏中合成，是胆汁的主要成分。胆汁流动受损导致胆汁淤积，其特征是肝脏和血清中胆汁酸水平升高，随后出现肝细胞和胆道损伤。随着妊娠的进展，血清胆汁酸逐渐增加，但对于大多数女性来说，这仍然在正常的参考范围内。然而，对于少数女性，血清胆汁酸升高超过这一水平，导致肝内妊娠胆汁淤积症（ICP），
    7.  **妊娠期血清**[白蛋白](https://www.sciencedirect.com/topics/medicine-and-dentistry/serum-albumin)**与血红蛋白浓度相关下降（降低约25%）**，被认为与血液稀释导致血浆总体积增加有关 [[3](https://www.sciencedirect.com/science/article/pii/S1521691820300020?via%3Dihub#bib3)]。**ALP 增加，妊娠晚期ALP可能达到正常成人参考上限值的 2 至 4 倍。**这主要是因为在妊娠过程中胎盘逐渐发育成熟，胎盘分泌出的ALP会随着血液循环进入孕妇全身。出生后，ALP 水平下降，在 2 周内达到非妊娠值。[转氨酶](https://www.sciencedirect.com/topics/medicine-and-dentistry/transaminase)**、胆红素、胆汁酸和GGT的浓度通常与非妊娠女性一样保持在正常范围内**。**32359686**
    8.  
        1.  **孤立性胆红素升高** - 最常由吉尔伯特综合征引起（影响 5-8% 的人口）。[46](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5754852/#R46)考虑对贫血患者进行溶血。对全血细胞计数和直接和间接胆红素的空腹样本重复肝脏血液检查。由于间接成分，总胆红素应进一步升高，并且不应有贫血的证据。如果患者贫血，需要通过检测网织红细胞计数/乳酸脱氢酶/结合珠蛋白来排除溶血。如果非结合胆红素升高更明显（\>40 μmol/L），则更罕见的原因，例如克里格勒-纳贾综合征[46](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5754852/#R46)应考虑进行基因检测。
        2.  **胆汁**淤积—ALP 和 GGT 升高主要提示胆汁淤积。常见病因包括原发性胆汁性胆管炎、PSC、胆道梗阻（结石、狭窄、肿瘤形成等）、肝充血和药物性肝损伤。然而，孤立的ALP升高可能是由维生素D缺乏引起的，与肝脏无关，或者可能与儿童期快速生长期间的升高有关，因此伴随GGT升高的存在可以帮助确认肝病的原因。
        3.  肝炎—ALT和AST升高主要提示肝细胞肝损伤（**肝炎**）。常见原因包括病毒性肝炎、NAFLD、ARLD、AIH 和药物性肝损伤。
2.  肝血检查的临床模式识别 **34797734**
    1.  肝细胞模式表现为 AST 和 ALT 水平升高，而 ALP 或胆红素水平升高表示胆汁淤积模式。白蛋白水平降低或凝血酶原时间延长可能表明急性肝衰竭或失代偿性晚期慢性肝病患者的肝脏合成减少。最后，胆红素水平升高且 ALP 和转氨酶水平正常提示单纯性高胆红素血症模式。
        1.  

            ![图片1.png](https://s2.loli.net/2023/03/02/uAovXsFGNLgnrZm.png)
            
        2.  
    2.  **肝细胞损伤模式**
        1.  肝细胞损伤的标志物包括转氨酶，AST 和 ALT 水平升高。这些酶在氨基酸代谢过程中将天冬氨酸和丙氨酸转移到酮戊二酸中，并在肝细胞损伤的情况下从细胞质释放到血液中，导致血清检测升高。非酒精性脂肪性肝病 （NAFLD）、酒精相关性肝病 （ARLD） 和病毒性肝炎是最常见的病因。
        2.  虽然AST可见于其他组织，如心脏或骨骼肌、肾脏和大脑，但ALT主要存在于肝脏中，对肝细胞损伤更敏感。肝损伤的大多数原因导致ALT水平升高，而ALT水平正常的AST水平升高可能提示心脏或肌肉疾病。
        3.  ALT水平从正常上限（ULN）升高的程度可以确定肝细胞异常模式的临床紧迫性。转氨酶水平临界（\<2 × ULN）或轻度（2-5 × ULN）升高可能是由于多种疾病引起的，例如慢性肝炎、肝硬化或其他原因引起的慢性肝病。重度升高（\>15×ULN）有单独的鉴别诊断，包括缺血性肝炎或中毒性损伤等急性病因。
        4.  此外，AST/ALT 水平比值可能提示某些肝脏疾病实体。急性酒精性肝炎或暴发性病毒性肝炎的 AST/ALT 水平比值高于 2.0，而肥胖患者中大多数非酒精性脂肪性肝炎 （NASH） 病例的 AST/ALT 比值小于 1 。
    3.  **胆汁淤积性损伤模式**
        1.  胆汁淤积（胆汁形成或排泄受损）的标志物包括 ALP、GGT 和胆红素。
        2.  ALP 催化肝细胞中的磷酸酯水解，但也可见于骨、肠和胎盘中;在没有肝病的情况下，骨病、年龄增长和妊娠可能导致 ALP 水平升高。
        3.  GGT 是小管胆管内另一种酶，GGT 水平升高可确认肝原因为 ALP 水平升高的原因。
        4.  胆红素来源于红细胞分解，并被肝细胞结合成水溶性形式进行排泄。总胆红素水平可因溶血或胆汁淤积增加而升高，但直接胆红素水平升高对肝胆损伤更具特异性。胆汁淤积的原因可分为继发于肝细胞损害（肝内）或胆道阻塞（肝外）的胆汁排泄受损类别。
    4.  **急性肝衰竭模式**
        1.  急性肝衰竭的标志物包括白蛋白和凝血酶原时间，与肝脏合成的物质相关。
        2.  白蛋白的半衰期为 3 周，白蛋白水平降低可能提示肝脏疾病持续时间超过 3 周;然而，在非特异性严重全身性疾病或慢性炎症中，白蛋白水平也可能降低。
        3.  凝血酶原时间是凝血外在途径的量度，取决于肝脏合成的维生素K和凝血因子。凝血酶原时间（通常表示为国际标准化比值或INR）在重度肝病超过24小时时变长，是肝脏合成受损的时间敏感性更强的标志物。除肝衰竭外，凝血酶原时间延长的其他原因包括维生素K缺乏、弥散性血管内凝血和使用华法林。
        4.  血小板减少症是慢性肝损伤的另一种后遗症，可能由继发于门静脉高压或骨髓抑制的脾隔离引起。
    5.  **单纯性高胆红素血症模式**
        1.  在这种模式中，转氨酶和ALP水平正常时总胆红素水平升高。评估的下一步是评估直接和间接胆红素水平。
        2.  如果胆红素水平升高主要是间接和轻度（\<6 mg/dL [103 μmol/L]），吉尔伯特综合征是最可能的病因;这是胆红素结合的良性遗传缺陷，影响高达8%的一般人群。间接胆红素水平升高的其他原因包括溶血性贫血、新生儿黄疸和克里格勒-纳贾综合征。
        3.  直接胆红素水平升高更成问题，提示肝实质或胆道梗阻受损。
    6.  
        1.  