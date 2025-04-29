---
layout:     post
title:      ImageMagick
subtitle:   图片格式检测工具
date:       2025-05-01 08:02:12 GMT+0800
author:     920
header-img: 
catalog: true
stickie: false
tags:
    - 命令行
---


#### 安装

```bash
brew install imagemagick
```

#### 验证安装

```bash
# convert --version
magick --version
```

#### 检测
```bash
identify image.gif
identify -verbose image.gif
```