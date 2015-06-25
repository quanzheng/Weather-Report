//
//  FirstView.h
//  Weather
//
//  Created by 全政 on 15/6/21.
//  Copyright (c) 2015年 全政. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TodayModel;
@interface FirstView : UIView
@property (nonatomic, strong) UIScrollView *backGround;
@property (nonatomic, strong) UILabel *city;
@property (nonatomic, strong) UILabel *data;
@property (nonatomic, strong) UILabel *wendu;
@property (nonatomic, strong) UILabel *ganmao;
@property (nonatomic, strong) UILabel *futrue;


@property (nonatomic, strong) TodayModel *todayModel;

@property (nonatomic, strong) UIView *bgView;
@end
