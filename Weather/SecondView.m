//
//  SecondView.m
//  Weather
//
//  Created by 全政 on 15/6/23.
//  Copyright (c) 2015年 全政. All rights reserved.
//

#import "SecondView.h"

@implementation SecondView
{
    UILabel *tishi;
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self loadAllViews];
    }
    return self;
    
}

- (void)loadAllViews {
    tishi = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 100, 30)];
    tishi.text = @"当前城市:";
    [self addSubview:tishi];
    
    self.cityName = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(tishi.frame)+3, tishi.frame.origin.y, 60, 30)];
    _cityName.text = @"上海";
    [self addSubview:_cityName];
    
    self.cityList = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_cityName.frame), [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - CGRectGetMaxY(_cityName.frame)) style:UITableViewStylePlain];
    [self addSubview:_cityList];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
