//
//  NextViewController.m
//  aaa
//
//  Created by vcyber on 16/7/4.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "NextViewController.h"

@interface NextViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (nonatomic, strong) JSContext *jsContext;

@end

@implementation NextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[[NSBundle mainBundle] URLForResource:@"test" withExtension:@"html"]];
    self.webView.delegate = self;
    [self.webView loadRequest:request];
    
}


//拦截URL执行一段js
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    NSURL *url = request.URL;
    NSLog(@"%@", url.scheme);
    if ([url.scheme isEqualToString:@"file"]) {
        NSString *dataJson  = url.query;
        NSString *str = dataJson.stringByRemovingPercentEncoding;
        NSLog(@"%@", str);
        [webView stringByEvaluatingJavaScriptFromString:@"alert('Success')"];
        return NO;
    }
    return YES;
}


- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    _jsContext = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    _jsContext[@"iOSNative"] = self;
    _jsContext.exceptionHandler = ^(JSContext *context, JSValue *ec) {
        
        context.exception = ec;
        NSLog(@"%@", ec);
    };
}

- (void)share:(NSString *)shareContent {
    
    NSLog(@"%@", shareContent);
    JSValue *shareCallback = self.jsContext[@"shareCallback"];
    [shareCallback callWithArguments:@[@"成功"]];
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
