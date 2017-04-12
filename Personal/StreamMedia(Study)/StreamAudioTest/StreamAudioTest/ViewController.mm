//
//  ViewController.m
//  StreamAudioTest
//
//  Created by dengweihao on 16/4/26.
//  Copyright © 2016年 dengweihao. All rights reserved.
//

#import "ViewController.h"
#import <FreeStreamer/FSAudioStream.h>
#import <FreeStreamer/FSAudioController.h>
#import <ZXingWidgetController.h>
#import <QRCodeReader.h>
@interface ViewController ()<ZXingDelegate>

@property (nonatomic,strong) FSAudioStream *audioStream;
@property (nonatomic, strong) FSAudioController *audioController;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;

@end

@implementation ViewController

- (IBAction)btnClicked:(id)sender {
    if ([self.audioStream isPlaying]) {
        [self.audioStream pause];
    } else {
        [self.audioStream pause];
        [self.audioStream play];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.textLabel.text = @"sahhsadkljhlkhdkhajkldhfajdshfdhalfhaslkjdhfajhdk";
    
//    [self.audioStream play];
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(NSURL *)getFileUrl{
//    NSString *urlStr=[[NSBundle mainBundle]pathForResource:@"镜中人" ofType:@"mp3"];
//    NSURL *url=[NSURL fileURLWithPath:urlStr];
    
    NSURL *url = [NSURL URLWithString:@"http://up.haoduoge.com/mp3/2016-04-29/1461908519.mp3"];
    
    return url;
}

-(FSAudioStream *)audioStream{
    if (!_audioStream) {
        NSURL *url=[self getFileUrl];
        //创建FSAudioStream对象
        _audioStream=[[FSAudioStream alloc]initWithUrl:url];
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = paths[0];
        NSString *fileName = [documentsDirectory stringByAppendingPathComponent:@"test.mp3"];
        NSURL *url1 = [NSURL fileURLWithPath:fileName];
        
        self.audioStream.outputFile = url1;
        
        _audioStream.onFailure=^(FSAudioStreamError error,NSString *description){
            NSLog(@"播放过程中发生错误，错误信息：%@",description);
        };
        _audioStream.onCompletion=^(){
            NSLog(@"播放完成!");
        };
        [_audioStream setVolume:0.5];//设置声音
    }
    return _audioStream;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    ZXingWidgetController *widController = [[ZXingWidgetController alloc] initWithDelegate:self showCancel:NO OneDMode:NO];
    NSMutableSet *readers = [[NSMutableSet alloc] init];
    QRCodeReader *qrcodeReader = [[QRCodeReader alloc] init];
    [readers addObject:qrcodeReader];
    widController.readers = readers;
    [self presentViewController:widController animated:YES completion:^{}];
}

- (void)zxingController:(ZXingWidgetController *)controller didScanResult:(NSString *)result {
    
    NSLog(@"%@", result);
}

- (void)zxingControllerDidCancel:(ZXingWidgetController *)controller {
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
