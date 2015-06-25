//
//  future.m
//  Weather
//
//  Created by 全政 on 15/6/21.
//  Copyright (c) 2015年 全政. All rights reserved.
//

#import "future.h"

@implementation future

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@,%@,%@,%@,%@,%@",_date, _fengli, _fengxiang, _high, _low, _type];
    
}
@end
