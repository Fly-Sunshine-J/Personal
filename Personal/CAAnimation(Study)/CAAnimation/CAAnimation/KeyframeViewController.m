//
//  KeyframeViewController.m
//  CAAnimation
//
//  Created by vcyber on 16/5/13.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "KeyframeViewController.h"
#import "ImageViewPoint.h"

#define ENDRADIUS               120.0f
#define FARRADIUS               140.0f

@interface KeyframeViewController ()

@property (nonatomic, strong) NSArray *nameArray;
@property (weak, nonatomic) IBOutlet UIButton *startBtn;

@end

@implementation KeyframeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        NSString *str = @"\u6211\u4e0d\u662f\u6765\u9a97\u8d34\u7684 \u6211\u771f\u7684 \u6bcf\u5929 \u5c31\u5e26 \u8fd9\u4e24\u6837\u4e1c\u897f \u4e0a\u4e0b\u73ed\u3002\u78d5\u5f97\u5751\u5751\u6d3c\u6d3c\u7684iphone5s\u4ee5\u53ca\u4e00\u628a\u94a5\u5319\u3002\u4f5c\u4e3a\u4e00\u4f4d\u5f20\u5927\u5988\u65b0\u624b \u770b\u4e86\u5927\u5bb6\u7684EDC \u89c9\u5f97\u6bcf\u4e2a\u4eba\u6d3b\u7684\u90fd\u5f88\u7cbe\u81f4 \u5f88\u8bb2\u7a76\u3002\u4f46\u662f\u6211\u4e5f\u60f3\u4ee3\u8868\u6211\u4eec\u7b80\u5355\u4e00\u65cf\u53d1\u53d1\u58f0 \u4e8e\u662f\u6709\u4e86\u4eca\u5929\u7684\u8fd9\u7bc7EDC\u3002\u4e0d\u7528\u6000\u7591 \u672c\u4eba\u5973 \u7231\u597d\u7537\u3002\u4f46\u662f\u672a\u5a5a\u5355\u8eab \uff08\u8fd9\u8ddf\u6d3b\u5f97\u7cd9\u6ca1\u5173\u7cfb \u5355\u7eaf\u662f\u56e0\u4e3a\u6211\u957f\u5f97\u4e11\uff09\u57fa\u672c\u4e0a \u8fd9\u4e24\u6837\u4e1c\u897f\u80fd\u6ee1\u8db3\u6211\u6240\u6709\u9700\u6c42\u3002\u94b1\u5305\uff1f\u624b\u673a\u91cc\u6709apple pay\u3001\u5fae\u4fe1\u652f\u4ed8\u3001\u652f\u4ed8\u5b9d\u3002\u8ddf\u670b\u53cb\u805a\u9910\uff1f\u7f8e\u56e2\u3001\u7cef\u7c73\u5728\u7ebf\u4e70\u5355\u3002\u7eb8\u5dfe\uff1f\u529e\u516c\u5ba4\u548c\u8f66\u4e0a\u90fd\u5907\u6709\u3002\u542c\u6b4c\uff1f\u8f66\u4e0a\u6709player\u6709\u97f3\u54cd\u3002\u4e34\u65f6\u5de5\u4f5c\uff1f\u4e00\u53f0\u667a\u80fd\u624b\u673a\u8db3\u591f\u3002less is more\u3002\u5c11 \u5c31\u662f \u591a\u3002==================================\u5206\u5272\u7ebf====================================<br \/>\n<img src='http:\/\/mask.cloudsdee.com\/uploads\/article\/20160427\/f811707db5f25e989a6069eb99bedbcd.jpg'\/><br \/>\n\u4e3a\u4e86\u8868\u793a\u81ea\u5df1\u4e0d\u662f\u6765\u9a97\u8d34\u7684\u4ee5\u53ca\u771f\u662f\u4e2a\u59b9\u5b50\u3002\u4e0e\u5927\u5bb6\u5206\u4eab\u6211\u7684\u529e\u516c\u5ba4\u5e94\u6025\u5316\u5986set\u3002\u6240\u8c13\u5e94\u6025 \u5c31\u662f\u4e34\u65f6\u6709\u9700\u8981\u7684\u60c5\u51b5\u3002\u6bd4\u5982\u76f8\u4eb2\u3002\u6bd4\u5982\u54e5\u4eec\u9700\u8981\u6491\u573a\u9762\u3002\u6bd4\u5982\u76ae\u80a4\u51fa\u73b0\u7d27\u6025\u72b6\u51b5\u3002\u6240\u4ee5\u4e5f\u662f\u7b80\u5355\u4e3a\u4e3b\u3002\u5de6\u81f3\u53f3\u5206\u522b\u662f\u83f2\u8bd7\u5c0f\u94fa\u7c89\u997c\u3001\u96c5\u8bd7\u5170\u9edb\u776b\u6bdb\u818f\u5c0f\u6837\u6d53\u5bc6\u3001\u52a0\u957f\u5404\u4e00\u3001\u96c5\u8bd7\u5170\u9edb\u53e3\u7ea2\u3001\u5206\u88c5\u74f6\u88c5\u7684\u662fMUJI\u7684\u9ad8\u4fdd\u6e7f\u6c34\u3001\u9999\u6c34\u5c0f\u6837\uff08\u8fd9\u4e2a\u4e0d\u91cd\u8981\uff09\u3001holikaholika\u5507\u818f\u3001\u83f2\u8bd7\u5c0f\u94fa\u8428\u6469\u62a4\u624b\u971c\u3001\u9999\u8549\u62a4\u624b\u971c\u3001\u96c5\u987f\u516b\u5c0f\u65f6\u971c\u4e2d\u6837\u3001\u4ee5\u53ca\u60a6\u6728\u4e4b\u6e90\u5341\u5206\u949f\u6025\u6551\u9762\u819c\u3002\u5c31\u6311\u51e0\u4e2a\u8bf4\u4e00\u8bf4\u3002lovely ME:EX Angel Skin powder pact. \u8272\u53f7NB23\u3002\u5728\u7ebd\u7ea6\u6cd5\u62c9\u76db\u7684\u97e9\u56fd\u5316\u5986\u54c1\u5c0f\u5e97\u91cc\u4e70\u7684\u3002\u4ef7\u683c\u5927\u7ea6100\u5143\u4eba\u6c11\u5e01\u3002\u4f18\u70b9\u662f\u5916\u5f62\u7c89\u7c89\u7684\u5f88\u53ef\u7231\uff0c\u65b9\u4fbf\u643a\u5e26\uff0c\u914d\u6709\u955c\u5b50\uff0c\u9999\u9999\u7684\uff0c\u7c89\u672b\u5f88\u7ec6\uff0c\u906e\u7455\u529b\u4e2d\u7b49\u504f\u4e0b\uff0c\u4f46\u6bcf\u6b21\u7528\u90fd\u6709\u79cd\u5237\u5899\u7684\u9519\u89c9\uff1b\u7f3a\u70b9\u662f\u7565\u5e72\u3002\u6211\u5176\u5b9e\u76ae\u80a4\u72b6\u6001\u8fd8\u53ef\u4ee5 \u6240\u4ee5\u4e0d\u662f\u5f88\u5728\u4e4e\u7c89\u997c\u7684\u906e\u7455\u529b\u3002\u4f46\u662f\u8fd9\u73a9\u610f\u7684\u9999\u5473\u6bcf\u6b21\u7528\u5b8c\u6211\u90fd\u6253\u55b7\u568f\u3002\u547c\u5438\u9053\u8fc7\u654f\u60a3\u8005\u614e\u7528\u3002<br \/>\n<img src='http:\/\/mask.cloudsdee.com\/uploads\/article\/20160427\/4f8afe15e1fc44d4a56f6d5a22b06ed8.jpg'\/><br \/>\n<br \/>\n<img src='http:\/\/mask.cloudsdee.com\/uploads\/article\/20160427\/b15df99d00d6384c4e57c95682a6aa09.jpg'\/><br \/>\n<br \/>\n<br \/>\n<img src='http:\/\/mask.cloudsdee.com\/uploads\/article\/20160427\/9a7ebff664e49578d9f866c9864ea659.jpg'\/><br \/>\n<br \/>\n\u8fd9\u4e2a\u5507\u818f\u662f\u53bb\u6d4e\u5dde\u5c9b\u7684\u65f6\u5019\u5728\u514d\u7a0e\u5e97\u7ed9\u670b\u53cb\u4e70\u624b\u4fe1\u7684\u65f6\u5019\u4e70\u7684\uff0c\u5927\u6982100\u5757\u4eba\u6c11\u5e01\u4e94\u4e2a\u3002\u4f18\u70b9\u662f\u5916\u578b\u7279\u522b\u53ef\u7231 \u818f\u4f53\u5f88\u6ecb\u6da6 \u5e26\u6709\u4e00\u70b9\u70b9\u7ea2\u8272 \u4f1a\u6839\u636e\u4f53\u6e29\u53d8\u5316 \u4ef7\u683c\u4fbf\u5b9c\u3002\u7f3a\u70b9\u662f\u6709\u4e9b\u670b\u53cb\u8bf4\u7528\u4e86\u4f1a\u5728\u5634\u4e0a\u5f62\u6210\u4e00\u5c42\u76ae\u3002<br \/>\n<img src='http:\/\/mask.cloudsdee.com\/uploads\/article\/20160427\/963fc929db257ac37dd7a2f453072190.jpg'\/><br \/>\n\u8fd9\u4e24\u4e2a\u62a4\u624b\u971c\u4e5f\u662f\u6d4e\u5dde\u5c9b\u514d\u7a0e\u5e97\u4e70\u7684\u624b\u4fe1\u3002\u90fd\u662f100\u57574\u4e2a\u3002\u5176\u5b9e\u90fd\u662f\u770b\u5916\u5f62\u4e70\u7684 \u5b9e\u8d28\u6bd4\u4e13\u4e1a\u62a4\u624b\u971c\u8fd8\u662f\u6709\u8ddd\u79bb\u3002\u76f8\u6bd4\u8f83\u800c\u8a00 \u4e24\u4e2a\u818f\u4f53\u4e00\u4e2a\u7a00\u4e00\u4e2a\u7a20\u3002\u56e0\u4e3a\u8428\u6469\u62a4\u624b\u971c\u6211\u5df2\u7ecf\u7528\u5b8c\u4e86 \u5c31\u4e0d\u62cd\u818f\u4f53\u51fa\u6765\u4e86\u3002\u8fd9\u662f\u9999\u8549\u62a4\u624b\u971c\u7684\u818f\u4f53 \u8981\u591a\u63a8\u51e0\u6b21\u624d\u80fd\u63a8\u5f00\u3002<br \/>\n<img src='http:\/\/mask.cloudsdee.com\/uploads\/article\/20160427\/4b05cc26f3ab560a77f08c32aeb7fc6a.jpg'\/><br \/>\n\u6709\u5f88\u6d53\u90c1\u7684\u9999\u8549\u5473 \u662f\u529e\u516c\u5ba4\u4e00\u9053\u98ce\u666f\u7ebf\u3002\u867d\u7136\u5f88\u6d53\u7a20 \u4f46\u6ecb\u6da6\u7a0b\u5ea6\u4e0d\u5982\u83f2\u8bd7\u5c0f\u94fa\u7684\u8428\u6469\u3002\u8fd9\u91cc\u5949\u4e0a\u4e00\u4e2a\u51cf\u80a5TIP \u8fd9\u4e9b\u7c7b\u4f3c\u98df\u7269\u7684\u9999\u5473\u5e38\u5e38\u4f1a\u8ba9\u4f60\u9519\u89c9\u5df2\u7ecf\u5403\u8fc7\u996d\u4e86 \u63a7\u5236\u98df\u6b32 \u5230\u4e86\u996d\u70b9\u5c31\u4e0d\u89c9\u5f97\u997f\u4e86\u3002<br \/>\n<img src='http:\/\/mask.cloudsdee.com\/uploads\/article\/20160427\/5a8580c716aa447d991fc3e98d99e9aa.jpg'\/><br \/>\n<img src='http:\/\/mask.cloudsdee.com\/uploads\/article\/20160427\/bc11b27ac9733a45c56a2dace6f562f3.jpg'\/><br \/>\nANYWAY \u8fd8\u662f\u4e0d\u63a8\u8350\u9999\u8549\u62a4\u624b\u971c\u3002\u5b9e\u7528\u6027\u8fd8\u662f\u83f2\u8bd7\u5c0f\u94fa\u8428\u6469\u7565\u80dc\u4e00\u7b79\u3002\u4ed6\u5bb6\u8fd8\u6709\u5176\u4ed6\u7684\u5c0f\u52a8\u7269 \u732b\u54aa\u3001\u5c0f\u718a\u7b49\u7b49\u3002\u96c5\u987f\u516b\u5c0f\u65f6\u662f\u67d0\u6b21\u4e27\u5fc3\u75c5\u72c2\u4e70\u4e86\u96c5\u987f\u7684\u6297\u8001\u971c\uff08\u4f46\u662f\u7528\u4e86\u4e00\u6b21\u53d1\u73b0\u592a\u6cb9\u4e86 \u4e0d\u9002\u5408\u6211\u8fd9\u6837\u7684\u9752\u6625\u4e11\u5c11\u5973\uff09\u9001\u7684\u4e2d\u6837\u3002\u818f\u4f53\u975e\u5e38\u9ecf \u5473\u9053\u4e5f\u6781\u4e3a\u4e0d\u597d\u95ee \u4e0d\u4e60\u60ef\u7684\u4eba\u4f1a\u89c9\u5f97\u5f88\u81ed\u3002\u7528\u6765\u6d82\u8eab\u4f53\u592a\u9ecf\u4e86 \u4e0d\u559c\u6b22 \u5c31\u4e00\u76f4\u95f2\u7f6e \u8fde\u62a4\u624b\u90fd\u4e0d\u613f\u610f\u6d3e\u4ed6\u4e0a\u573a\u3002\u67d0\u5929\u770b\u4e86\u5317\u7f8exx\u5feb\u62a5 \u63a8\u8350\u8bf4\u7f8e\u56fd\u79c0\u573a\u7684\u5316\u5986\u5e08\u5728\u5986\u524d\u90fd\u4f1a\u7528\u8fd9\u4e2a\u4e3a\u827a\u4eba\u5904\u7406\u5634\u5507 \u6240\u4ee5\u6211\u4e5f\u7528\u6765\u6d82\u5634\u5507 \u610f\u5916\u53d1\u73b0\u975e\u5e38\u6da6 \u5f88\u8212\u670d \u4e5f\u4e0d\u4f1a\u8ba9\u4eba\u770b\u8d77\u6765\u5634\u4e0a\u6cb9\u6cb9\u7684\u6ca1\u64e6\u5634\u7684\u611f\u89c9\u3002<br \/>\n<img src='http:\/\/mask.cloudsdee.com\/uploads\/article\/20160427\/0d3bcf73f1d93d90a243b31dc2f7494e.jpg'\/><br \/>\n\u4e0d\u63a8\u8350\u4e70\u6b63\u54c1 \u53ef\u4ee5\u8003\u8651\u4e70\u5c0f\u6837\u6216\u8005\u4e70\u96c5\u987f\u5176\u4ed6\u4ea7\u54c1\u65f6\u8981\u6c42\u8d60\u9001\u3002\u5341\u5206\u949f\u6025\u6551\u6e05\u6d01\u578b\u9762\u819c \u5e74\u521d\u60a6\u6728\u4e4b\u6e90\u7f8e\u56fd\u5b98\u7f51\u6ee125\u5200\u51cf10\u5200\u7684\u6d3b\u52a8\u4ef7\u4e70\u7684\u3002\u73b0\u5728\u8fd8\u6709\u6ee145\u5200\u51cf20\u7684\u6d3b\u52a8\u3002\u5171\u5356\u4e86\u4e24\u53ea \u4e00\u996e\u800c\u5c3d\u548c\u8fd9\u4e2a \u6bcf\u53ea15\u5200\u3002\u8fd8\u9001\u4e86\u4e00\u5806\u5c0f\u6837\u793c\u54c1\u3002\u767d\u8272\u7259\u818f\u72b6 \u6d82\u5728\u8138\u4e0a\u5e72\u4e86\u4e4b\u540e\u6d17\u6389 \u80fd\u591f\u7f13\u89e3\u76ae\u80a4\u53d1\u7ea2 \u7206\u6cb9 \u6697\u6c89\u7b49\u7b49\u591a\u79cd\u7a81\u53d1\u72b6\u51b5\u3002\u6211\u4e00\u822c\u662f\u5728\u9762\u5bf9\u4e86\u4e00\u5929\u7535\u8111 \u76ae\u80a4\u72b6\u51b5\u53c8\u5dee\u7684\u60c5\u51b5\u4e0b\u7528\u7684\u3002\u5316\u5b66\u5927\u795e\u53ef\u4ee5\u7814\u7a76\u4e00\u4e0b\u6210\u5206\u3002<br \/>\n<img src='http:\/\/mask.cloudsdee.com\/uploads\/article\/20160427\/ccf7c9f82b0be6445e230f297a572514.jpg'\/><br \/>\n<br \/>\n<img src='http:\/\/mask.cloudsdee.com\/uploads\/article\/20160427\/ee9f85bbce221cf75fa0795120d4eabc.jpg'\/><br \/>\n<br \/>\n<img src='http:\/\/mask.cloudsdee.com\/uploads\/article\/20160427\/87ebb5577fc28b687c1c0b5f87ed27e1.jpg'\/><br \/>\n\u4f18\u70b9\u662f\u5e94\u6025\u6548\u679c\u4e0d\u9519 \u9547\u9759\u76ae\u80a4 \u53bb\u9664\u6b7b\u76ae\u53ca\u6bdb\u5b54\u6c61\u57a2\u3002\u7f3a\u70b9\u662f\u5728\u529e\u516c\u5ba4\u9876\u7740\u4e00\u5f20\u767d\u8138\u592a\u5c34\u5c2c\uff1b\u800c\u4e14\u6bd4\u8f83\u5e72 \u53ea\u80fd\u7528\u5728T\u533a \u6216\u8005\u6cb9\u76ae\u9002\u7528\uff1b\u8fd8\u662f\u7a0d\u5fae\u523a\u6fc0\u7684\uff0c\u76ae\u80a4\u8fc7\u654f\u7684\u614e\u7528\u3002\u8bf7\u65e0\u89c6\u6211\u9ed1\u9ed1\u7684\u722a\u5b50\u3002\u6bd5\u7adf\u5728\u767d\u8272\u80cc\u666f\u524d\u8c01\u90fd\u767d\u4e0d\u8d77\u6765\u3002\u4ee5\u4e0a\u3002<br \/>\n<img src='http:\/\/mask.cloudsdee.com\/uploads\/article\/20160427\/0fc9a5f2efb2cc59e68849926c35b399.jpg'\/>";
    
    str = [KeyframeViewController replaceUnicode:str];
    
    NSArray *imageName = @[@"top_more1", @"top_start", @"top_favorit", @"person_info", @"top_v"];
    self.nameArray = imageName;
    NSInteger count = imageName.count;
    
    double pi4 = M_PI_2 / (count - 2);
    
    for (int i = 0; i < count; i++) {
        
        ImageViewPoint *imageView = [[ImageViewPoint alloc] initWithImage:[UIImage imageNamed:imageName[i]]];
        imageView.frame = CGRectMake(50, 300, 50, 50);
        if (i == 0) {
            
            imageView.hidden = NO;
        }else {
            imageView.hidden = YES;
            imageView.startPoint = imageView.center;
            imageView.farPoint = CGPointMake(imageView.startPoint.x + FARRADIUS * cos(pi4 * (i - 1)), imageView.startPoint.y - FARRADIUS * sin(pi4 * (i- 1)));
            imageView.endPoint = CGPointMake(imageView.startPoint.x + ENDRADIUS * cos(pi4 * (i - 1)), imageView.startPoint.y - ENDRADIUS * sin(pi4 * (i- 1)));
            imageView.tag = 100 + i;
        }
        
        [self.view addSubview:imageView];
    }
    
}

