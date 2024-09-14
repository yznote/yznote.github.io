---
layout:     post
title:      TableViewCell圆角
subtitle:   TableViewCell圆角
date:       2024-09-14 13:56:21 GMT+0800
author:     920
header-img: 
catalog: true
stickie: false
tags:
    - 圆角
---


##### 圆角

```
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ((indexPath.row+1) == _activeList.count) {
        cell.layer.masksToBounds = YES;
        cell.layer.cornerRadius = 8.0;
        cell.layer.maskedCorners = kCALayerMinXMaxYCorner | kCALayerMaxXMaxYCorner;
    }else {
        cell.layer.cornerRadius = 0.0;
    }
}
```