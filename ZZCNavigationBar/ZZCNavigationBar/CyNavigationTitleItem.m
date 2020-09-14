//
//  ZZCNavigationTitleItem.m
//  ZZCNavigationBar
//
//  Created by zzc-20170215 on 2018/1/25.
//  Copyright © 2018年 zzc-20170215. All rights reserved.
//

#import "CyNavigationTitleItem.h"
#import <Masonry/Masonry.h>

@implementation CyNavigationTitleItem

- (id)initWithCustomView:(UIView *)customView
{
    self = [super init];
    if (self)
    {
        _customView = customView;
        if (customView)
        {
            CyNavigationTitleView *aView = [[CyNavigationTitleView alloc] init];
            [aView addSubview:customView];
            
            _titleView = aView;
        }
    }
    return self;
}

- (id)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)setCustomView:(UIView *)customView{
    if (_customView) {
        return;
    }
    //为了兼容旧版本，新版本请使用initWithCustomView
    _customView = customView;
    if (customView)
    {
        CyNavigationTitleView *aView = [[CyNavigationTitleView alloc] init];
        [aView addSubview:customView];
        
        _titleView = aView;
    }
}

@end


@interface CyNavigationTitleView()



@end

@implementation CyNavigationTitleView

- (void)setMarkFrame:(CGRect)markFrame
{
    _markFrame = markFrame;
    if (self.applied && self.superview && [[[UIDevice currentDevice] systemVersion] floatValue]  >= 11)
    {
        @try {
            [self mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(@(self.markFrame.origin.x));
                make.top.equalTo(@(self.markFrame.origin.y));
                make.width.equalTo(@(self.markFrame.size.width));
                make.height.equalTo(@(self.markFrame.size.height));
            }];
        } @catch (NSException *exception) {
            
        } @finally {
            
        }
    }
}

- (void)setFrame:(CGRect)frame
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 11 && self.markFrame.size.width > 0)
    {
        [super setFrame:self.markFrame];
    }else
    {
        [super setFrame:frame];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.applied || [[[UIDevice currentDevice] systemVersion] floatValue]  < 11)
    {
        return;
    }
    
    if (self.superview)
    {
        @try {
            self.applied = YES;
            
            [self mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(@(self.markFrame.origin.x));
                make.top.equalTo(@(self.markFrame.origin.y));
                make.width.equalTo(@(self.markFrame.size.width));
                make.height.equalTo(@(self.markFrame.size.height));
            }];
        } @catch (NSException *exception) {
            
        } @finally {
            
        }
        
    }
}

@end
