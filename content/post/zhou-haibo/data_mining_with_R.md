---
title: "data_mining_with_R"
data: 2020-11-22
lastmod: 2020-11-22
draft: false
keywords: [测试]
tags: [R]
categories: [Zhou Haibo]
author: "Zhou Haibo"
---

# R数据挖掘之道

# R语言快捷键

```R
<-  #<-快捷键"alt"+"-"
```

| 符号 | 快捷键             |
| ---- | ------------------ |
| <-   | "alt"+"-"          |
| %>%  | "ctrl"+"shift"+"M" |
|      |                    |



### 1.2.4 因子变量鲜有人知的秘密

function 	rep	base

> times #整体重复
>
> each #每一个重复

example

```R
a <- c(1:3) #生成一个1~3的向量  <-快捷键"alt"+"-"
a1 <- rep(a, times = 3)
a2 <- rep(a, each = 3) #可以为多因子方差分析或者为mapply创造索引
a3 <- rep(a, 3)
a1
a2
a3
```

结果

```R
a1
[1] 1 2 3 1 2 3 1 2 3
a2
[1] 1 1 1 2 2 2 3 3 3
a3
[1] 1 2 3 1 2 3 1 2 3
```



### 1.2.5 矩阵相关运算及神奇的特征值

```R
mymatr <- matrix(data = c(1:20), nrow = 4, ncol = 5, byrow = TRUE)
trans*2 #矩阵和数字相乘可以这么表示
mymatr %*% trans #"%*%"表示两个矩阵相乘
diag #取对角元素
rowSums(mymatr) #对行求和
colSums(mymatr) #对列求和
mymatr.eigen <- eigen(mymatr.symmetric=T) #求矩阵的特征值和特征向量
mymatr.eigen$values # 两行代码加起来表示提取矩阵特征值
mymatr.eigen$vectors #提取矩阵特征向量
```

### 1.2.6数据框筛选、替换、添加、排序、去重

#### 数据筛选

```R
myframe <- data.frame(a = c(1:3,2:5,8), b = c("a","b","c","b", "c", "d","e","f"),m = c(NA,"b","c","b","c",NA,"e","8"), n = (1:8),stringsAsFactors = F) #示例数据框
myframe[1:3,] #筛选前三行
myframe[,1:2] #筛选前两列
myframe[1:3,c(1,4)] #筛选第一列和第四列的前三行数据
myframe[,c("a","m")] #按照名称筛选数据框名为a和m的列
library(dplyr)
select(myframe,b) #选取名称为b的列
select(myframe,-b) #选取b以外的其他列
myframe[myframe$a==1,] #选取a列为1的行
mframe[myframe$a>3,c("b","a")] #选取a列大于3的行并且选择对应的b列的值
temp <- c("b","a")
myframe[myframe$b %in% temp,] #这句代码应该跑了试一试
```



#### 替换修改

```R
myframe <- data.frame(a = c(1:3,2:5,8), b = c("a","b","c","b", "c", "d","e","f"),m = c(NA,"b","c","b","c",NA,"e","8"), n = (1:8),stringsAsFactors = F) #示例数据框
myframe[is.na(myframe$m),"m"] <- 0 # 筛选出m列的缺失值并且赋值为0
myframe[myframe$b=="c","a"] <- 1 # 筛选出b列等于字符"c"的行所对应的a列数据并且替换为1
myframe[myframe$n <= 4, "a"] <- 1 #筛选出n列小于等于4的行锁对应的a列数据并且替换为1
myframe[myframe$b == "c", "a"] <- myframe[myframe$b == "c", "n"] # 筛选出b列等于字符"c"的行所对应的n列数据来替换b列等于c的行所对应的a列  
myframe2 <- data.frame(a = c(2:5, 2:5, 7), b = c("a", "b", "c", "d", "e", "f"), stringsAsFactors = F)
myframe[myframe$b == "c", "a"] <- myframe2[myframe$b == "c", "a"] #筛选myframe2中b列等于c的行所对应的a列来替换myframe中b列等于c的行所对应的a列

```



#### 添加

