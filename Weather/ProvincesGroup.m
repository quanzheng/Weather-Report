//
//  ProvincesGroup.m
//  Weather
//
//  Created by 全政 on 15/6/23.
//  Copyright (c) 2015年 全政. All rights reserved.
//

#import "ProvincesGroup.h"
#import "City.h"
@implementation ProvincesGroup

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        NSMutableArray *muArray = [NSMutableArray array];
        for (NSDictionary *dic in self.city) {
            City *city = [City cityWithDict:dic];
            [muArray addObject:city];
        }
        self.city = muArray;
    }
    return self;
}

+ (instancetype)ProvinceGroupWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}
@end
