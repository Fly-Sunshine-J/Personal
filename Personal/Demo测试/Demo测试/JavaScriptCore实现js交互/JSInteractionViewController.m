//
//  JSInteractionViewController.m
//  Demo测试
//
//  Created by vcyber on 16/7/5.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "JSInteractionViewController.h"

@interface JSInteractionViewController ()<UIWebViewDelegate, JSInteractionDelegate>

@property (nonatomic, strong) JSContext *jsContext;

@end

@implementation JSInteractionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIWebView *web = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"test" withExtension:@"html"];
    [web loadRequest:[NSURLRequest requestWithURL:url]];
    web.delegate = self;
    [self.view addSubview:web];
}

//在加载之前拦截url  执行一段js代码  //返回YES代表拦截后可以加载 返回NO代表不能加载
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    NSURL *url = request.URL;
    if ([url.scheme isEqualToString:@"file"]) {
        //拼接的参数  不拼接为空
        NSString *dataJson = url.query;
        NSLog(@"%@", dataJson);

        [webView stringByEvaluatingJavaScriptFromString:@"alert('拦截Success')"];
        return YES;
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
    JSValue *shareCallback  = self.jsContext[@"shareCallback"];
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