```R
myframe <- data.frame(a = c(1:3,2:5,8), b = c("a","b","c","b", "c", "d","e","f"),m = c(NA,"b","c","b","c",NA,"e","8"), n = (1:8),stringsAsFactors = F) #示例数据框
temp <- 1:8 #生成一个1~8的临时向量
myframe$new1 <- temp #创建新列new1并将temp赋值给该列
myframe$new2 <- myframe$a/myframe$n #生成新列new2，并将a列除以b列的值赋给新列
myframe <- transform(myframe, new3 = a/n) #transform 第一个参数指定数据框，第二个参数表示创建新列new3并将a/n的值赋给new3
library(dplyr)
myframe <- select(myframe, -contains("new")) #删除刚才创建的三列，contain获取包含new的列的名称，然后使用“-”删除
myframe[9,] <- 1:4 #在数据中添加第9行，并将第9行赋值为1-4
myframe <- rbind(myframe, myframe) #将两个数据框捆绑形成一个新的数据框
```

#### 排序

```R
x <- c(77, 83, 95, 64, 32, 100, 94, 62)
sort(x, decreasing = T) #sort函数直接返回排好序的原始数据值，这样其作用就大大弱化了，只能对因子或数值向量排序
order(x, decreasing = T) #order能够对多列进行排序，返回值为按照升序或者降序排列之后对应数值的索引号
x[order(x, decreasing = T)] #按照索引号提取即可排序
rank(x) #返回排序之后的秩，我感觉返回的好像是从小到大排序的名次
cbind(x, rank(x)) # 
myframe <- data.frame(a = c(1:3,2:5,8), b = c("a","b","c","b", "c", "d","e","f"),m = c(NA,"b","c","b","c",NA,"e","8"), n = (1:8),stringsAsFactors = F) #示例数据框
myframe[order(myframe$n,decreasing = T),] #按照示例数据框的n列进行降序排列
myframe[order(myframe$n, myframe$b),] #按照示例数据框的n和b列进行升序排列
```

#### 去重

```R
myframe <- data.frame(a = c(1:3,2:5,8), b = c("a","b","c","b", "c", "d","e","f"),m = c(NA,"b","c","b","c",NA,"e","8"), n = (1:8),stringsAsFactors = F) #示例数据框
unique(myframe) #对整个数据框进行去重，即保留那些不重复的行
duplicated(myframe$a) #判断a列是否是重复数据，如果有重复数据返回true，否则返回false，第一次出现为假，再次出现为真
myframe[!duplicated(myframe$a), ] #用来筛选不重复的数据，!表示逻辑反转
myframe[duplicated(myframe[,c("a", "b")]),] #筛选a列b列的重复的数据
myframe[!duplicated(myframe[,c("a", "b")]),] #筛选不重复的数据
```

### 1.2.7与数组相比，表单list的用处更加广泛

#### 数组

```R
arr <- (1:27, dim = c(3, 3, 3)) #创建一个3*3*3的数组
arr #展示数组，会发现其实该数组是三个矩阵
arr[3, 3, 3] <- "a" #将数组最后一个数值改为字符型"a"，会发现所有的结果都被强制转换为字符型
```

#### 表单

```R
a <- 1:3
b <- c("a", "b", "b")
m <- data.frame(cbind(a, b))
names(m) <- c("x", "y") #提取m数据框的列名并形成一个新向量，将x和y重新赋值给这个向量
alist <- list(a, b, m) #将所有的向量捆绑为一个表单
alist 
names(alist) <- c("g", "h", "k") #获取列表中所有的名字并修改为新名字
alist$k #使用名称筛选list元素
alist[3] #第三个数据是一个数据框，但是用中括号只能筛出一个仅仅包含一个元素的list，想要最后显示的结果为数据框，就要加两个方括号如11行代码一样
class(alist[3])
alist[[3]]
class(alist[[3]])
```

### 1.2.8如何进行数据结构之间的转化

示例数据框，R语言自带数据框 iris

```R
head(iris) #查看开头的6条数据，可以加上正整数n来调整显示的数量
tail(iris) #查看末尾的6条数据
str(iris) #查看数据框的结构和类（class）
iris$Species <- as.character(iris$Species) #
str(iris)
temp <- unclass(iris) #unclass将原来的类解散为组成这个类的各个元素为若干个等长的向量并转换为list，list中每个元素是原来数据框的
str(temp) 
temp <- do.call(cbind, temp)
temp <- data.frame(temp, stringsAsFactors = F)
str(temp)
temp$Sepal.Length <- as.numeric(temp$Sepal.Length)
temp$Species <- as.factor(temp$Species)
```

 






