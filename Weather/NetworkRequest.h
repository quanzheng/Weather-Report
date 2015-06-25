//
//  NetworkRequest.h
//  Weather
//
//  Created by 全政 on 15/6/21.
//  Copyright (c) 2015年 全政. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NetworkRequestDelegated <NSObject>

- (void)jsonDataToDict:(NSData *)data;


@end

@interface NetworkRequest : NSObject

@property (nonatomic, assign) id<NetworkRequestDelegated>delegated;



+ (NetworkRequest *)shareInstance;
- (void)requestWithUrl:(NSString *)url andCity:(NSString *)cityNO;

@end
