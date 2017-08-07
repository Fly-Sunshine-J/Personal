/**
 上传文件 :
 当应用处于active状态: 不断地调用进度Block 并且不会走关于后台的一切block
 当应用处于background状态: 不会调用进度Block,等待结束后,执行与后台有关的Block
 多个后台的SessionDataTask 都完成后统一回调setDidFinishEventsForBackgroundURLSessionBlock
 */
#import "ViewController.h"
#import "AppDelegate.h"
#import "CYWLocalNotificationManager.h"

#import <AFNetworking/AFNetworking.h>
#import <AFNetworking/UIImageView+AFNetworking.h>

#define cyw_upload_urlString @"http://120.25.226.186:32812/upload"

NSString * const backgroundID = @"cyw.backgroundID.haha";
@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic , strong)NSArray *datas;


@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)click:(id)sender {
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:cyw_upload_urlString];
    AFURLSessionManager *mgr = [[AFURLSessionManager alloc] initWithSessionConfiguration:config];
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"leaves_70.jpg" ofType:nil];
    NSURL *fileURL = [NSURL fileURLWithPath:path];
    
    AFHTTPRequestSerializer *rs = [AFHTTPRequestSerializer serializer];
    NSError *error;
    NSMutableURLRequest *uploadRequest = [rs requestWithMethod:@"POST" URLString:cyw_upload_urlString parameters:nil error:&error];
    [uploadRequest setValue:@"sahgdkjaskjdjksajhdgaskjd" forHTTPHeaderField:@"hhhhh"];
    
    
    NSLog(@"--初始化uploadRequest  %@ -- ",error);
    NSURLSessionUploadTask *uploadTask = [mgr uploadTaskWithRequest:uploadRequest fromFile:fileURL progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"--111111 上传中   %f --" , uploadProgress.fractionCompleted);
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        NSLog(@"完成了 %@ ", error);
    }];
    
    [uploadTask resume];
    [mgr setDidFinishEventsForBackgroundURLSessionBlock:^(NSURLSession * _Nonnull session) {
        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        if (appDelegate.backgroundSessionCompletionHandler) {
            AppBackgroundUpLoadSessionCompletionHandler completionHandler = appDelegate.backgroundSessionCompletionHandler;
            appDelegate.backgroundSessionCompletionHandler = nil;
            // do something (刷新UI)
            completionHandler();
            NSLog(@"setDidFinishEventsForBackgroundURLSessionBlock  后台完成了" );
            [[CYWLocalNotificationManager defaultManager] fireLocalNotficationWithDelay:0];
        }
    }];
    
}



@end
