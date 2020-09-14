//
//  ZZCNavigationConfig.h
//  ZZCNavigationBar
//
//  Created by zzc-20170215 on 2018/1/24.
//  Copyright © 2018年 zzc-20170215. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CyNavigationTitleItem.h"

//全局默认配置参数
extern CGSize ZZCNavigationButtonImageSize;//按钮image显示的大小，默认是24x24
extern CGFloat ZZCNavigationButtonContentSpace;//两个按钮内容之间间隔，默认是16
extern CGFloat ZZCNavigationButtonContentEdge;///左右按钮imageView距离导航栏默认的边距，默认是16；按钮的宽默认是32，计算规则ZZCNavigationButtonImageSize.width + (ZZCNavigationButtonContentSpace/2和ZZCNavigationButtonContentEdge的最小值)

extern NSString * _Nullable ZZCNavigationLeftBackImageName;//返回按钮图片名称
extern NSString * _Nullable ZZCNavigationLeftPressBackImageName;//返回按钮高亮图片名称
extern NSDictionary * _Nullable ZZCNavigationTitleAttributes;//标题配置
extern BOOL ZZCNavigationHideNavigationBar;//默认是否隐藏导航栏
extern BOOL ZZCNavigationHidesBackButton;//默认是否隐藏返回按钮
extern CGFloat ZZCNavigationBarHeight;//设置导航栏高度

extern NSArray<NSString *> * _Nullable ZZCNavigationBarHookViewControllerBlackList;//配置hook vc类名黑名单，黑名单里面的类不会进行自动hook

@interface CyNavigationConfig : NSObject


/**
 导航栏上的按钮
 */
@property(nullable,nonatomic,copy) NSArray<UIBarButtonItem *> *leftBarButtonItems;
@property(nullable,nonatomic,copy) NSArray<UIBarButtonItem *> *rightBarButtonItems;

/**
 顶部悬浮的按钮（与导航栏存在时按钮位置一致，用于滑到顶部导航栏隐藏时，只支持自定义导航栏情况）
 */
@property(nullable,nonatomic,copy) NSArray<UIBarButtonItem *> *leftTopButtonItems;
@property(nullable,nonatomic,copy) NSArray<UIBarButtonItem *> *rightTopButtonItems;


/**
 默认的悬浮返回按钮
 */
@property(nullable,nonatomic,strong) UIBarButtonItem *backTopButtonItem;

/**
 默认的导航栏上返回按钮
 */
@property(nullable,nonatomic,readonly) UIBarButtonItem *backBarButtonItem;

/**
 标题
 */
@property (nullable, nonatomic, copy) NSString *title;

/**
 默认标题
 */
@property (nullable, nonatomic, strong) CyNavigationTitleItem *defaultTitleItem;

/**
 标题字体和颜色配置
 */
@property (nullable, nonatomic, copy) NSDictionary *titleAttributes;

/**
 配置titleview，为了移除iOS11的autolayout警告，当左右按钮不存在时候，边距最小间隔为8
 */
@property (nullable, nonatomic, strong) CyNavigationTitleItem *titleItem;

/**
 自定义返回按钮图片，图片名字
 */
@property (nullable, nonatomic, strong) UIImage *backImage;

/**
 自定义当前页面的导航栏背景样式
 */
@property (nullable, nonatomic, strong) UIView *backgroundView;

/**
 自定义当前页面的导航栏背景图片
 */
@property (nullable, nonatomic, strong) UIImage *backgroundImage;

/**
 自定义当前页面的导航栏背景颜色
 */
@property (nullable, nonatomic, strong) UIColor *backgroundColor;


/**
 隐藏默认的返回按钮
 */
@property (nonatomic, assign) BOOL hidesBackButton;

/**
 移除导航栏
 */
@property (nonatomic, assign) BOOL hideNavigationBar;


/**
 是否禁止系统右滑返回手势
 */
@property (nonatomic, assign) BOOL popGestureRecognizerClose;

/**
 hook掉返回按钮点击事件
 */
@property (nullable, nonatomic, copy) void(^backButtonAction)(void);

/**
 是否自定义导航栏，如果ZZCNavigationBarHeight>0，则customNavigationBar固定为YES
 */
@property (nonatomic, assign) BOOL customNavigationBar;

/**
 隐藏导航栏底部线
 */
@property (nonatomic, assign) BOOL hideBarBottomLine;


@property (nullable, nonatomic, strong) CyNavigationTitleItem *loadStatusItem;


@property (nullable, nonatomic, strong) CyNavigationTitleItem *failStatusItem;

@property (nonatomic, assign) BOOL hideUINavigationBar;


- (BOOL)isHideUINavigationBar;

@end
