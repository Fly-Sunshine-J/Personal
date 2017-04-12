//
//  ViewController.m
//  StreamMedia(Study)
//
//  Created by vcyber on 16/5/4.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "ViewController.h"
#import "JFYSoundEffect.h"
#import "VMAudioPlayer.h"
#import "JFYMusicModel.h"
#import "FXBlurView.h"
#import "JFYRecordController.h"


#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

@interface ViewController ()//<ZXingDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor= [UIColor yellowColor];
    
    UIView * aview = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
//    aview.backgroundColor = RGBACOLOR(42, 47, 61, 0.6);
//    aview.backgroundColor = RGBACOLOR(42, 47, 61, 0.6);
//    aview.layer.masksToBounds = YES;
//    aview.layer.cornerRadius = 10.0;
//    aview.blurRadius = 4.0;
//    aview.dynamic = YES;
//    aview.tintColor = [UIColor colorWithWhite:0.2 alpha:0.2];                    //动态改变模糊效果
    
//    [self.view addSubview:aview];
//    
//    FXBlurView *bview = [[FXBlurView alloc] initWithFrame:CGRectMake(100, 100, 150, 150)];
//    
////    bview.backgroundColor = RGBACOLOR(42, 47, 61, 0.6);
//    bview.layer.masksToBounds = YES;
//    bview.layer.cornerRadius = 10.0;
//    bview.blurRadius = 4.0;
//    bview.dynamic = NO;
//    bview.tintColor = [UIColor colorWithWhite:0.2 alpha:0.2];
//    
//    
//    [self.view addSubview:bview];
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    NSLog(@"touchesBegan%@", NSStringFromCGPoint([[touches anyObject] locationInView:self.view]));
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    NSLog(@"touchesMoved%@", NSStringFromCGPoint([[touches anyObject] locationInView:self.view]));
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    NSLog(@"touchesEnded%@", NSStringFromCGPoint([[touches anyObject] locationInView:self.view]));
}


- (IBAction)soundEffect:(id)sender {
    
//    [[JFYSoundEffect shareSoundEffect] playSoundEffect:@"vcyber_harp.wav"];
    
    
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    transition.type = kCATransitionPush;
    if ([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeLeft) {
        transition.subtype = kCATransitionFromBottom;
    }else{
        transition.subtype = kCATransitionFromTop;
    }
    
    transition.delegate = self;
    UIViewController *viewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"JFYRecordController"];
    [self.navigationController.view.layer  addAnimation:transition forKey:@"push"];
    [self.navigationController pushViewController:viewController animated:NO];
}


- (IBAction)musicPlay:(id)sender {
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
    [audioSession setActive:YES error:nil];
    
    JFYMusicModel *model = [[JFYMusicModel alloc] init];
    model.musicURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"庄心妍-以后的以后" ofType:@"mp3"]];
    model.music = @"以后的以后";
    model.singer = @"庄心妍";
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:model];
    [[VMAudioPlayer shareVMAVPlayer] createAudioPlayerWithPlayList:array];
    [[VMAudioPlayer shareVMAVPlayer] play];
    
}

- (IBAction)scan2:(id)sender {
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