+ (NSString *)replaceUnicode:(NSString *)unicodeStr {
    
    NSString *tempStr1 = [unicodeStr stringByReplacingOccurrencesOfString:@"\\u"withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""];
    NSString *tempStr3 = [[@"\"" stringByAppendingString:tempStr2]stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString* returnStr = [NSPropertyListSerialization propertyListFromData:tempData
                                                          mutabilityOption:NSPropertyListImmutable
                                                                    format:NULL
                                                          errorDescription:NULL];
    
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n"withString:@"\n"];
}


- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
}


- (IBAction)clickBtn:(id)sender {
    UIButton *btn = (UIButton *)sender;
    
    if (btn.selected) {
        [self close];
        
    }else {
        
        [self expand];
    }
    
    btn.selected = !btn.selected;
}


- (void)expand {
    
    for (int i = 1; i < _nameArray.count; i ++) {
        ImageViewPoint *imageView = [self.view viewWithTag:100 + i];
        imageView.hidden = NO;
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathMoveToPoint(path, NULL, imageView.startPoint.x, imageView.startPoint.y);
        CGPathAddLineToPoint(path, NULL, imageView.farPoint.x, imageView.farPoint.y);
        CGPathAddLineToPoint(path, NULL, imageView.endPoint.x, imageView.endPoint.y);
        animation.path = path;
        CGPathRelease(path);
        animation.duration = .4;

        CABasicAnimation *
roateanimation = [CABasicAnimation animation];
        roateanimation.keyPath = @"transform.rotation.z";
        roateanimation.fromValue = [NSNumber numberWithFloat:-M_PI * 2];
        roateanimation.toValue = [NSNumber numberWithFloat:M_PI * 2];
        roateanimation.duration = .4;
        
        CABasicAnimation *opacityAnimation = [CABasicAnimation animation];
        opacityAnimation.keyPath = @"opacity";
        opacityAnimation.fromValue = [NSNumber numberWithFloat:0.6];
        opacityAnimation.toValue = [NSNumber numberWithFloat:1.0];
        
        CAAnimationGroup *lastAnimation =[CAAnimationGroup animation];
        lastAnimation.animations = [NSArray arrayWithObjects:animation, roateanimation,opacityAnimation, nil];
        lastAnimation.duration = 0.5;
        lastAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        lastAnimation.removedOnCompletion = NO;
        lastAnimation.fillMode = kCAFillModeForwards;
        lastAnimation.delegate = self;
        [imageView.layer addAnimation:lastAnimation forKey:nil];
        imageView.center = imageView.endPoint;
    }
}


