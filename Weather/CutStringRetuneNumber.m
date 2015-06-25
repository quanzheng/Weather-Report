//
//  CutStringRetuneNumber.m
//  Weather
//
//  Created by 全政 on 15/6/22.
//  Copyright (c) 2015年 全政. All rights reserved.
//

#import "CutStringRetuneNumber.h"

@implementation CutStringRetuneNumber
+ (NSString *)inptuString:(NSString *)string {
    NSRange range = {3,2};
    NSString * integer = [string substringWithRange:range];
   
    return integer;
    
}
@end
