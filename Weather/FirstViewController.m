//
//  FirstViewController.m
//  Weather
//
//  Created by 全政 on 15/6/20.
//  Copyright (c) 2015年 全政. All rights reserved.
//

#import "FirstViewController.h"
#import "FirstView.h"
#import "AFNetworking.h"
#import "APIFile.h"
#import "TodayModel.h"
#import "DIYGifHeader.h"
#import "MJRefresh.h"
@implementation FirstViewController
{
    NSMutableArray *futureModelArray;
    
}


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    
    return self;
}

- (void)loadView {
    self.firstScrollView = [[FirstView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = _firstScrollView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _firstScrollView.backGround.delegate = self;
    // 网络请求
    [self loadDate];
    // 添加下拉刷新控件
    [self addRefresh];
}
- (void)viewWillAppear:(BOOL)animated {
    [self loadDate];
}
#pragma mark - MJRefresh
- (void)addRefresh {
    UIScrollView *scrollView = self.firstScrollView.backGround;
    // 自定义刷新时的动态图
    scrollView.header = [DIYGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadDate)];
    // 自定义刷新文字
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadDate)];
    [header setTitle:@"松开获取当前气象信息" forState:MJRefreshStatePulling];
    [header setTitle:@"正在寻找最新气象信息" forState:MJRefreshStateRefreshing];
    [header setTitle:@"小全找到了这些信息" forState:MJRefreshStateNoMoreData];
    
    // 设置字体
    header.stateLabel.font = [UIFont systemFontOfSize:15];
    header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:14];
    header.stateLabel.textColor = [UIColor whiteColor];
    header.lastUpdatedTimeLabel.textColor = [UIColor whiteColor];
    
    scrollView.header = header;
    
    [scrollView.header beginRefreshing];
}


#pragma mark - Network Request
#pragma mark request
- (void)loadDate {
    NetworkRequest *request = [NetworkRequest shareInstance];
    request.delegated = self;
    NSUserDefaults *defaults  =[NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"cityID"] == nil) {
        [defaults setValue:@"101180708" forKey:@"cityID"];
        [defaults setValue:@"淅川" forKey:@"cityName"];
    }
    NSString * cityID = [defaults objectForKey:@"cityID"];
    [request requestWithUrl:WeatherMain andCity:cityID];
    NSLog(@"刷新");
}

#pragma mark - delegated meth
#pragma mark NetworkRequest Delegated: 解析json数据,并从model中赋值
- (void)jsonDataToDict:(NSData *)data {
    if (data == nil) {
        NSLog(@"网络有问题啊");
    } else {
        NSDictionary *dictJson = [NSJSONSerialization JSONObjectWithData:data
                                                             options:NSJSONReadingAllowFragments
                                                               error:nil];
    
        NSDictionary *dictToday = dictJson[@"data"];
   
        TodayModel *model = [TodayModel new];
        futureModelArray = [NSMutableArray array];
        [model setValuesForKeysWithDictionary:dictToday];
        for (NSDictionary *dic in model.forecast) {
            future *fuModel = [future new];
            [fuModel setValuesForKeysWithDictionary:dic];
            [futureModelArray addObject:fuModel];
        }
    
    
        dispatch_async(dispatch_get_main_queue(), ^{
            _firstScrollView.todayModel = model;
            // 结束刷新
            [self.firstScrollView.backGround.header endRefreshing];
            
        });

    }
    
    // 网络有问题，回到主线程结束刷新
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.firstScrollView.backGround.header endRefreshing];
    });
}


@end
