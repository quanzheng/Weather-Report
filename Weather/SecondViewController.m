//
//  SecondViewController.m
//  Weather
//
//  Created by 全政 on 15/6/20.
//  Copyright (c) 2015年 全政. All rights reserved.
//

#import "SecondViewController.h"
#import "SecondView.h"
#import "HeaderView.h"
#import "ProvincesGroup.h"
#import "City.h"
enum {
    a,
    b,
    c
};
@interface SecondViewController ()<UITableViewDataSource, UITableViewDelegate, HeaderViewDelegate>

@property (nonatomic, strong) SecondView *secondView;

@property (nonatomic, strong) NSArray *allDataArray;    // 所有城市信息的数组

@end


@implementation SecondViewController

#pragma mark 懒加载数据
- (NSArray *)allDataArray {
    if (!_allDataArray) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"CityID.plist" ofType:nil];
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *mutableArray = [NSMutableArray arrayWithCapacity:array.count];
        for (NSDictionary *dict in array) {
            ProvincesGroup *proGroup = [ProvincesGroup ProvinceGroupWithDict:dict];
            [mutableArray addObject:proGroup];
        }
        _allDataArray = [NSMutableArray arrayWithArray:mutableArray];
        NSLog(@"allDataArray == %@",_allDataArray);
    }
    return _allDataArray;
}


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)loadView {
    self.secondView = [[SecondView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = _secondView;
}

- (void)viewDidLoad {
    UITableView *tableview = self.secondView.cityList;
    tableview.dataSource = self;
    tableview.delegate = self;
    tableview.tableFooterView = [[UIView alloc] init];
    tableview.sectionHeaderHeight = 40;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.secondView.cityName.text = [defaults objectForKey:@"cityName"];
    
    
    /**彩蛋：把数组元素倒序排列
     *
     *
     *
     **/
    NSMutableArray *array = [NSMutableArray arrayWithObjects:@"1",@"45" ,@"54" ,@"43",nil];
//    array = (NSMutableArray *)[[array reverseObjectEnumerator] allObjects] ;
    // 存放倒叙后的元素的数组
    NSMutableArray *reverseArray = [NSMutableArray array];
    for (NSInteger k = array.count-1; k >= 0; k--) {
        
        [reverseArray addObject:array[k]];
        
    }
    NSLog(@"array = %@",reverseArray);
}

#pragma mark - UITableViewDelegated Math
#pragma mark Data Source
#pragma mark 组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.allDataArray.count;
}

#pragma mark 每组行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    ProvincesGroup *group = self.allDataArray[section];
    NSInteger count = group.isOpen ? group.city.count : 0;
    return count;
    
}

#pragma mark cell上内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
    }
    
    ProvincesGroup *proGroup = self.allDataArray[indexPath.section];
    City *cityModel = proGroup.city[indexPath.row];
   
    
    cell.textLabel.text = cityModel.cityName;

    return cell;
}

#pragma mark Table View Delegated
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    HeaderView *header = [HeaderView headerView:tableView];
    header.delegate = self;
    header.groupModel = self.allDataArray[section];
    return header;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ProvincesGroup *proGroup = self.allDataArray[indexPath.section];
    City *cityModel = proGroup.city[indexPath.row];
    NSString *cityID = cityModel.cityID;
    NSString *cityName = cityModel.cityName;
    
    // 修改当前城市
    self.secondView.cityName.text = cityName;
    // 将选择的城市和id
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:cityID forKey:@"cityID"];
    [defaults setValue:cityName forKey:@"cityName"];
    [defaults synchronize];
    
    // 点击到了cell后，马上跳转回第一个控制器
    self.tabBarController.selectedIndex = 0;
    
}
- (void)clickView{
    NSLog(@"触摸了省");
    [_secondView.cityList reloadData];
}

@end
