//
//  FirstView.m
//  Weather
//
//  Created by 全政 on 15/6/21.
//  Copyright (c) 2015年 全政. All rights reserved.
//

#import "FirstView.h"
#import "TodayModel.h"
#import "UUChart.h" // 折线统计图
#import "CutStringRetuneNumber.h"   // 温度字符串转整型
#import "GPUImage.h"    // 图片模糊框架
#define kSpace 5

@interface FirstView ()<UUChartDataSource, UIScrollViewDelegate>
{
    
    UUChart *chartView;
    
    NSArray *kHighArray;    // “高温22˚C”
    NSArray *kLowArray;
    
    NSArray *highInt;
    NSArray *lowInt;        // "22"
}

@end


@implementation FirstView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self loadAllViews];
    }
    return self;
}

- (void)loadAllViews {
    
    // 根据手机时间动态设定背景
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH"];
    NSString *date = [formatter stringFromDate:[NSDate date]];
    NSInteger da = [date integerValue];
    UIImage *blurredImage;
    if (da >= 6 && da <= 19) {
        GPUImageGaussianBlurFilter * blurFilter = [[GPUImageGaussianBlurFilter alloc] init];
        blurFilter.blurRadiusInPixels = 2.0;
        
        UIImage * image = [UIImage imageNamed:@"bg_image_qing.jpg"];
        blurredImage = [blurFilter imageByFilteringImage:image];
        
    } else {
        GPUImageGaussianBlurFilter * blurFilter = [[GPUImageGaussianBlurFilter alloc] init];
        blurFilter.blurRadiusInPixels = 2.0;
        UIImage * image = [UIImage imageNamed:@"bg_image.jpg"];
        blurredImage = [blurFilter imageByFilteringImage:image];
    }
    imageV.image = blurredImage;
    
    
    [self addSubview:imageV];
    
    self.backGround = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _backGround.contentSize = self.frame.size;
    _backGround.backgroundColor = [UIColor clearColor];


    [self addSubview:_backGround];
    
    // 城市名
    self.city = [[UILabel alloc] initWithFrame:CGRectMake(5, 20, 300, 60)];
    _city.textColor = [UIColor whiteColor];
    _city.font = [UIFont systemFontOfSize:60.f];
    _city.text = @"上海";
    [_backGround addSubview:_city];
    
    // 日期
    self.data = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_city.frame), CGRectGetMaxY(_city.frame)+kSpace, 100, 40)];
    _data.textColor = [UIColor whiteColor];
    _data.font = [UIFont systemFontOfSize:18.f];
    _data.text = @"2015-01-01";
    [_backGround addSubview:_data];
    
    // 温度
    self.wendu = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_data.frame)+kSpace, CGRectGetMaxY(_data.frame)+kSpace, 130, 80)];
    _wendu.textColor = [UIColor whiteColor];
    _wendu.font = [UIFont systemFontOfSize:100.f];
    _wendu.text = @"25";
    [_backGround addSubview:_wendu];
    UILabel *c = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_wendu.frame), CGRectGetMinY(_wendu.frame), 50, 50)];
    NSString *muStr = @"˚C";
    c.text = muStr;
    c.font = [UIFont systemFontOfSize:40.f];
    c.textColor = [UIColor whiteColor];
    [_backGround addSubview:c];
    
    
    // 感冒指数
    self.ganmao = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_city.frame), CGRectGetMaxY(_wendu.frame)+kSpace, [UIScreen mainScreen].bounds.size.width-10, 80)];
    _ganmao.textColor = [UIColor whiteColor];
    _ganmao.font = [UIFont systemFontOfSize:15.f];
    _ganmao.numberOfLines = 0;
    _ganmao.text = @"sncohseouchoschuosncioehclncidncidjkscuhfuwnclksnceifjcwiefwbvswvblsdvbuehlscnlscn";
    [_backGround addSubview:_ganmao];
    
    // 未来五日的天气背板
    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX (_city.frame), CGRectGetMaxY(_ganmao.frame)+kSpace, self.bounds.size.width-10, 400)];
    CGSize size = CGSizeMake([UIScreen mainScreen].bounds.size.width, CGRectGetMaxY(_bgView.frame)+80);
    self.backGround.contentSize = size;
    [self.backGround addSubview:_bgView];
    
}

