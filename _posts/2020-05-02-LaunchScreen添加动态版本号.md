---
layout:     post
title:      LaunchScreen添加动态版本号
subtitle:  	版本号
date:       2020-05-02 15:19:30 +0800
author:     920
header-img: 
catalog: true
stickie: false
tags:
    - Launch版本号
---

首先，在`LaunchScreen.storyboard`添加一个`Label`

然后设置`Document`->`APP_VERSION` 如图:

![项目1](/img/20200502/1.png)

接着点击选择工程的`target`,选择`Build Phases`,点击`+`按钮，选择`New Run Script Phase`,双击新增的条目重命名`Update Version`(你开心命名什么都可以),然后拖动这条新增的条目放到`Copy Bundle Resources`之前,这个是我操作完毕的截图:

![项目2](/img/20200502/2.png)

![项目3](/img/20200502/3.png)

脚本内容:


```
# Type a script or drag a script file from your workspace to insert its path.
#   ON/OFF Script Toggle (script ON with #, script OFF without #)
#exit 0

#   Increment Build Number Bool (Increment ON with true, increment OFF with false)
shouldIncrement=fale


#   App vesion / Build version constants
sourceFilePath="$PROJECT_DIR/$PROJECT_NAME/Other/Base.lproj/LaunchScreen.storyboard"
versionNumber="$MARKETING_VERSION"
buildNumber="$CURRENT_PROJECT_VERSION"


#   Increment build number
if [ "$shouldIncrement" = true ]; then
    buildNumber=$(($buildNumber + 1))
    /usr/libexec/PlistBuddy -c "Set :CFBundleVersion $buildNumber" "$INFOPLIST_FILE"
fi

#   Output version & build numbers into a label on LaunchScreen.storyboard
sed -i .bak -e "/userLabel=\"APP_VERSION\"/s/text=\"[^\"]*\"/text=\"version:$versionNumber($buildNumber)\"/" "$sourceFilePath"
```



