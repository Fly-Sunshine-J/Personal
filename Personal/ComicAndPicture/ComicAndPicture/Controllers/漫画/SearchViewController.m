//
//  SearchViewController.m
//  ComicAndPicture
//
//  Created by MS on 16/3/4.
//  Copyright © 2016年 JFY. All rights reserved.
//

#import "SearchViewController.h"
#import "ComicModel.h"
#import "ComicCell.h"
#import <MMProgressHUD.h>
#import "NSString+URLCode.h"
#import "YZDisplayViewHeader.h"

@interface SearchViewController ()<UITextFieldDelegate>{
    
    UITextField *_searchNameField;
    
    UILabel *_textLabel;
    
    BOOL _flag;
    
    BOOL _hidden;
    
}

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.frame = CGRectMake(0, 40, WIDTH, HEIGHT -64 - 44 - 48);
    
    _hidden = YES;
    
    [self createUI];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backKeyboard) name:YZDisplayViewClickOrScrollDidFinshNote object:nil];
}


- (void)backKeyboard {

        [_searchNameField resignFirstResponder];

}


- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.tableView.hidden = _hidden;
    
    [_searchNameField becomeFirstResponder];

}


- (void)createUI {
    
    _searchNameField = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, WIDTH - 100, 30)];
    
    _searchNameField.borderStyle = UITextBorderStyleRoundedRect;
    
    _searchNameField.placeholder = @"请输入搜索关键词";
    
    _searchNameField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    _searchNameField.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"search"]];
    
    _searchNameField.leftViewMode = UITextFieldViewModeAlways;
    
    _searchNameField.delegate = self;
    
    [self.view addSubview:_searchNameField];
    
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    searchButton.frame = CGRectMake(CGRectGetMaxX(_searchNameField.frame) + 10, 10, 70, 30);
    
    [searchButton setTitle:@"搜索" forState:UIControlStateNormal];
    
    searchButton.backgroundColor = [UIColor colorWithRed:249 / 255.0 green:204 / 255.0 blue:226 / 255.0 alpha:1];
    
    [searchButton addTarget:self action:@selector(searchComic:) forControlEvents:UIControlEventTouchUpInside];
    
    [searchButton setImage:[UIImage imageNamed:@"buttonSearchImage"] forState:UIControlStateNormal];
    
    [self.view addSubview:searchButton];
    
    _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 30)];
    
    _textLabel.text = @"未搜到结果，为你推荐热搜:";
    
    _textLabel.textColor = [UIColor redColor];
    
}


- (void)searchComic:(UIButton *)btn {
    
    _hidden = NO;
    
    [self.dataArray removeAllObjects];
    
    [self.view endEditing:YES];
    
    [MMProgressHUD showWithTitle:@"努力加载中" status:@"努力加载中" images:@[[UIImage imageNamed:@"loading_teemo_1"], [UIImage imageNamed:@"loading_teemo_2"]]];
    
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleShrink];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:self.urlString, [_searchNameField.text URLEncodedString]];
    
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
       
        _flag = YES;
        
        NSDictionary *rootDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        NSArray *array = rootDic[@"results"];
        
        for (NSDictionary *dict in array) {
            
            ComicModel *model = [[ComicModel alloc] init];
            
            [model setValuesForKeysWithDictionary:dict];
            
            [self.dataArray addObject:model];
            
        }
        
        self.tableView.hidden = _hidden;
        
        if ([rootDic[@"extraInfo"][@"otherType"] isEqualToNumber: @1]) {

            self.tableView.tableHeaderView = nil;
            
        }else {
            
            self.tableView.tableHeaderView = _textLabel;
            
        }
        
         [MMProgressHUD dismissWithSuccess:@"加载完成"];
        
        [self.tableView reloadData];
        
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
        [MMProgressHUD dismissWithError:error.localizedDescription afterDelay:2];
        _flag = YES;
        
        [self.tableView.mj_footer endRefreshing];
        
        if (self.isPulling) {
            
            [self.tableView.mj_header endRefreshing];
            
        }else {
            
            [self.tableView.mj_footer endRefreshing];
            
        }
        
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if (!_flag) {
            
            if (self.isPulling) {
                
                [self.tableView.mj_header endRefreshing];
                
            }else {
                
                [self.tableView.mj_footer endRefreshing];
                
            }
            
            [MMProgressHUD dismissWithError:@"网络较慢,请耐心等待一会"];
            
        }
    });
    
}


- (BOOL)textFieldShouldClear:(UITextField *)textField {
    
    _hidden = YES;
    
    self.tableView.hidden = _hidden;
    
    return YES;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ComicCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    
    if (!cell) {
        
        cell = [[ComicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
        
    }
    
    ComicModel *model = self.dataArray[indexPath.row];
    
    [cell configSearchCellWithModel:model];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
    
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