- (void)setTodayModel:(TodayModel *)todayModel {
    _city.text = todayModel.city;
    _data.text = [todayModel.forecast[0] objectForKey:@"date"];
    _wendu.text = todayModel.wendu;
    _ganmao.text = todayModel.ganmao;
    
    
    // 将未来五日的天气分别取出，放入各自数组
    NSMutableArray *dataArray = [NSMutableArray array];
    NSMutableArray *fengliArray = [NSMutableArray array];
    NSMutableArray *fengxiangArray = [NSMutableArray array];
    NSMutableArray *highArray = [NSMutableArray array];
    NSMutableArray *lowArray = [NSMutableArray array];
    NSMutableArray *weatherArray = [NSMutableArray array];
    
    for (NSInteger i = 0; i < todayModel.forecast.count; i++) {
        [dataArray addObject: [todayModel.forecast[i] objectForKey:@"date"]];
        [fengliArray addObject: [todayModel.forecast[i] objectForKey:@"fengli"]];
        [fengxiangArray addObject: [todayModel.forecast[i] objectForKey:@"fengxiang"]];
        [highArray addObject: [todayModel.forecast[i] objectForKey:@"high"]];
        [lowArray addObject: [todayModel.forecast[i] objectForKey:@"low"]];
        [weatherArray addObject: [todayModel.forecast[i] objectForKey:@"type"]];
    }
   
    kHighArray = [NSArray arrayWithArray:highArray];
    kLowArray = [NSArray arrayWithArray:lowArray];
    
    // 判断背板上是否有视图，有的话，说明原来的视图没有被清理，防止视图重读叠加，清空背板视图
    if (_bgView.subviews != nil) {
        for (UIView *view in _bgView.subviews) {
            [view removeFromSuperview];
        }
    }
    // 创建未来五日的 日期、风力、 风向、高温、 低温、天气
    for (NSInteger j = 0; j < 5; j++) {
        // 单日背板
        UIView *singleView = [[UIView alloc] initWithFrame:CGRectMake(60*j+kSpace, 0, 60, _bgView.frame.size.height)];
        
        // 日期
        UILabel *date = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 20)];
        date.textAlignment = NSTextAlignmentCenter;
        date.font = [UIFont systemFontOfSize:10.f];
        date.text = dataArray[j];
        date.textColor = [UIColor whiteColor];
        [singleView addSubview:date];
        
        // 天气
        UILabel *weather = [[UILabel alloc] initWithFrame:CGRectMake(date.frame.origin.y, CGRectGetMaxY(date.frame)+kSpace, date.frame.size.width, date.frame.size.height)];
        weather.font = [UIFont systemFontOfSize:13.f];
        weather.textAlignment = NSTextAlignmentCenter;
        weather.text = weatherArray[j];
        weather.textColor = [UIColor whiteColor];
        [singleView addSubview:weather];
        
        // 风力
        UILabel *fengli = [[UILabel alloc] initWithFrame:CGRectMake(weather.frame.origin.x, CGRectGetMaxY(weather.frame)+kSpace, weather.frame.size.width, weather.frame.size.height)];
        fengli.font = [UIFont systemFontOfSize:10.f];
        fengli.textAlignment = NSTextAlignmentCenter;
        fengli.text = fengliArray[j];
        fengli.textColor = [UIColor whiteColor];
        [singleView addSubview:fengli];
        
        // 高温
        UILabel *high = [[UILabel alloc] initWithFrame:CGRectMake(fengli.frame.origin.x, CGRectGetMaxY(fengli.frame)+kSpace, fengli.frame.size.width, fengli.frame.size.height+20)];
        high.numberOfLines =0;
        high.font = [UIFont systemFontOfSize:15.f];
        high.textAlignment = NSTextAlignmentCenter;
        high.text = highArray[j];
        high.textColor = [UIColor whiteColor];
        [singleView addSubview:high];
        
        // 折线统计图
        [self configUI];
        // 低温
        UILabel *low = [[UILabel alloc] initWithFrame:CGRectMake(high.frame.origin.x, CGRectGetMaxY(high.frame)+100, high.frame.size.width, high.frame.size.height+20)];
        low.numberOfLines = 0;
        low.font = [UIFont systemFontOfSize:15.f];
        low.textAlignment = NSTextAlignmentCenter;
        low.text = lowArray[j];
        low.textColor = [UIColor whiteColor];
        [singleView addSubview:low];
        
        // 风向
        UILabel *fengxiang = [[UILabel alloc] initWithFrame:CGRectMake(low.frame.origin.x, CGRectGetMaxY(low.frame)+kSpace, low.frame.size.width, low.frame.size.height)];
        fengxiang.font = [UIFont systemFontOfSize:10.f];
        fengxiang.textAlignment = NSTextAlignmentCenter;
        fengxiang.text = fengxiangArray[j];
        fengxiang.textColor = [UIColor whiteColor];
        [singleView addSubview:fengxiang];
        
        [self.bgView addSubview:singleView];
        
    }
}

