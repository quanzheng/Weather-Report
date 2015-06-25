//
//  DIYGifHeader.m
//  Weather
//
//  Created by 全政 on 15/6/23.
//  Copyright (c) 2015年 全政. All rights reserved.
//

#import "DIYGifHeader.h"

@implementation DIYGifHeader

#pragma mark 重写父类方法
- (void)prepare {
    [super prepare];
    
    // 普通状态的图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (int num = 1; num <= 8; num++) {
        NSString *string = [NSString stringWithFormat:@"refresh－%d",num];
        
        UIImage *idleImage = [UIImage imageNamed:string];
        [idleImages addObject:idleImage];
    }
    [self setImages:idleImages forState:MJRefreshStateIdle];
    
    // 即将刷新的图片
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (int num = 1; num <= 8; num++) {
         NSString *string = [NSString stringWithFormat:@"refresh－%d",num];
        UIImage *refresh = [UIImage imageNamed:string];
        [refreshingImages addObject:refresh];
    }
    [self setImages:refreshingImages forState:MJRefreshStateWillRefresh];
    
    // 正在刷新中的图片
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
