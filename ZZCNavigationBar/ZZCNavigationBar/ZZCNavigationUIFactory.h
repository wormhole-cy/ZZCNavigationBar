//
//  ZZCNavigationUIFactory.h
//  ZZCNavigationBar
//
//  Created by Cyrus on 2019/12/18.
//  Copyright © 2019 zzc-20170215. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImage+CyNavBundle.h"
NS_ASSUME_NONNULL_BEGIN
#define ZZC_NAV_BAR_MORE_IMG [UIImage cyNav_imageNamedFromMyBundle:@"icon_topbar_more"]
#define ZZC_NAV_BAR_MORE_REDDOT_IMG [UIImage cyNav_imageNamedFromMyBundle:@"icon_topbar_more_red"]

#define ZZC_NAV_BAR_MORE_WHITE_IMG [UIImage cyNav_imageNamedFromMyBundle:@"icon_topbar_more_white"]
#define ZZC_NAV_BAR_MORE_WHITE_REDDOT_IMG [UIImage cyNav_imageNamedFromMyBundle:@"icon_topbar_more_white_red"]

#define ZZC_NAV_BAR_MORE_WHITE_GRAYBG_IMG [UIImage cyNav_imageNamedFromMyBundle:@"icon_topbar_more_circle"]
#define ZZC_NAV_BAR_MORE_WHITE_GRAYBG_REDDOT_IMG [UIImage cyNav_imageNamedFromMyBundle:@"icon_topbar_more_circle_red"]

#define ZZC_NAV_BAR_BACK_IMG [UIImage cyNav_imageNamedFromMyBundle:@"icon_topbar_back"]
#define ZZC_NAV_BAR_BACK_WHITE_IMG [UIImage cyNav_imageNamedFromMyBundle:@"icon_topbar_back_white"]
#define ZZC_NAV_BAR_BACK_WHITE_GRATBG_IMG [UIImage cyNav_imageNamedFromMyBundle:@"icon_topbar_back_circle"]

@interface ZZCNavigationUIFactory : NSObject

//begin**************租租车UI规范**********************//
/// 创建普通更多按钮
/// @param clicked 点击事件
+ (UIBarButtonItem *)barButtonItemMoreStyleWithClickedBlock:(void(^)(UIButton *sender))clicked;
///带红点的普通更多按钮
+ (UIBarButtonItem *)barButtonItemMoreRedDotStyleWithClickedBlock:(void(^)(UIButton *sender))clicked;

/// 创建白色更多按钮
/// @param clicked 点击事件
+ (UIBarButtonItem *)barButtonItemMoreWhiteStyleWithClickedBlock:(void(^)(UIButton *sender))clicked;
///带红点的白色更多按钮
+ (UIBarButtonItem *)barButtonItemMoreWhiteRedDotStyleWithClickedBlock:(void(^)(UIButton *sender))clicked;
///灰色背景更多按钮
+ (UIBarButtonItem *)barButtonItemMoreWhiteGrayBgStyleWithClickedBlock:(void(^)(UIButton *sender))clicked;
///带红点的灰色背景更多按钮
+ (UIBarButtonItem *)barButtonItemMoreWhiteGrayBgRedDotStyleWithClickedBlock:(void(^)(UIButton *sender))clicked;


/// 创建普通返回按钮
/// @param clicked 点击事件
+ (UIBarButtonItem *)barButtonItemBackStyleWithClickedBlock:(void(^)(UIButton *sender))clicked;

/// 创建白色返回按钮
/// @param clicked 点击事件
+ (UIBarButtonItem *)barButtonItemBackWhiteStyleWithClickedBlock:(void(^)(UIButton *sender))clicked;

/// 创建黑色背景的返回按钮
/// @param clicked 点击事件
+ (UIBarButtonItem *)barButtonItemBackWhiteGrayBgStyleWithClickedBlock:(void(^)(UIButton *sender))clicked;
//end**********************************************//

@end

NS_ASSUME_NONNULL_END
