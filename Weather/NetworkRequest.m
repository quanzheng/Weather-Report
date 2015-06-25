//
//  NetworkRequest.m
//  Weather
//
//  Created by 全政 on 15/6/21.
//  Copyright (c) 2015年 全政. All rights reserved.
//

#import "NetworkRequest.h"

@implementation NetworkRequest
static NetworkRequest *net = nil;

+ (NetworkRequest *)shareInstance {
    if (net == nil) {
        net = [[[self class] alloc] init];
        
    }
    return net;
}

- (void)requestWithUrl:(NSString *)url andCity:(NSString *)cityNO {
    NSString *urlSt = [NSString stringWithFormat:@"%@%@", url, cityNO];
    NSURL *link = [NSURL URLWithString:urlSt];
    NSURLRequest *request = [NSURLRequest requestWithURL:link cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:5];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue new] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
       
        if ([self.delegated respondsToSelector:@selector(jsonDataToDict:)] && self.delegated != nil) {
            [_delegated jsonDataToDict:data];
        }
        
    }];
}
@end