```R
test <- multinom(eGFR.ck2 ~ DR + AGE + SEX + DM.year + BMI + hypertension + DM.drug + HbA1c, data = subset(DR_new, Hb.ck==0))  # + RBC.fl 
exp(coef(test)) #OR+ hyperlipidemia 
exp(confint (test))#OR 95%  
z <- summary(test)$coefficients/summary(test)$standard.errors  # Z score
p <- (1 - pnorm(abs(z), 0, 1))*2  # p-Value
pnorm(abs(z), lower.tail=FALSE)*2  # p-Value
```

## 批量读取符合条件的文件

### 合并读取

```R
###批量读取相同结构的文件
#如果想批量处理文件，则可设置for循环读取处理：
setwd("D:/file")#建立工作路径
temp=list.files(path="D:/file",pattern="*.ss")#list文件夹中的文件数

ss<-c()#设立一个空集

#通过for循环导入多有的文件
for(i in 1:length(temp)){
  
  file=read.table(temp[i],sep='\t',header = TRUE)
  ss<-rbind(ss,file)#将for循环导入的文件都合并到空集中
  
}
#将ss转为数据框
ss<-as.data.frame(ss)
```

### 分开读取

```R
#tidy老师示范
dir.create("file")
setwd("file")
for (i in 1:10) {
  haven::write_dta(ggplot2::diamonds, paste0(i, ".dta"))
}  #这一部分以上是生成文件列

library(fs)
dir_ls(regexp = "[.]dta$") -> filelist
for (i in 1:10) {
  assign(paste0("df", i), haven::read_dta(paste0(i, ".dta")))
}
```

```R
#对老师的代码进行优化

filelist <- fs::dir_ls(regexp = "[.]dta$")
for (i in 1 : length(filelist)){
    assign(paste0("tbl", filelist[i]), haven::read_dta(filelist[i]))
}
```



```R
#检查当前global enironment中的所有数据框的某一列是否符合要求
dta_lst <- ls()
dta_lst <- fs::
```




```R
#我自己的代码
file_list <- list.files(path = "F:/OneDrive/Documents/personal paper/开放数据库问卷/CHARLS")  #获取特定路径文件夹下的所有文件名
file_list_a <- stringr::str_detect(string = file_list, pattern = ".dta") #生成与文件名向量等长的逻辑向量
file_list <- file_list[file_list_a] #提取符合条件的文件名生成新的文件名向量
file_list      #检查列表是否有误 
for (i in 1:length(file_list)) {   #循环读入文件列表中的所有文件名并根据文件名生成对应数据框
  assign(paste0("tbl", file_list[i]), haven::read_dta(file_list[i]))
}
```





# 删除某一列字符的最后一个









# 将列表中的table转换为dataframe













# 画散点图

```R
p1 <- ggplot(data=dup_sap_final,aes(x=as.numeric(age),y= `C`))+
  # geom_point()+
  stat_smooth()+  #span = 0.5 ,  method = loess
  labs( # subtitle="根据孕前BMI分组",
    x="孕早期VD",
    y="出生体重，kg",
    title="孕早期VD与出生体重之间的关系")
p1
```

# 如何对数据进行标化

最大最小值标化可以让所有的值都在0-1，但是这样的标化无法较好的描绘离群点，Zscore标化可以让均值为0并且标准差为1

```R
Maxmin_norm <- function(x){
  return((x-min(x))/(max(x)-min(x)))
}
analysis_std[c(sfd,pufd,mufd)] <- apply(analysis_std[c(sfd,pufd,mufd)], 2, Maxmin_norm)
```

# 缺失值插补计算生成数据框缺失值的均值

```R
imputed <- mice(data = analysis_std_ab_chk,m = 5, seed = 2020)
#取得所有合成数据框组成的列表
#complete(imputed, mild = T)
all.imputed <- complete(imputed, action = 'all')
#对得到的m个合成数据框缺失值部分求平均
avgDF <- function(data,all.imputed){
  baseDF <- all.imputed[[1]][is.na(data)]
  for(child in 2:length(all.imputed)){
    baseDF <- baseDF + all.imputed[[child]][is.na(data)]
  }
  data[is.na(data)] <- baseDF/length(all.imputed)
  return(data)
}
```

# 分组计算对应指标均值

```
library(dplyr)
library(magrittr)
df %>% dplyr::group_by(., factor_col) %>% dplyr::summarise(., colname = mean(var))
```

# 从数据中抽样

## 系统抽样

等距抽样，机械抽样

```

```





# MD5 值计算

运行win+R 输入 cmd 操作台中输入如下代码

```
certutil -hashfile d:\qoogle\qoogle.rar MD5
```

2200bdde3e8e404a0e40bdd877190ad7