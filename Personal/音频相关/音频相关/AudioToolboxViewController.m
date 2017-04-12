//
//  AudioToolboxViewController.m
//  音频相关
//
//  Created by vcyber on 16/12/6.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "AudioToolboxViewController.h"
#import <AudioToolbox/AudioToolbox.h>

@interface AudioToolboxViewController ()

@end

@implementation AudioToolboxViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
}

static SystemSoundID soundID = 0;

- (IBAction)play:(id)sender {
    
//    NSString *str = [[NSBundle mainBundle] pathForResource:@"vcyber_waiting" ofType:@"wav"];
    NSString *str = [[NSBundle mainBundle] pathForResource:@"28s" ofType:@"mp3"];
//    NSString *str = [[NSBundle mainBundle] pathForResource:@"48s" ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:str];
    
    
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &soundID);
//
//    AudioServicesAddSystemSoundCompletion(soundID, NULL, NULL, soundCompleteCallBack, NULL);
//    
//    //AudioServicesPlaySystemSound(soundID);
//    
//    AudioServicesPlayAlertSound(soundID);

    
//    AudioServicesPlaySystemSoundWithCompletion(soundID, ^{
//        NSLog(@"播放完成");
//        AudioServicesDisposeSystemSoundID(soundID);
//    });
    
    AudioServicesPlayAlertSoundWithCompletion(soundID, ^{
        NSLog(@"播放完成");
    });
    
}

void soundCompleteCallBack(SystemSoundID soundID, void * clientDate) {
    NSLog(@"播放完成");
    AudioServicesDisposeSystemSoundID(soundID);
}

- (IBAction)stop:(id)sender {
    AudioServicesDisposeSystemSoundID(soundID);
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