#pragma mark - 创建折线统计图
- (void)configUI {
    if (chartView) {
        [chartView removeFromSuperview];
        chartView = nil;
    }
    
    
    
    chartView = [[UUChart alloc] initwithUUChartDataFrame:CGRectMake(-10, 130, _bgView.frame.size.width-10, 80) withSource:self withStyle:UUChartLineStyle];
    chartView.backgroundColor = [UIColor clearColor];
    [chartView showInView:self.bgView];
    
    
}

#pragma mark @request
// 横坐标的坐标数
- (NSArray *)UUChart_xLableArray:(UUChart *)chart {
    return [self getXTitles:5];
}
- (NSArray *)getXTitles:(int)num
{
    NSMutableArray *xTitles = [NSMutableArray array];
    for (int i=0; i<num; i++) {
        NSString * str = [NSString stringWithFormat:@""];
        [xTitles addObject:str];
    }
    return xTitles;
}
// 纵坐标的坐标数
- (NSArray *)UUChart_yValueArray:(UUChart *)chart {
    
    NSArray *highArray =[NSArray arrayWithArray: highInt];
    NSArray *lowArray = [NSArray arrayWithArray: lowInt];
    return @[highArray, lowArray];
    
}

// 颜色数组
- (NSArray *)UUChart_ColorArray:(UUChart *)chart {
    return @[UURed, UUGreen];
    
}
// 显示数值范围
- (CGRange)UUChartChooseRangeInLineChart:(UUChart *)chart {
    NSMutableArray *hArray = [NSMutableArray array];
    NSMutableArray *lArray = [NSMutableArray array];
    
    for (NSInteger k = 0; k < kHighArray.count; k++) {
        NSString *h = [CutStringRetuneNumber inptuString:kHighArray[k]];
        NSString *l = [CutStringRetuneNumber inptuString:kLowArray[k]];
        [hArray addObject:h];
        [lArray addObject:l];
        
    }
    
    highInt = [NSArray arrayWithArray:hArray];
    lowInt = [NSArray arrayWithArray:lArray];

    NSString *max = @"0";
    NSString *min = @"50";
    for (NSInteger a = 0; a < highInt.count; a++) {
        if ([max compare: highInt[a]]<0) {
            max = highInt[a];
        }
        if ([min compare: lowInt[a]]>0) {
            min = lowInt[a];
        }
    }
    NSInteger a = [min integerValue];
    
    NSInteger b = [max integerValue];
    return CGRangeMake(b, a);
}


@end
