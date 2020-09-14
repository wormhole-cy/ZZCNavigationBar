//
//  ZZCNavigationTitleItem.h
//  ZZCNavigationBar
//
//  Created by zzc-20170215 on 2018/1/25.
//  Copyright © 2018年 zzc-20170215. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CyNavigationTitleView;
@interface CyNavigationTitleItem : NSObject

/**
 用户自定义的视图
 */
@property (nonnull, nonatomic) UIView *customView;//为了兼容旧版本开放setter方法，只有customView为nil的时候有效

/**
 标题栏是否居中适配
 */
@property (nonatomic, assign) BOOL isHorizontalCenter;


/**
 这个是添加到导航栏的view
 */
@property (nonnull, nonatomic, readonly) CyNavigationTitleView *titleView;


- (nonnull id)initWithCustomView:(nonnull UIView *)customView;


@end


@interface CyNavigationTitleView : UIView

@property (nonatomic, assign) CGRect markFrame;

@property (nonatomic, assign) BOOL applied;


@end
