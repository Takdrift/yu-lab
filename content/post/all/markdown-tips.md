---
title: "Markdown实用技巧"  # 文章标题，同时为博客页中显示的标题
date: 2019-04-25  # 创建日期
lastmod: 2019-04-25  # 最后修改日期
draft: false  # =true为草稿，不会生成相应的网页，!!!需要改为false才能生成相应网页!!!
# slug: ""  # 所生成网页的地址后缀，若未设置，会根据文件名生成地址

# keywords, tags, categories都可以设置多个，中间需要用英文逗号(,)隔开
keywords: [markdown]  # 关键字
tags: [markdown]  # 标签，会将此文章添加到相应的标签下（建议查看既往的标签，防止相同含义的不同标签）
categories: []  # 分类，会将此文章添加到指定的分类下（建议使用各自的姓名，且只设置一个分类）
author: "Yu Group"  # 作者，会显示在文末
---

# HTML

## iframe

Markdown支持html语言，所以可以通过iframe添加第三方内容到我们的网页（网页、flash、视频等）中，语法如下：

```html
<Iframe src="https://www.webfx.com/tools/emoji-cheat-sheet/"; 
width="1000" height="2000" scrolling="yes" frameborder="0"></iframe>
```

**语法注释：**

- `src`：引用内容的地址
- `width`和`height`：框架的大小
- `scrolling`：是否有滚动条（YES | NO | AUTO）
- `frameborder`：设置边框是否为3维

**举例：**

1. :smile:[EMOJI CHEAT SHEET](/post/all/emoji-cheat-sheet/):smile:这篇文章就是用到了上面的`iframe`语句插入了来自`https://www.webfx.com/tools/emoji-cheat-sheet/`的内容。



2. 同样[舟山孕妇血样情况](/post/shao-bule/2016-2018-zhoushan-blood-sample/#六-其他疾病信息)这篇文章中的:point_down:**词云**:point_down:也是用`iframe`添加到网页中的。

<Iframe src="/post/shao-bule/2016-2018-zhoushan-blood-sample/2016-2018-zhoushan-blood-sample.assets/wordcloud";; width="600" height="400" scrolling="no" frameborder="0"></iframe>

## 图片设置

1. **调整图片大小及位置**

在插入一张宽度小于网页宽度的图片时图片是自动**向左对齐**的，比如：

```markdown
![black hole](https://t.cn/Ea3vfXb)
```

:point_down:效果:point_down:

![black hole](https://t.cn/Ea3vfXb)

**若想使图片居中目前能通过html语法实现，具体语法如下​**:point_down:

```html
<div align=center><img src="https://t.cn/Ea3vfXb" alt="black hole"/></div>
```

**语法注释：**

- `<div align=center><img src="图片路径or链接" alt="图片名称（非必填）"/></div>`
- `align=center`使图片居中

<div align=center><p>:point_down:效果:point_down:</p></div>

<div align=center><img src="https://t.cn/Ea3vfXb" alt="black hole"/></div>

还能通过`width`和`height`设置**固定尺寸**:point_down:

```html
<div align=center><img src="https://t.cn/Ea3vfXb" width="300" alt="black hole"/></div>
```

**Tips:**

- `width`与`height`只设置其一则会自动等比缩放，若两者都设置则**hugo**会以`width`为准进行缩放而忽略`height`，而**typora**会根据两者具体值进行缩放
- `width`还可以用**百分比**设置，如`width="50%"`

<div align=center><img src="https://t.cn/Ea3vfXb" width="300" alt="black hole"/></div>