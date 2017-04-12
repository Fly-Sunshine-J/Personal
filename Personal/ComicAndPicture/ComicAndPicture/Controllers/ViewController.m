//
//  ViewController.m
//  ComicAndPicture
//
//  Created by MS on 16/3/3.
//  Copyright © 2016年 JFY. All rights reserved.
//

#import "ViewController.h"
#import "RecordManager.h"
#import "ComicModel.h"
#import "DetailViewController.h"
#import <MMProgressHUD.h>
#import "DownloadedCell.h"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createNavBar];
    
    self.tableView.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
    
}


- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = YES;
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:143 / 255.0 green:119 / 255.0 blue:181 / 255.0 alpha:1];
    
    self.navigationController.navigationBarHidden = NO;
    
    NSMutableArray *array = [[RecordManager defaultManager] searchAllByIsCollection:self.collection Read:self.read Download:self.download Downloading:self.downloading];
    
    if (array.count > 0) {
        
        self.dataArray = array;
        
        [self.tableView reloadData];
    }else {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, HEIGHT / 2- 20 , WIDTH, 40)];
        
        label.textAlignment = NSTextAlignmentCenter;
        
        if (self.read) {
            
            label.text = @"你还没有看过任何漫画";
            
        }else if (self.download) {
            
            label.text = @"你还没有下载过任何漫画";
            
        }else if (self.collection) {
            
            label.text = @"你还没有收藏过任何漫画";
            
        }
        
        self.tableView.hidden = YES;
        
        [self.view addSubview:label];
        
    }
    
    
}


- (void)createNavBar {
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    leftBtn.frame = CGRectMake(0, 0, 30, 30);
    
    [leftBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    
    [leftBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    
    self.navigationItem.leftBarButtonItem = leftItem;
    
}


- (void)back {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBarHidden = YES;
    
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    
    self.tabBarController.tabBar.hidden = NO;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.navigationItem.title isEqualToString:@"已下载"]) {

        DownloadedCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DOWNLOAD"];
        
        if (!cell) {
            
            cell = [[DownloadedCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DOWNLOAD"];
            
        }
        
        ComicModel *model = self.dataArray[indexPath.row];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivePrgoress:) name:model.comicId object:nil];
        
        [cell configCellWithModel:model];
        
        if (model.downloading) {
            
            cell.progressLabel.text = [NSString stringWithFormat:@"%d%%",(int)(model.progress * 100)];
            
            cell.progressView.progress = model.progress;
            
        }else {
            
            cell.progressLabel.text = @"100%";
            
            cell.progressView.progress = 1.0;
            
        }
        
        return cell;
        
    }else {
        
        ComicCell *cell = [ComicCell cellWithTableView:tableView];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell configCellWithModel:self.dataArray[indexPath.row]];
        
        return cell;
    }
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    DetailViewController *detail = [[DetailViewController alloc] init];
    
    detail.model = self.dataArray[indexPath.row];
    
    detail.downloaded = [[RecordManager defaultManager] searchDataWithModelId:detail.model.comicId IsDownload:YES];
    
    [self.navigationController pushViewController:detail animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.navigationItem.title isEqualToString:@"已下载"]) {
    
        return 190;
    
    }else {
        
        return 160;
    }
    
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {

    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        ComicModel *model = self.dataArray[indexPath.row];
        
        if ([self.navigationItem.title isEqualToString:@"我的收藏"]) {
            
            [[RecordManager defaultManager] deleteDataWithModelId:model.comicId IsCollection:YES];
            
        }else if ([self.navigationItem.title isEqualToString:@"已阅读"]) {
            
            [[RecordManager defaultManager] deleteDataWithModelId:model.comicId IsRead:YES];
            
        } else if ([self.navigationItem.title isEqualToString:@"已下载"]) {
            
            [MMProgressHUD showWithTitle:@"正在删除"];
            
            [[RecordManager defaultManager] deleteDataWithModelId:model.comicId IsDownload:YES];

        }
        
        [self.dataArray removeObjectAtIndex:indexPath.row];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
        [MMProgressHUD dismissWithSuccess:@"删除完成"];
    }
}


- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return @"删除";
    
}


#pragma mark ----NSNotification

- (void)receivePrgoress:(NSNotification *)notifacation {
    
    ComicModel *valueModel = notifacation.object;
    
    for (ComicModel *model in self.dataArray) {
        
        if ([model.comicId isEqualToString:valueModel.comicId]) {
            
            model.progress = valueModel.progress;
            
        }
        
    }
    
    [self.tableView reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
