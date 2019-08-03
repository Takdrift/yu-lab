---
title: "关于本博客"
date: 2019-04-13
lastmod: 2019-04-13
draft: false
weight: 1
#slug: ""
keywords: [博客, 介绍]
tags: [介绍]
#categories: []
author: "Shao"
---

## 为什么有这个博客

建立该博客的目的是给大家一个记录科研学习与生活的平台，方便大家学习交流

你可以在博客上记录

- 组会汇报内容
- 文献阅读笔记
- `SAS` & `R`代码
- 其他你想分享的

## 怎么写（搭建）博客

**准备工作**

- 注册[GitHub](<https://github.com/>)帐号
- 下载[GitHub Desktop](<https://desktop.github.com/>)客户端（根据自己的操作系统选择对应的**32**或**64**位版本）
- 下载**markdown**编辑器（推荐[typora](<https://typora.io/>)）
- 下载[Hugo](<https://github.com/gohugoio/hugo/releases>) 

该博客是基于[Hugo](<https://gohugo.io/>)（静态网站生成软件）搭建的静态网站，目前较主流的软件还有Jekyll和Hexo。选择Hugo是因为它够简单，且建站速度够快，此外R中的`blogdown`包就支持Hugo的建站方式。更多关于Hugo的介绍可以查看[谢益辉](https://yihui.name/)参与开发的R package`blogdown`一书中的[介绍](<https://bookdown.org/yihui/blogdown/hugo.html>)。

在R中可以通过`blogdown`包建立博客并且可直接在Rstudio中通过Rmarkdown写文章并发布，但下面介绍的建站方法并非基于R，原因主要有

1. 还有一部分老同志的主力科研软件是`SAS`
2. 相较`R`中的**Rmarkdown**，还有更高效好用的**markdown**编辑器（如[typora](<https://typora.io/>)）

### Hugo篇

1. 从[Hugo](<https://github.com/gohugoio/hugo/releases>)的GitHub主页上下载对应版本（**32**或**64**位）的软件，如果不知道自己操作系统属于哪一种，[点这里](<https://support.microsoft.com/zh-cn/help/827218/how-to-determine-whether-a-computer-is-running-a-32-bit-version-or-64>)。下载完毕之后解压得到hugo.exe文件。

2. 第2步有**两种**方案

   - 2.1 右键我的电脑，点击`属性`，点击`高级系统设置`，选择`高级`选项卡，点击`环境变量`，在系统变量的`变量`里找到`Path`并双击，将第一步解压得到的hugo.exe放到你喜欢的位置，假设hugo.exe在`D:\Hugo\`目录下，则在`变量值`中添加D:\Hugo\，使用分号（英文状态）与前面的路径分隔。

   - 2.2 将hugo.exe放到博客根目录下（即`yu-lab`目录下）即可。

     > **两种方案的区别**
     >
     > - **2.1** 这种方法是将hugo.exe添加到系统环境中，这样不管在哪里运行hugo相关命令系统都能识别
     >
     > - **2.2** 因为hugo相关命令是在根目录下运行的，此方法将hugo.exe放在博客根目录下，所以能够正常运行。该方法适合于只有一个博客的情况，以及将博客储存在U盘中时可以采用该方案。（若采用此方案，先看[GitHub篇](#github篇)下载博客）

3. 若采用2.1方案，按`Win+R`，输入`cmd`回车，然后在命令行输入`hugo version`回车，若如下成功显示hugo版本信息则说明设置成功。

   ```powershell
   hugo version
   Hugo Static Site Generator v0.54.0-B1A82C61 windows/amd64 BuildDate: 2019-02-01T09:42:02Z
   ```

### GitHub篇

[GitHub](<https://github.com/>)是一个托管软件源代码（具有版本控制功能）的网站，支持**多人协作**。2008年成立，2018年6月4日被微软以75亿美元收购。

我们将生成博客网站的文件托管在GitHub上，通过多人协作的机制实现多人共同写博客。

在[GitHub](<https://github.com/>)官网注册好账号并下载相应的桌面客户端（[GitHub Desktop](<https://desktop.github.com/>)）之后，我们就可以开始博客之旅了。

在开始操作之前，先来了解一下4个基本的GitHub概念，`repo`、`fork`、`push`和`pull`

- `repo`即repository，指代码仓库，即你托管在GitHub上的项目（如本文中的**博客**）
- `fork`指复制别人的`repo`
- `push`指将本地的修改push到GitHub，可理解为**上传**
- `pull`，准确地说`pull request`指申请**合并**修改（当你`fork`了别人的`repo`，然后修改或增加了内容，可通过`pull request`申请将你的修改合并至源`repo`）

想进一步了解GitHub的工作机制，可以到GitHub官网参考相应的[教程](https://github.blog/2018-04-19-introducing-github-learning-lab/)。

#### 1.Fork博客源repo

登陆自己的GitHub账号，然后打开<https://github.com/Takdrift/yu-lab>，点击右上角的`Fork`按钮就可以把博客的源码复制到自己的代码仓库。

![fork](about-the-site.assets/fork.png)

#### 2.下载博客

完成第一步后，打开GitHub Desktop客户端，登陆自己的账号，点击`File`-`Clone repository`（**Ctrl+Shift+O**），根据下图操作后GitHub上的整个博客就克隆到我们的电脑上了。

![clone](about-the-site.assets/clone.png)

#### 3. 添加文章

打开上一步克隆博客所选的本地路径，`yu-lab`目录（博客**根目录**）下的`content`文件夹就是存放博客文章的地方，添加新文章只需在`content\post\`目录下添加相应的**markdown**文件即可（有关**markdown**的介绍见[下文](#markdown篇)）。

例如，在`content\post\all`文件夹下新建了一个名为`share-r-code.md`的文件，文件开头部分内容如下：

```markdown
---
title: "R Code分享"  # 文章标题，在网也中显示的标题
date: 2019-04-13  # 创建日期
lastmod: 2019-04-13  # 最后修改日期
draft: false  # =true为草稿，不会生成相应的网页
#slug: ""  # 所生成网页的地址后缀，若未设置，会根据文件名生成地址
keywords: [R, 学习资料]  # 关键字
tags: [R, 学习资料]  # 标签，会将此文章添加到指定的标签下
categories: [R, 学习资料]  # 分类，会将此文章添加到指定的分类下
author: "Yu Group"  # 作者
---

**R code示例书写规范：**

1. 第一行注释说明R Code的用途及作者
2. 第二行开始进行代码的书写，尽量选择R自带数据进行演示，若数据格式不同，需提供数据
3. 对每一步进行注释，注释若是独立的一行则在行首输入`#`后空1格，然后开始注释，若注释紧接代码后面，代码后先空2格，输入`#`，然后空1格进行注释。推荐阅读：[R代码书写规范](<https://google.github.io/styleguide/Rguide.xml>)）

第一行注释示例如下，在输入完用途后输入4个`-`再添加作者信息（这样复制到Rstudio中可以生成标题）
```

:bangbang:在文章中引用图片有两种方式

1. 将图片上传至**图床**，通过URL引用（[下文有介绍](#图床软件推荐)）
2. 引用**本地**图片（分为绝对路径引用与相对路径引用）
   - 推荐使用**相对路径引用**，具体设置方法见[下文](#typora图片引用)

以上两种方法各有**利弊**

- 上传至图床后相对整个博客的**体积会更小**，但**需要联网**后访问。
- 引用本地文件**不需要网络**的支持，但是会增加博客的文件体积（随着文章逐渐增多，会越发明显）

> 注：如果文档中有引用**本地**的图片，则markdown文件文件名中**不能有空格**，因为**hugo**在编译时会将文件与文件夹名称中的**空格**转为**“-”**，从而导致图片的引用路径出错。

**本地预览博客**

文章保存后，我们可以通过运行`yu-lab`目录下的`Deploy Local Server.bat`生成本地预览，运行后在浏览器地址栏输入<localhost:1313>即可进行预览。

**提交修改至GitHub**

本地预览确认无误后通过下面的步骤将相应的修改`push`到你`fork`过来的`repo`并通过`pull request`申请合并至源`repo`。打开**GitHub Desktop**，客户端会自动检测更改，如下图所示对所做的修改进行备注说明并提交（`commit`）。

![commit](about-the-site.assets/commit.png)

**将修改同步至GitHub**

点击`Commit to master`后，还需要点击面板右侧的`Push origin`（**Ctrl+P**）才会真正将本地修改同步至GitHub。

![push](about-the-site.assets/push.png)

**发起合并申请（pull request）**

同步完成后你所修改的内容还只是在自己`fork`过来的代码仓库里，需要通过发起`pull request`（**Ctrl+R**），申请将自己的修改合并至源`repo`（如下图）。

![pull request](about-the-site.assets/pull request.png)

点击后，浏览器会自动跳转到相应网页，如下图点击`Create pull request`![creat pr](about-the-site.assets/creat pr.png)

填写相应**说明**后提交即可

![creat pr2](about-the-site.assets/creat pr2.png)

接着，源`repo`所有者会收到相应的合并请求（`pull request`），审查通过并`merge`之后源`repo`的内容就会得到更新。

还记得上面添加的share-r-code.md文件吗，这是该文件通过hugo生成的[博客文章](/post/all/share-r-code)。

以上就是在博客中添加**新文章**的整个工作流。

#### 4.同步源repo的更新

若源`repo`更新了内容，我们需要将`fork`过来的`repo`进行更新以保持与源`repo`一致。

操作步骤如下：

![pr1](about-the-site.assets/pr1.png)

1. 点击`Fetch origin` 获取云端各个`repo`的最新状态
2. 点击`Current branch` 后点击`Choose a branch to merge into master`，并在弹出的窗口中选择需同步的源`repo`（一般为**upstream/master**），若源repo有更新，在下方会显示**This will merge...**，点击下方的`Merge upstream/master into master`就完成了本地与源`repo`的同步
3. 此时会显示`push origin`（**Ctrl+P**）按钮，点击即可完成本地与自己GitHub中`repo`的同步

### Markdown篇

#### 1.Markdown是什么

**Markdown**是一种轻量级的标记语言，博客内的文章均需采用**markdown**语法编写。**Markdown**采用相对简单的语法（如`#`表示一级标题，`##`表示二级标题）来定义文本的格式与排版，同时具有十分丰富的输出选项（可输出为`html`、 `pdf`、 `word`、 `LaTeX`等格式）。

**Markdown**的**优点**概括起来就是

- 简单易上手的标记语言，让你专注于文字内容，无需顾虑排版
- 强大的输出，可以转化为各种不同格式
- 相对标准化的语法，多平台支持，通用性强
- 支持`html`语言，具有较强的交互性与扩展性
- 纯文本，文件体积小（配合[**图床**](#图床软件推荐)效果更佳）

#### 2.Markdown的语法

> 以下内容大部分引用自[younghz](<https://github.com/younghz/Markdown>)
>
> typora官网也有详尽的[markdown语法文档](<http://support.typora.io/Markdown-Reference/>)，可供参考

Markdown语法主要分为如下几大部分：
**标题**，**段落**，**区块引用**，**代码区块**，**强调**，**列表**，**分割线**，**链接**，**图片**，**反斜杠 `\`**，**符号'`'**。

##### 2.1 标题
使用`#`，可表示1-6级标题。 

> \# 一级标题   
> \## 二级标题   
> \### 三级标题   
> \#### 四级标题   
> \##### 五级标题   
> \###### 六级标题    

效果：  

![header](about-the-site.assets/header.png)

##### 2.2 段落
段落的前后要有空行，所谓的空行是指没有文字内容。若想在段内强制换行的方式是使用**两个以上**空格加上回车（引用中换行省略回车）。

##### 2.3 区块引用
在段落的每行或者只在第一行使用符号`>`,还可使用多个嵌套引用，如：

> \> 区块引用  
> \>> 嵌套引用  

效果：

> 区块引用
>
> > 嵌套引用

##### 2.4 代码

起到标记代码的作用，如：

> \`print("Hello World")`

效果：

> `print("Hello World")`      

此外Hugo跟typora都支持大部分语言的**代码高亮**，语法如下：

~~~markdown
```R
table <- lapply(c("cyl", "gear", "am"), function(x) xtabs(~ vs + get(x), data = mtcars))
```
~~~

效果：

```R
table <- lapply(c("cyl", "gear", "am"), function(x) xtabs(~ vs + get(x), data = mtcars))
```

Hugo支持包括`R`在内的大部分编程语言的**高亮**，但目前还不支持`SAS`:joy:。

##### 2.5 强调
在强调内容两侧分别加上`*`或者`_`，如：  

> \*斜体\*，\_斜体\_ 
>
> \*\*粗体\*\*，\_\_粗体\_\_

效果：  

> *斜体* ，_斜体_ 
>
> **粗体**，__粗体__

##### 2.6 列表
使用`·`、`+`、或`-`标记无序列表，如：  

> \-（+\*） 第一项  
> \-（+\*） 第二项  
> \-（+\*） 第三项

**注意**：标记后面最少有一个空格或制表符。若不在引用区块中，必须和前方段落之间存在空行。

效果：  

> + 第一项
> + 第二项
> + 第三项

有序列表的标记方式是将上述的符号换成数字,并辅以`.`，如：  

> 1 . 第一项   
> 2 . 第二项   
> 3 . 第三项    

效果：  

> 1. 第一项
> 2. 第二项
> 3. 第三项

##### 2.7 分割线
分割线最常使用就是三个或以上`*`，还可以使用`-`和`_`。

##### 2.8 链接
链接可以由两种形式生成：**行内式**和**参考式**。
**行内式**：

> \[学术活动]\(<http://www.phs.zju.edu.cn/redir.php?catalog_id=96968> "Academy"\)

效果： 

> [学术活动](<http://www.phs.zju.edu.cn/redir.php?catalog_id=96968> "Academy")

**参考式**：

```markdown
You can create footnotes like this[^footnote].

[^footnote]: Here is the *text* of the **footnote**.
```

效果如下:

You can create footnotes like this[^footnote].

[^footnote]: Here is the *text* of the **footnote**.

将鼠标移至参考上标会显示相应的内容，相应内容显示在文末。

##### 2.9 图片
添加图片的形式和链接相似，只需在链接的基础上前方加一个`！`。

``` markdown
![Alt text](/path/to/img.jpg "Optional title")
```

##### 2.10 反斜杠`\`
相当于**反转义**作用。使符号成为普通符号。
#### 3.Markdown编辑器推荐

上文已经提到了[*typora*](<https://typora.io/>)，市面上大部分**markdown**编辑器采用的是分栏显示，即左边显示源码，右边显示编译成`html`之后的文档，而typora将二者独立，即实时编译模式（即一边输入一边编译）和源码模式，二者可通过`Ctrl+/`进行切换。

![typora typing](about-the-site.assets/typora typing.gif)

typora的优点：

- 实时编译模式，无分栏，充分享受宽屏输入
- 大量快捷键，提高输入效率
- 图片支持粘贴或直接拖入
- 支持多格式输出（安装`pandoc`后）

##### typora图片引用

在添加文章部分提到了在文章中插入图片的两种方式，网络引用（图床）和本地引用。

图床的使用见[下文](#图床软件推荐)，这里介绍如何设置本地图片的**相对路径引用**

如下图，在全局图像设置里选择复制图片到`./${filename}.assets`文件夹，并且​勾选:heavy_check_mark:**优先使用相对路径**。随后，将图片拖进typora中该图片会自动复制到与文章同目录下的`filename.asset`文件夹里(filename为文章的文件名，中英都可以，英文需**小写**)。

![typora setting](about-the-site.assets/typora setting.png)

**将文章与存放图片的文件夹复制到博客**`content`**目录**

在添加文章的部分提到了新增文章只需要将`.md`文件复制到博客的`content`目录下的相应目录即可，若文中引用的图片均来源于网络（即通过URL引用），那就只需要一个markdown文件。

**若你引用了本地图片，需按照下面的步骤操作：**

假设有一篇文件名为`share-r-code.md`的文章，且文中使用相对路径引用了本地图片，图片在文章同目录下的`share-r-code.assets`文件夹中。

1. 将`share-r-code.md`文件复制到博客的`content\post\all`目录下（文章可以放在`content\post\ `文件夹下或子文件夹中）
2. 在`share-r-code.md`所在目录**新建**一个名为`share-r-code`的文件夹
3. 将`share-r-code.assets`文件夹复制到`share-r-code`文件夹里

**文件结构如下：**

```shell
content
 └─post
    └─all
       │ share-r-code.md
       └─share-r-code
           └─share-r-code.assets
                   fig1.png
                   fig2.png
```
这样做的目的是为了在生成博客文章时能指向正确的图片路径

### 图床软件推荐

图床即可储存图片的云端服务，使用图床后就无需在本地储存`.md`中的图片，typora在mac端可以配合iPic方便地进行图片的上传并自动生成**markdown**语句。Win端也有一款较好用的开源软件，[PicGo](<https://github.com/Molunerfinn/PicGo>)。

PicGo目前支持：  
- `微博图床` v1.0  
- `七牛图床` v1.0  
- `腾讯云COS v4\v5版本` v1.1 & v1.5.0  
- `又拍云` v1.2.0  
- `GitHub` v1.5.0  
- `SM.MS` v1.5.1  
- `阿里云OSS` v1.6.0  
- `Imgur` v1.6.0

推荐使用**GitHub**作为私人图床，**免费**且有**保障**。

具体方法设置方法见[官方文档](<https://picgo.github.io/PicGo-Doc/zh/guide/config.html#github%E5%9B%BE%E5%BA%8A>)





