//
//  TodayModel.h
//  Weather
//
//  Created by 全政 on 15/6/20.
//  Copyright (c) 2015年 全政. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "future.h"
@interface TodayModel : NSObject
@property (nonatomic, copy) NSString *city;

@property (nonatomic, copy) NSString *ganmao;
@property (nonatomic, copy) NSString *wendu;
@property (nonatomic, strong) NSArray *forecast;




@end
