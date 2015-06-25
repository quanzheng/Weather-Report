//
//  City.m
//  Weather
//
//  Created by 全政 on 15/6/23.
//  Copyright (c) 2015年 全政. All rights reserved.
//

#import "City.h"

@implementation City
- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    
    return self;
}

+ (instancetype)cityWithDict:(NSDictionary *)dict {
    return [[self  alloc] initWithDict:dict];
}

@end
