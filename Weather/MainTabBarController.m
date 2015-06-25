//
//  MainTabBarController.m
//  Weather
//
//  Created by 全政 on 15/6/20.
//  Copyright (c) 2015年 全政. All rights reserved.
//

#import "MainTabBarController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
@implementation MainTabBarController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    FirstViewController *firstVC = [[FirstViewController alloc] init];
    
    firstVC.navigationItem.title = @"天气概览";
    UINavigationController *firstNVC = [[UINavigationController alloc] initWithRootViewController:firstVC];
    // 设置导航栏透明度
    firstNVC.navigationBar.translucent = NO;
    // 设置导航栏颜色
    firstNVC.navigationBar.barTintColor = RGBACOLOR(250, 255, 240, 1);
    firstNVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"天气概览" image:[UIImage imageNamed:@"weather"] tag:10];
    
    
    SecondViewController *secondVC = [[SecondViewController alloc] init];
    secondVC.navigationItem.title = @"城市选择";
    UINavigationController *secondNVC = [[UINavigationController alloc] initWithRootViewController:secondVC];
    secondNVC.navigationBar.barTintColor = RGBACOLOR(250, 255, 240, 1);
    secondNVC.navigationBar.translucent = NO;
    secondNVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"城市选择" image:[UIImage imageNamed:@"local"] tag:20];
    
    
    self.tabBar.translucent = NO;
    self.tabBar.barTintColor = RGBACOLOR(250, 255, 240, 1);
    NSArray *itemArray = @[firstNVC,secondNVC];
    self.viewControllers = itemArray;
    
    
    
}
@end
