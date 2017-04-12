//
//  ViewController.m
//  TextKit_Sample
//
//  Created by vcyber on 16/6/13.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "ViewController.h"
#import "MyAlertView.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dismiss"]];
    _imageView.frame = CGRectMake(0, 0, 200, 150);
    _imageView.center = CGPointMake(100, self.view.center.x);
    [self.view addSubview:_imageView];
    
    
    CGRect textViewRect = CGRectInset(self.view.bounds, 10, 20);
    NSTextStorage *storage = [[NSTextStorage alloc] initWithString:_textView.text];
    
    NSLayoutManager *manage = [[NSLayoutManager alloc] init];
    [storage addLayoutManager:manage];
    _container = [[NSTextContainer alloc] initWithSize:textViewRect.size];
    [manage addTextContainer:_container];
    
    [_textView removeFromSuperview];
    
    _textView = [[UITextView alloc] initWithFrame:textViewRect textContainer:_container];
//    [self.view addSubview:_textView];
    [self.view insertSubview:_textView belowSubview:_imageView];
    
    [storage beginEditing];
    
    NSDictionary *attrsDic = @{NSTextEffectAttributeName:NSTextEffectLetterpressStyle};
    NSMutableAttributedString *attrstr = [[NSMutableAttributedString alloc] initWithString:_textView.text attributes:attrsDic];
    [storage setAttributedString:attrstr];
    [self markWord:@"破" inTextStorage:storage];
    [self markWord:@"D" inTextStorage:storage];
    
    [storage endEditing];
    
    //图文混排
    _textView.textContainer.exclusionPaths = @[[self translateBezizerPath]];
    
}

- (UIBezierPath *)translateBezizerPath {
    CGRect imageRect = [self.textView convertRect:_imageView.frame fromView:self.view];
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:imageRect];
    return path;
}

- (IBAction)click:(id)sender {
    
    MyAlertView *alertView = [[MyAlertView alloc] initWithFrame:CGRectZero Name:@"赵日天" Phone:@"12345678910" Address:@"beijing"];
    [alertView show];
}

- (void)markWord:(NSString *)word inTextStorage:(NSTextStorage *)storage{
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:word options:0 error:nil];
    NSArray *matchs = [regex matchesInString:_textView.text options:0 range:NSMakeRange(0, [_textView.text length])];
    for (NSTextCheckingResult *match in matchs) {
        NSRange matchRange = [match range];
        [storage addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:matchRange];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
