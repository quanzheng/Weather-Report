//
//  TodayModel.m
//  Weather
//
//  Created by 全政 on 15/6/20.
//  Copyright (c) 2015年 全政. All rights reserved.
//

#import "TodayModel.h"

@implementation TodayModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}


- (NSString *)description {
    return [NSString stringWithFormat:@"city = %@, wendu = %@, ganmao = %@, forecast = %@", _city, _wendu, _ganmao, _forecast];
}
@end
