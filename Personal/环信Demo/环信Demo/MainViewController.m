//
//  MainViewController.m
//  环信Demo
//
//  Created by vcyber on 16/5/31.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "MainViewController.h"
#import "MessageListViewController.h"
#import "ContactListViewController.h"
#import "SettingViewController.h"
#import "Common.h"

@implementation MainViewController {
    MessageListViewController *_messageList;
    ContactListViewController *_contactList;
    SettingViewController *_setting;
    
    UIBarButtonItem *_addFriendItem;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setupUntreatedApplyCount) name:@"setupUntreatedApplyCount" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setupUnreadMessageCount) name:@"setupUnreadMessageCount" object:nil];
    
    [self setupSubviews];
    self.selectedIndex = 0;
    
//    UIButton *addButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
//    [addButton setImage:[UIImage imageNamed:@"add.png"] forState:UIControlStateNormal];
//    [addButton addTarget:_contactsVC action:@selector(addFriendAction) forControlEvents:UIControlEventTouchUpInside];
//    _addFriendItem = [[UIBarButtonItem alloc] initWithCustomView:addButton];
    
    [self setupUnreadMessageCount];
    [self setupUntreatedApplyCount];
    
}

- (void)setupUnreadMessageCount{
    
    
}

- (void)setupUntreatedApplyCount{
    
    
    
}


- (void)setupSubviews {
    
    self.tabBar.backgroundImage = [[UIImage imageNamed:@"tabbarBackground"] stretchableImageWithLeftCapWidth:25 topCapHeight:25];
    self.tabBar.selectionIndicatorImage = [[UIImage imageNamed:@"tabbarSelectBg"] stretchableImageWithLeftCapWidth:25 topCapHeight:25];
    
    _messageList = [[MessageListViewController alloc] init];
    _messageList.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"消息" image:[[UIImage imageNamed:@"tabbar_chats"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tabbar_chatsHL"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    UINavigationController *messageNav = [[UINavigationController alloc] initWithRootViewController:_messageList];
    
    _contactList = [[ContactListViewController alloc] init];
    _contactList.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"联系人" image:[[UIImage imageNamed:@"tabbar_contacts"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tabbar_contactsHL"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    UINavigationController *contactNav = [[UINavigationController alloc] initWithRootViewController:_contactList];
    
    _setting = [[SettingViewController alloc] init];
    _setting.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"设置" image:[[UIImage imageNamed:@"tabbar_setting"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tabbar_settingHL"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    UINavigationController *settingNav = [[UINavigationController alloc] initWithRootViewController:_setting];
    
    self.viewControllers = @[messageNav, contactNav, settingNav];
    
}

-(void)unSelectedTapTabBarItems:(UITabBarItem *)tabBarItem
{
    [tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                        [UIFont systemFontOfSize:14], NSFontAttributeName,[UIColor whiteColor],NSForegroundColorAttributeName,
                                        nil] forState:UIControlStateNormal];
}

-(void)selectedTapTabBarItems:(UITabBarItem *)tabBarItem
{
    [tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                        [UIFont systemFontOfSize:14],
                                        NSForegroundColorAttributeName,RGBACOLOR(0x00, 0xac, 0xff, 1),NSForegroundColorAttributeName,
                                        nil] forState:UIControlStateSelected];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
