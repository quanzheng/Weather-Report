//
//  ProvincesGroup.h
//  Weather
//
//  Created by 全政 on 15/6/23.
//  Copyright (c) 2015年 全政. All rights reserved.
//

#import <Foundation/Foundation.h>
@class City;
@interface ProvincesGroup : NSObject

@property (nonatomic, copy) NSString *province;
@property (nonatomic, strong) NSArray *city;


@property (nonatomic, assign) BOOL isOpen;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)ProvinceGroupWithDict:(NSDictionary *)dict;
@end
