//
//  City.h
//  Weather
//
//  Created by 全政 on 15/6/23.
//  Copyright (c) 2015年 全政. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface City : NSObject

@property (nonatomic, copy) NSString *cityName;
@property (nonatomic, copy) NSString *cityID;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)cityWithDict:(NSDictionary *)dict;

@end
