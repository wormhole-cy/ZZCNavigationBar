//
//  UIViewController+CyNavigationBar.h
//  ZZCNavigationBar
//
//  Created by zzc-20170215 on 2018/1/23.
//  Copyright © 2018年 zzc-20170215. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CyNavigationConfig.h"
#import "CyNavigationConfig+ScrollView.h"
#import "CyNavigationControllerConfig.h"
#import "CyViewControllerConfig.h"
/**
 设置此导航栏下的所有viewcontroller支持这个库的配置
 */
 void cy_registerNavigationController(UINavigationController *nvc, CyNavigationControllerConfig *delgate);

@interface UIViewController (CyNavigationBar)

@property (nonatomic, copy) CyNavigationConfig *navigationConfig;//为了兼容旧版，开放setter方法，但是是无效的

@property (nonatomic, readonly) UIView *navigationBar;

@property (nonatomic, assign) UIStatusBarStyle vc_statusBarStyle;

@property (nonatomic, strong) CyViewControllerConfig *viewControllerConfig NS_DEPRECATED_IOS(2_0, 2_0, "Please use statusBarStyle instead");//为了兼容旧版本保留

@property (nonatomic, assign, readonly) BOOL vc_isInTopStack;


- (void)leftBarButtonAct;

- (void)showNavigationBarLoadStatus;

- (void)showNavigationBarFailStatus;

- (void)showNaigationBarTitleStatus;

- (void)removeNavigationBarLoadStatus;

- (void)removeNavigationBarFailStatus;

- (void)cy_scrollToContentOffset:(CGFloat)offset;


@end


@interface UINavigationController (CyNavigationBar)

@property (nonatomic, weak) CyNavigationControllerConfig *cyConfig;

- (BOOL)cy_isRegister;

- (void)cy_hookNavigationController NS_DEPRECATED_IOS(2_0, 2_0, "Please use cy_registerNavigationController instead");//兼容旧版开放api

@end

