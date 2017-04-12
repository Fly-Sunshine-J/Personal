//
//  ViewController.m
//  AudioStreamer
//
//  Created by vcyber on 16/4/29.
//  Copyright © 2016年 vcyber. All rights reserved.
//http://up.haoduoge.com/mp3/2016-04-29/1461914292.mp3

#import "ViewController.h"
#import <AudioStreamer.h>
#import <UIButton+WebCache.h>
@interface ViewController ()

@property (nonatomic, strong) AudioStreamer *audioStream;
@property (weak, nonatomic) IBOutlet UIButton *myBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.audioStream = [[AudioStreamer alloc] initWithURL:[NSURL URLWithString:@"http://up.haoduoge.com/mp3/2016-04-29/1461914292.mp3"]];
    
    [self.audioStream start];
    
    [_myBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:@"http://img05.tooopen.com/images/20140604/sy_62331342149.jpg"] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"6704106_233034463381_2"]];
}

- (IBAction)clickBtn:(UIButton *)sender {

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
