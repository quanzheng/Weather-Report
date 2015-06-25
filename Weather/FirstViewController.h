//
//  FirstViewController.h
//  Weather
//
//  Created by 全政 on 15/6/20.
//  Copyright (c) 2015年 全政. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FirstView;
#import "NetworkRequest.h"
@interface FirstViewController : UIViewController< NetworkRequestDelegated, UIScrollViewDelegate>
@property (nonatomic, strong) FirstView *firstScrollView;

@end
