//
//  ViewController.m
//  aaa
//
//  Created by vcyber on 16/6/30.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "ViewController.h"
#import "CommentView.h"
#import <YYImage.h>
#import <YYWebImage.h>
#import <objc/runtime.h>
#import "Model.h"
#import <AFNetworking.h>

@interface ViewController ()<UIWebViewDelegate, UITextFieldDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    UIImage *image = [[UIImage imageNamed:@"test"] yy_imageByRoundCornerRadius:100];
//    UIImageView *view = [[UIImageView alloc] initWithImage:image];
//    view.frame = CGRectMake(-100, 100, 100, 100);
//    [self.view addSubview:view];
//    self.imageView = view;
//    
//    UITextField *text = [[UITextField alloc] initWithFrame:CGRectMake(200, 100, 100, 40)];
//    text.backgroundColor = [UIColor redColor];
//    text.placeholder = @"aaaa";
//    
//    
//    [self.view addSubview:text];

//    UIWebView *web = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
//    NSURL *url = [[NSBundle mainBundle] URLForResource:@"test" withExtension:@"html"];
//    [web loadRequest:[NSURLRequest requestWithURL:url]];
//    web.delegate = self;
//    [self.view addSubview:web];
//    
//    NSData *data = UIImagePNGRepresentation([UIImage imageNamed:@"test"]);
//    
//    NSString *str = @"[{\"yid\":\"61\",\"toid\":\"admin\",\"toname\":\"管理员\",\"title\":\"duanxinceshi2\"},{\"yid\":\"63\",\"toid\":\"admin\",\"toname\":\"管理员\",\"title\":\"IQIQIQIQ\"},{\"yid\":\"62\",\"toid\":\"admin\",\"toname\":\"管理员\",\"title\":\"最新测试\"},{\"yid\":\"60\",\"toid\":\"admin\",\"toname\":\"管理员\",\"title\":\"短信测试！\"}]";
//    
//    NSData *data1 = [str dataUsingEncoding:NSUTF8StringEncoding];
// 
//    
//    NSArray *array = [NSJSONSerialization JSONObjectWithData:data1 options:NSJSONReadingMutableLeaves error:nil];
//    NSLog(@"%@", array);
    
    
    unsigned int outCount, i ;
    
    Model *model = [[Model alloc] init];
//    model.name = @"aa";
//    model.sex = YES;
//    model.age = 10;
//    model.height = 175;
    
    objc_property_t *propertyies = class_copyPropertyList([model class], &outCount);
    
    NSMutableArray *array = [NSMutableArray array];
    for (i = 0; i < outCount; i++) {
        objc_property_t property = propertyies[i];
        fprintf(stdout, "%s %s\n", property_getName(property), property_getAttributes(property));
        [array addObject:[NSString stringWithFormat:@"%s", property_getName(property)]];
    }
    
    NSMutableDictionary *dict = [[model dictionaryWithValuesForKeys:array] mutableCopy];
    for (NSString *keys in [dict allKeys]) {
        NSObject *obj = [dict objectForKey:keys];
        if ([obj isKindOfClass:[NSNull class]]) {
            [dict removeObjectForKey:keys];
        }
    }
    
    NSLog(@"%@", dict);
    
    [self getData];
}




- (void)getData {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:@"http://apps.game.qq.com/wmp/v3.1/?p0=7&p1=searchKeywordsList&source=dnf_app_search&page=1&pagesize=20&type=iType&id=0&order=sIdxTime&r1=videolist" parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
       
        NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSString *json1 = [[str componentsSeparatedByString:@"="] lastObject];
        NSRange range = NSMakeRange(0, json1.length - 1);
        NSString *json = [json1 substringWithRange:range];
        NSLog(@"%@", json);
        NSData *jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
        
        NSDictionary *rootDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"%@", rootDic);
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
    }];
    
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

//- (void)webViewDidFinishLoad:(UIWebView *)webView {
//    
//    _jsContext = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
//    _jsContext[@"iOSNative"] = self;
//    _jsContext.exceptionHandler = ^(JSContext *context, JSValue *ec) {
//        
//        context.exception = ec;
//        NSLog(@"%@", ec);
//    };
//}
//
//- (void)share:(NSString *)shareContent {
//    
//    NSLog(@"%@", shareContent);
//    JSValue *shareCallback  = self.jsContext[@"shareCallback"];
//    [shareCallback callWithArguments:@[@"成功"]];
//}



- (void)viewWillAppear:(BOOL)animated {
    unsigned int count = 0;
    Ivar *ivarlist = class_copyIvarList([UITextField class], &count);
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivarlist[i];
        NSLog(@"%s  %s", ivar_getName(ivar), ivar_getTypeEncoding(ivar));
        
    }
    free(ivarlist);
}

- (IBAction)click:(UIButton *)sender {
    
//    CommentView *view = [[CommentView alloc] initWithFrame:CGRectZero];
//    view.str = @"aa";
//    [view showCommentView];
    
//    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
//        
//        self.imageView.frame = CGRectMake(100, 100, 100, 100);
//        
//    } completion:^(BOOL finished) {
//        
//        
//    }];
   
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
//    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
//    picker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:picker.sourceType];
    
    [self presentViewController:picker animated:YES completion:nil];
    
    
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    if ([[info objectForKey:UIImagePickerControllerMediaType] isEqualToString:[UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypePhotoLibrary].firstObject]) {
        UIImage *image = [info objectForKey:self.isEditing ? UIImagePickerControllerEditedImage : UIImagePickerControllerOriginalImage];
        if (image) {
            NSLog(@"选取成功");
            self.view.backgroundColor = [UIColor colorWithPatternImage:image];
            [picker dismissViewControllerAnimated:YES completion:nil];
        }else {
            NSLog(@"选取失败");
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