- (void)close {
    for (int i = 1; i < _nameArray.count; i ++) {
        ImageViewPoint *imageView = [self.view viewWithTag:100 + i];
        imageView.hidden = NO;
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathMoveToPoint(path, NULL, imageView.endPoint.x, imageView.endPoint.y);
        CGPathAddLineToPoint(path, NULL, imageView.farPoint.x, imageView.farPoint.y);
        CGPathAddLineToPoint(path, NULL, imageView.startPoint.x, imageView.startPoint.y);
        animation.path = path;
        CGPathRelease(path);
        animation.duration = .4;
        
        CABasicAnimation *roateanimation = [CABasicAnimation animation];
        roateanimation.keyPath = @"transform.rotation.z";
        roateanimation.fromValue = [NSNumber numberWithFloat:-M_PI * 2];
        roateanimation.toValue = [NSNumber numberWithFloat:M_PI * 2];
        roateanimation.duration = .4;
        
        CABasicAnimation *opacityAnimation = [CABasicAnimation animation];
        opacityAnimation.keyPath = @"opacity";
        opacityAnimation.toValue = [NSNumber numberWithFloat:0.0];
        
        
        CAAnimationGroup *lastAnimation =[CAAnimationGroup animation];
        lastAnimation.animations = [NSArray arrayWithObjects:animation, roateanimation, opacityAnimation, nil];
        lastAnimation.duration = 0.5;
        lastAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        lastAnimation.removedOnCompletion = NO;
        lastAnimation.fillMode = kCAFillModeForwards;
        lastAnimation.delegate = self;
        [imageView.layer addAnimation:lastAnimation forKey:nil];
        imageView.center = imageView.startPoint;
    }

}


#pragma mark ---CAAnimationDelegate
- (void)animationDidStart:(CAAnimation *)anim {
    
    _startBtn.enabled = NO;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
    _startBtn.enabled = YES;
    if (flag) {
        if (!_startBtn.selected) {
            for (int i = 1; i < _nameArray.count; i++) {
                ImageViewPoint *image = [self.view viewWithTag:100 + i];
                image.hidden = YES;
            }
        }
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
