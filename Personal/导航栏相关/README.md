# HYNavBarHidden分类
---

超简单好用的监听滚动,导航条渐隐的UI效果实现(时下最流行的UI效果之一)

由于只有一个类文件,大家使用的时候直接拖进去去使用就好.笔者就不做cocoapods导入了.

使用过程中发现bug请先下载最新版，若bug依旧存在，请及时反馈，谢谢

详细使用方法,原理说明,欢迎大家关注笔者简书链接http://www.jianshu.com/p/ac237ebcd4fb.

#HYNavBarHidden的优点<通过分类和继承两种方案实现,大家各凭喜好使用>
---
1.文件少，代码简洁,不依赖其他第三方库

2.接口简单,使用方便

# HYNavBarHidden的使用
---
1.导入分类或者继承<通过分类和继承两种方案实现,大家各凭喜好使用>


2.使用方法,控制器实现接口方法


   -(void)setKeyScrollView:(UIScrollView * )keyScrollView scrolOffsetY:(CGFloat)scrolOffsetY options:(HYHidenControlOptions)options;

#warning 

由于导航控制器有push和pop操作,当有下级控制器时,则两个控制器共用一个导航条.两控制器之间就会产生冲突.

解决方案:

1.当前控制器没有下级的控制器,即避免push操作了.


2.一定要push的话,那push出来的控制器最好使用自定义的导航条,自定义的导航条盖在最上面.

#效果演示
---
![1.gif](http://upload-images.jianshu.io/upload_images/1338042-b49f8c85cef44460.gif?imageMogr2/auto-orient/strip)

###最后在这给大家推荐一个极为好用的图片轮播器.是目前笔者发现封装得最好的图片轮播器之一.github源码链接https://github.com/codingZero/XRCarouselView
---
![3.gif](http://upload-images.jianshu.io/upload_images/1338042-3c3b404123db6f3b.gif?imageMogr2/auto-orient/strip)



