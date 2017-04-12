//
//  BaseViewController.m
//  CAAnimation
//
//  Created by vcyber on 16/5/13.
//  Copyright © 2016年 vcyber. All rights reserved.
//

//transform.scale = 比例轉換
//
//transform.scale.x = 闊的比例轉換
//
//transform.scale.y = 高的比例轉換
//
//transform.rotation.z = 平面圖的旋轉
//
//opacity = 透明度
//
//margin
//
//zPosition
//
//backgroundColor    背景颜色
//
//cornerRadius    圆角
//
//borderWidth
//
//bounds
//
//contents
//
//contentsRect
//
//cornerRadius
//
//frame
//
//hidden
//
//mask
//
//masksToBounds
//
//opacity
//
//position
//
//shadowColor
//
//shadowOffset
//
//shadowOpacity
//
//shadowRadius

//path  CGPath

#import "BaseViewController.h"

@interface BaseViewController ()
@property (weak, nonatomic) IBOutlet UIView *myView;
@property (weak, nonatomic) IBOutlet UIImageView *myImageView;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _myView.frame = CGRectMake(50, 50, 50, 50);
}

//平移
- (IBAction)pingyi:(id)sender {
    
    CABasicAnimation *animation = [CABasicAnimation animation];
    
    //动画类型
    animation.keyPath = @"position";
    
    //动画过程
    animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(50, 50)];
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(200, 200)];
    
    animation.duration = 2.0;
    
    animation.removedOnCompletion = NO;
    
    //保持最新的状态
    animation.fillMode= kCAFillModeForwards;
    
    [self.myView.layer addAnimation:animation forKey:nil];
    
}

//缩放
- (IBAction)suofang:(id)sender {
    
    CABasicAnimation *animation = [CABasicAnimation animation];
    
    //动画类型
    animation.keyPath = @"transform.scale";
    
    //动画过程
    animation.toValue = [NSNumber numberWithInteger:1];
    animation.toValue = [NSNumber numberWithInteger:2];
    
    animation.duration = 2.0;
    
    animation.removedOnCompletion = NO;
    
    //保持最新的状态
    animation.fillMode= kCAFillModeForwards;
    
    [self.myView.layer addAnimation:animation forKey:nil];
    
    
}

//旋转
- (IBAction)xuanzhuan:(id)sender {
    
    CABasicAnimation *animation = [CABasicAnimation animation];
    
    //动画类型
    animation.keyPath = @"transform.rotation.z";
    
    //动画过程
    animation.toValue = [NSNumber numberWithFloat:-M_PI];
    animation.toValue = [NSNumber numberWithFloat:M_PI];
    
    animation.duration = 2.0;
    
    animation.removedOnCompletion = NO;
    
    //保持最新的状态
    animation.fillMode= kCAFillModeForwards;
    
    [self.myView.layer addAnimation:animation forKey:nil];
    
   
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    CIFilter *filter = [CIFilter filterWithName:@"CIBloom"];
//    [filter setDefaults];
//    [filter setValue:[NSNumber numberWithFloat:5.0] forKey:@"inputRadius"];
//    [filter setValue:@"pulseFilter" forKeyPath:@"name"];
//    [self.myImageView.layer setFilters:@[filter]];
//    
//    CABasicAnimation *pulseAnimation = [CABasicAnimation animation];
//    pulseAnimation.keyPath = @"filters.pulseFilter.inputIntensity";
//    pulseAnimation.fromValue = [NSNumber numberWithFloat:0.0];
//    pulseAnimation.toValue = [NSNumber numberWithFloat:1.5];
//    pulseAnimation.duration=1.0;
//    pulseAnimation.repeatCount = HUGE_VALF;
//    pulseAnimation.autoreverses = YES;
//    pulseAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    [self.myImageView.layer addAnimation:pulseAnimation forKey:@"pulseAnimation"];
//    
//    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
//    animation.toValue=[NSNumber numberWithFloat:self.myView.frame.size.width + 100];
//    animation.duration=3.0;
//    animation.removedOnCompletion=NO;
//    animation.fillMode=kCAFillModeForwards;
//    animation.repeatCount = FLT_MAX;
//    animation.autoreverses = YES; //表示按原路径返回动画
//    [self.myImageView.layer addAnimation:animation forKey:nil];
    for ( UITouch *touch in touches) {
        
        NSLog(@"%@",NSStringFromCGPoint([touch locationInView:self.view]));
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
