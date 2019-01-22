# ZBCycleVerticalView
上下滚动的跑马灯：类似与淘宝、京东等消息、广告滚动效果

##纵向轮播的视图 可自定义多个属性 控制动画开启关闭
![Jan-22-2019 17-08-35.gif](https://upload-images.jianshu.io/upload_images/5132421-2ae4b63674b02cc4.gif?imageMogr2/auto-orient/strip)


## 使用方式：

导入头文件：
```
#import "ZBCycleVerticalView.h"
```

使用纯代码或XIB声明：
```
@property (strong, nonatomic) IBOutlet ZBCycleVerticalView *cycleView;
```

```
    self.cycleView.direction = ZBCycleVerticalViewScrollDirectionUp;
    self.cycleView.dataArray = array;
    self.cycleView.block = ^(NSInteger index) {
        NSLog(@"%ld",(long)index);
    };
```

## 原理:
使用UIView动画+NSTimer定时器+两个垂直方向的View进行循环轮播，如下图：


![Jan-22-2019 17-18-01.gif](https://upload-images.jianshu.io/upload_images/5132421-9fc3fb1d2c8de0d5.gif?imageMogr2/auto-orient/strip%7CimageView2/2/w/384/format/webp)


简书：https://www.jianshu.com/p/83b0d71df698 <br>
CSDN：https://www.jianshu.com/p/83b0d71df698
